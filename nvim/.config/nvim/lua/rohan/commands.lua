vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Created to convert scss files to css, ignores files that start with _
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '[^_]*.sass', '[^_]*.scss' },
  callback = function()
    local file = vim.fn.expand '<afile>'
    local output = vim.fn.fnamemodify(file, ':r') .. '.css'
    vim.cmd(string.format('silent! !sass %s %s', file, output))
  end,
})
