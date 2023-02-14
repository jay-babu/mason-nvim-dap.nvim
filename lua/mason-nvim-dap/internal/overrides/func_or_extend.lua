--- Main configuration engine logic for extending a default configuration table with either a function override or a table to merge into the default option

-- @param overrides the override definition, either a table or a function that takes a single parameter of the original table
-- @param default the default configuration table
-- @return the new configuration table
local function func_or_extend(overrides, default)
	-- if the override is a table, use vim.tbl_deep_extend
	if type(overrides) == 'table' then
		local opts = overrides or {}
		default = default and vim.tbl_deep_extend('force', default, opts) or opts
		-- if the override is  a function, call it with the default and overwrite default with the return value
	elseif type(overrides) == 'function' then
		default = overrides(default)
	end
	-- return the modified default table
	return default
end
return func_or_extend
