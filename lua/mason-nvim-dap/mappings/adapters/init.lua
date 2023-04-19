--- Lazily map debug adapters

local M = {}

local META = {}
function META.__index(table, key)
	local adapter = require('mason-nvim-dap.mappings.adapters.' .. key)
	table[key] = adapter
	return adapter
end

setmetatable(M, META)

return M
