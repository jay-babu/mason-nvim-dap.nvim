local log = require('mason-core.log')
local _ = require('mason-core.functional')

local M = {}

-- Currently this only needs to be evaluated for the same list passed in.
--- @param config table
M.default_setup = function(config)
	return require('mason-nvim-dap.automatic_setup')(config)
end

---@param handlers table<string, fun(source_name: string, methods: string[])> | nil
---@return nil
local function setup_handlers(handlers)
	handlers = handlers or {}
	local Optional = require('mason-core.optional')
	local source_mappings = require('mason-nvim-dap.mappings.source')
	local registry = require('mason-registry')
	local notify = require('mason-core.notify')

	_.each(function(handler)
		if type(handler) == 'string' and not source_mappings.nvim_dap_to_package[handler] then
			notify(
				('mason-nvim-dap.setup_handlers: Received handler for unknown dap source name: %s.'):format(handler),
				vim.log.levels.WARN
			)
		end
	end, _.keys(handlers))

	---@param pkg_name string
	local function get_source_name(pkg_name)
		return Optional.of_nilable(source_mappings.package_to_nvim_dap[pkg_name])
	end

	local installed_sources = _.filter_map(get_source_name, registry.get_installed_package_names())

	local default_handler = Optional.of_nilable(handlers[1]):or_(_.always(Optional.of_nilable(M.default_setup)))

	local function call_handler(adapter_name)
		log.fmt_trace('Checking handler for %s', adapter_name)
		Optional.of_nilable(handlers[adapter_name]):or_(_.always(default_handler)):if_present(function(handler)
			log.fmt_trace('Calling handler for %s', adapter_name)
			local adapters = require('mason-nvim-dap.mappings.adapters')
			local filetypes = require('mason-nvim-dap.mappings.filetypes')
			local configurations = require('mason-nvim-dap.mappings.configurations')

			local config = {
				name = adapter_name,
				adapters = adapters[adapter_name],
				configurations = configurations[adapter_name],
				filetypes = filetypes[adapter_name],
			}

			local ok, err = pcall(handler, config)
			if not ok then
				vim.notify(err, vim.log.levels.ERROR)
			end
		end)
	end

	_.each(call_handler, installed_sources)
	registry:on(
		'package:install:success',
		vim.schedule_wrap(function(pkg)
			get_source_name(pkg.name):if_present(call_handler)
		end)
	)
end

---@param config MasonNvimDapSettings | nil
function M.setup(config)
	local settings = require('mason-nvim-dap.settings')

	if config then
		settings.set(config)
	end

	if #settings.current.ensure_installed > 0 then
		require('mason-nvim-dap.ensure_installed')()
	end

	if settings.current.automatic_installation then
		require('mason-nvim-dap.automatic_installation')()
	end

	if settings.current.handlers then
		setup_handlers(settings.current.handlers)
	end

	local dap_vscode = require('dap.ext.vscode')
	dap_vscode.type_to_filetypes =
		vim.tbl_deep_extend('force', dap_vscode.type_to_filetypes, require('mason-nvim-dap.mappings.filetypes'))

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

	return _.filter_map(function(pkg_name)
		return Optional.of_nilable(source_mappings.package_to_nvim_dap[pkg_name]):map(function(source_name)
			if #predicates == 0 or _.all_pass(predicates, source_name) then
				return source_name
			end
		end)
	end, registry.get_all_package_names())
end

return M
