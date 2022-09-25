local _ = require('mason-core.functional')
local settings = require('mason-nvim-dap.settings')

local function auto_get_packages()
	local sources = {}
	sources = vim.list_extend(sources, vim.tbl_keys(require('dap').adapters))
	local tools = _.uniq_by(_.identity, sources)
	return tools
end

---@param dap_adapter_name string
local function resolve_package(dap_adapter_name)
	local registry = require('mason-registry')
	local Optional = require('mason-core.optional')
	local source_mappings = require('mason-nvim-dap.mappings.source')

	return Optional.of_nilable(source_mappings.nvim_dap_to_package[dap_adapter_name]):map(function(package_name)
		local ok, pkg = pcall(registry.get_package, package_name)
		if ok then
			return pkg
		end
	end)
end

local function difference(a, b)
	if b == nil then
		return a
	end
	local aa = {}
	for _, v in pairs(a) do
		aa[v] = true
	end
	for _, v in pairs(b) do
		aa[v] = nil
	end

	local ret = {}
	local n = 0
	for _, v in pairs(a) do
		if aa[v] then
			n = n + 1
			ret[n] = v
		end
	end
	return ret
end

return function()
	local sources = auto_get_packages()
	local auto_install = settings.current.automatic_installation
	if type(auto_install) == 'table' then
		sources = difference(sources, auto_install.exclude)
	end

	for _, source_identifier in ipairs(sources) do
		local Package = require('mason-core.package')

		local source_name, version = Package.Parse(source_identifier)
		resolve_package(source_name):if_present(
			-- -@param pkg Package
			function(pkg)
				if not pkg:is_installed() then
					vim.notify(('[mason-nvim-dap] automatically installing %s'):format(pkg.name))
					pkg:install({
						version = version,
					}):once(
						'closed',
						vim.schedule_wrap(function()
							if pkg:is_installed() then
								vim.notify(('[mason-nvim-dap] %s was automatically installed'):format(pkg.name))
							end
						end)
					)
				end
			end
		)
	end
end
