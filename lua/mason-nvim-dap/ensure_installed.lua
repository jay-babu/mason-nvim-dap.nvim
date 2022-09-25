local settings = require('mason-nvim-dap.settings')

---@param nvim_dap_adapter_name string
local function resolve_package(nvim_dap_adapter_name)
	local registry = require('mason-registry')
	local Optional = require('mason-core.optional')
	local source_mappings = require('mason-nvim-dap.mappings.source')

	return Optional.of_nilable(source_mappings.nvim_dap_to_package[nvim_dap_adapter_name]):map(function(package_name)
		local ok, pkg = pcall(registry.get_package, package_name)
		if ok then
			return pkg
		end
	end)
end

return function()
	for _, source_identifier in ipairs(settings.current.ensure_installed) do
		local Package = require('mason-core.package')

		local source_name, version = Package.Parse(source_identifier)
		resolve_package(source_name):if_present(
			-- -@param pkg Package
			function(pkg)
				if not pkg:is_installed() then
					vim.notify(('[mason-nvim-dap] installing %s'):format(pkg.name))
					pkg:install({
						version = version,
					}):once(
						'closed',
						vim.schedule_wrap(function()
							if pkg:is_installed() then
								vim.notify(('[mason-nvim-dap] %s was installed'):format(pkg.name))
							end
						end)
					)
				end
			end
		)
	end
end
