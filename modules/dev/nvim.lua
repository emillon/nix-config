vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope git_files<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>f', ':Neoformat<cr>', {})
vim.cmd.colorscheme('catppuccin')

vim.api.nvim_set_keymap('n', '<Leader>ew', ':Oil<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>es', ':abo Oil<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>ev', ':vert Oil<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>et', ':tab Oil<cr>', {})

if vim.fn.isdirectory(vim.g.merlindir) == 0 then
  if vim.fn.executable('ocamllsp') == 1 then
    require'lspconfig'.ocamllsp.setup{}
  end
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      vim.keymap.set('n', '<leader>t', vim.lsp.buf.hover, { buffer = ev.buf })
    end,
  })
end
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
