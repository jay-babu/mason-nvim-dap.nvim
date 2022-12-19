local Optional = require('mason-core.optional')
local _ = require('mason-core.functional')

-- @param adapter string
return _.memoize(function(adapter)
	local adapters = require('mason-nvim-dap.mappings.adapters')
	local filetypes = require('mason-nvim-dap.mappings.filetypes')
	local configurations = require('mason-nvim-dap.mappings.configurations')

	local dap = require('dap')
	Optional.of_nilable(adapters[adapter]):map(function(adapter_config)
		dap.adapters[adapter] = adapter_config
		local configuration = configurations[adapter] or {}
		if not vim.tbl_isempty(configuration) then
			for _, filetype in ipairs(filetypes[adapter]) do
				dap.configurations[filetype] = vim.list_extend(dap.configurations[filetype] or {}, configuration)
			end
		end
	end)
end)
