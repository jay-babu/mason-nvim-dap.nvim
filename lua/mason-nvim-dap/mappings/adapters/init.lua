--- Lazily map debug adapters

local M = {}

local META = {}
function META.__index(table, key)
	local ok, adapter = pcall(require, 'mason-nvim-dap.mappings.adapters.' .. key)
	if not ok then
		return nil
	end
	table[key] = adapter
	return adapter
end

setmetatable(M, META)

return M
