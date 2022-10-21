local Optional = require('mason-core.optional')

-- @param adapters_required string[]
return function(adapters_required)
	local adapters = require('mason-nvim-dap.mappings.adapters')
	local filetypes = require('mason-nvim-dap.mappings.filetypes')
	local configurations = require('mason-nvim-dap.mappings.configurations')

	local dap = require('dap')
	for _, adapter in ipairs(adapters_required) do
		Optional.of_nilable(adapters[adapter]):map(function(adapter_config)
			dap.adapters[adapter] = adapter_config
			local configuration = configurations[adapter] or {}
			if not vim.tbl_isempty(configuration) then
				for _, filetype in ipairs(filetypes[adapter]) do
					dap.configurations[filetype] = vim.list_extend(dap.configurations[filetype] or {}, configuration)
				end
			end
		end)
	end
end
