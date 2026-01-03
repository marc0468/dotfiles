-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Transparent background for terminal (e.g., WezTerm)
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
  highlight VertSplit guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight CursorLineNr guibg=NONE ctermbg=NONE
  highlight StatusLine guibg=NONE ctermbg=NONE
  highlight StatusLineNC guibg=NONE ctermbg=NONE
  highlight FloatBorder guibg=NONE ctermbg=NONE
  highlight NormalFloat guibg=NONE ctermbg=NONE
]])

-- Re-apply after colorscheme changes
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight NormalNC guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight SignColumn guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight EndOfBuffer guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight VertSplit guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight LineNr guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight CursorLineNr guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight StatusLine guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight StatusLineNC guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight FloatBorder guibg=NONE ctermbg=NONE]])
    vim.cmd([[highlight NormalFloat guibg=NONE ctermbg=NONE]])
  end,
})
