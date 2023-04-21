--- Lazily map debug adapters

local M = {}

---Convenience function for creating a set from a list.
---@param list table A list which's values are to be used as indexes in the set.
---@return table A table with the values from the list set as indexes.
local function Set(list)
	local set = {}
	for _, val in ipairs(list) do
		set[val] = true
	end
	return set
end

---Set of adapters that can be mapped directly from this module.
---I.e. They should be able to be found with for example:
--->lua
---	require('mason-nvim-dap.mappings.adapters.chrome')
---<
---This should be updated if files with adapter mappings are added or removed
---from 'lua/mason-nvim-dap/mappings/adapters/'.
local OWN_MAPS = Set {
	'bash',
	'chrome',
	'codelldb',
	'coreclr',
	'cppdbg',
	'dart',
	'delve',
	'firefox',
	'kotlin',
	'mix_task',
	'node2',
	'php',
	'python',
}

local META = {}
function META.__index(table, key)
	if not OWN_MAPS[key] then return nil end

	local adapter = require('mason-nvim-dap.mappings.adapters.' .. key)
	table[key] = adapter
	return adapter
end

setmetatable(M, META)

return M
