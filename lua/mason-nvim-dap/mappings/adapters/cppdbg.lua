local M = {
	id = 'cppdbg',
	type = 'executable',
	command = vim.fn.exepath('OpenDebugAD7'),
}
if vim.fn.has('win32') == 1 then
	M.cppdbg.options = {
		detached = false,
	}
end

return M
