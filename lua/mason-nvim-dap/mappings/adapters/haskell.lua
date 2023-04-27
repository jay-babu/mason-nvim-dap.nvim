return {
  type = 'executable',
  command = vim.fn.exepath('haskell-debug-adapter'),
  args = { '--hackage-version=0.0.39.0' },
}
