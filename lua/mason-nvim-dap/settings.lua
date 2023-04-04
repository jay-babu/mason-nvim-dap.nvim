local M = {}

---@class MasonNvimDapSettings
---@field handlers table | nil
---@field ensure_installed table
---@field automatic_installation boolean
local DEFAULT_SETTINGS = {
	-- A list of adapters to automatically install if they're not already installed. Example: { "stylua" }
	-- This setting has no relation with the `automatic_installation` setting.
	ensure_installed = {},
	-- NOTE: this is left here for future porting in case needed
	-- Whether adapters that are set up (via dap) should be automatically installed if they're not already installed.
	-- This setting has no relation with the `ensure_installed` setting.
	-- Can either be:
	--   - false: Daps are not automatically installed.
	--   - true: All adapters set up via dap are automatically installed.
	--   - { exclude: string[] }: All adapters set up via mason-nvim-dap, except the ones provided in the list, are automatically installed.
	--       Example: automatic_installation = { exclude = { "python", "delve" } }
	automatic_installation = false,
	handlers = nil,
}

M._DEFAULT_SETTINGS = DEFAULT_SETTINGS
M.current = M._DEFAULT_SETTINGS

---@param opts MasonNvimDapSettings
function M.set(opts)
	M.current = vim.tbl_deep_extend('force', M.current, opts)
	vim.validate({
		ensure_installed = { M.current.ensure_installed, 'table', true },
		automatic_installation = { M.current.automatic_installation, { 'boolean', 'table' }, true },
		handlers = { M.current.handlers, { 'table' }, true },
	})
end

return M
