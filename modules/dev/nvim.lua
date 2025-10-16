vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope git_files<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>f', ':Neoformat<cr>', {})
vim.cmd.colorscheme('catppuccin')

vim.api.nvim_set_keymap('n', '<Leader>ew', ':Oil<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>es', ':abo Oil<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>ev', ':vert Oil<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>et', ':tab Oil<cr>', {})

require 'oil'.setup{
    keymaps = {
        ["<C-p>"] = false,
    },
}
require 'nvim-treesitter.configs'.setup {
  highlight = {
      enable = true,
  }
}
require 'gitsigns'.setup()

vim.lsp.enable('ruff')
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format {async = false, id = args.data.client_id }
      end,
    })
  end
})
