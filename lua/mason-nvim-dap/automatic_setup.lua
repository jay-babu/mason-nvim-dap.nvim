local settings = require('mason-nvim-dap.settings')
local Optional = require('mason-core.optional')

local allowed = settings.current.automatic_setup == true

return function()
	if not allowed then
		return
	end

	local adapters = require('mason-nvim-dap.mappings.adapters')
	local adapter_to_config = require('mason-nvim-dap.mappings.adapter_to_config')
	local config_mappings = require('mason-nvim-dap.mappings.configurations')

	local dap = require('dap')
	for _, source_identifier in ipairs(settings.current.ensure_installed) do
		Optional.of_nilable(adapters[source_identifier]):map(function(adapter_config)
			local adapter = {
				[source_identifier] = adapter_config,
			}
			dap.adapters = vim.tbl_deep_extend('force', adapter, dap.adapters)
			local configs = adapter_to_config[source_identifier]
			for _, config_name in ipairs(configs) do
				local config = config_mappings[config_name]
				local configuration = {
					[config_name] = config,
				}
				dap.configurations = vim.tbl_deep_extend('force', configuration, dap.configurations)
			end
		end)
	end
end
