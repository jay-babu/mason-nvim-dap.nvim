local Optional = require('mason-core.optional')
local _ = require('mason-core.functional')

-- @param adapter string
return _.memoize(function(config)
	local dap = require('dap')

	Optional.of_nilable(config.adapters):map(function(adapter_config)
		dap.adapters[config.name] = adapter_config
		local configuration = config.configurations or {}
		if not vim.tbl_isempty(configuration) then
			for _, filetype in ipairs(config.filetypes) do
				dap.configurations[filetype] = vim.list_extend(dap.configurations[filetype] or {}, configuration)
			end
		end
	end)
	return config
end)
