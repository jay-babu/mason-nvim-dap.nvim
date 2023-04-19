return {
	type = 'executable',
	command = vim.fn.exepath('netcoredbg'),
	args = { '--interpreter=vscode' },
}
