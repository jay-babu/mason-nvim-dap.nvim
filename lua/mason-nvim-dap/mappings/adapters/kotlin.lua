return {
	type = 'executable',
	command = vim.fn.exepath('kotlin-debug-adapter'),
	args = { '--interpreter=vscode' },
}
