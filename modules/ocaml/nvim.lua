vim.filetype.add({extension = {
    t = 'cram',
    mld = 'mld',
    mly = 'menhir',
}})

if vim.fn.isdirectory(vim.g.merlindir) == 0 then
  if vim.fn.executable('ocamllsp') == 1 then
    vim.lsp.enable('ocamllsp')
  end
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      vim.keymap.set('n', '<leader>t', vim.lsp.buf.hover, { buffer = ev.buf })
    end,
  })
end

vim.g.neoformat_mld_ocamlformat = {
    exe = 'ocamlformat',
    no_append = 1,
    stdin = 1,
    args= {'--name', '"%:p"', '-'},
}

vim.g.neoformat_enabled_mld = {'ocamlformat'}
