local log = require('mason-core.log')
local _ = require('mason-core.functional')

local M = {}

function M.setup(config)
	local settings = require('mason-nvim-dap.settings')

	if config then
		settings.set(config)
	end

	-- NOTE: this is left here for future porting in case needed
	-- local ok, err = pcall(function()
	--     require "mason-lspconfig.lspconfig_hook"()
	--     require "mason-lspconfig.server_config_extensions"()
	-- end)
	-- if not ok then
	--     log.error("Failed to set up lspconfig integration.", err)
	-- end

	if #settings.current.ensure_installed > 0 then
		require('mason-nvim-dap.ensure_installed')()
	end

	if settings.current.automatic_installation then
		require('mason-nvim-dap.automatic_installation')()
	end

	require('mason-nvim-dap.api.command')
end

---@return string[]
function M.get_installed_sources()
	local Optional = require('mason-core.optional')
	local registry = require('mason-registry')
	local source_mappings = require('mason-nvim-dap.mappings.source')

	return _.filter_map(function(pkg_name)
		return Optional.of_nilable(source_mappings.package_to_nvim_dap[pkg_name])
	end, registry.get_installed_package_names())
end

---Get a list of available sources in mason-registry
---@param filter { filetype: string | string[] }?: (optional) Used to filter the list of source names.
--- The available keys are
---   - filetype (string | string[]): Only return sources with matching filetype
---@return string[]
function M.get_available_sources(filter)
	local registry = require('mason-registry')
	local source_mappings = require('mason-nvim-dap.mappings.source')
	local Optional = require('mason-core.optional')
	filter = filter or {}
	local predicates = {}

	-- if filter.filetype then
	-- 	table.insert(predicates, is_source_in_filetype(filter.filetype))
	-- end

	return _.filter_map(function(pkg_name)
		return Optional.of_nilable(source_mappings.package_to_nvim_dap[pkg_name]):map(function(source_name)
			if #predicates == 0 or _.all_pass(predicates, source_name) then
				return source_name
			end
		end)
	end, registry.get_all_package_names())
end

return M
