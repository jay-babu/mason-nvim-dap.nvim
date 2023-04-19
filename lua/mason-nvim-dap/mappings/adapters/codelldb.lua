local M = {
	type = 'server',
	port = '${port}',
	executable = {
		command = vim.fn.exepath('codelldb'),
		args = { '--port', '${port}' },
	},
}

if vim.fn.has('win32') == 1 then
	M.codelldb.executable.detached = false
end

return M
