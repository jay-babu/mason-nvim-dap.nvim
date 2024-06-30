local M = {
	type = 'executable',
	command = vim.fn.exepath('netcoredbg'),
	args = { '--interpreter=vscode' },
}

if vim.fn.has('win32') == 1 then
	M.options = {
		detached = false,
	}
end

return M
