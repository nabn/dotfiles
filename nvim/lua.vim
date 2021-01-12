" DEBUG:
" lua print(vim.inspect(require'vim.treesitter.query'))

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  indent = { enable = true },
  folding = { enable = true }
}

require 'colorizer'.setup()
EOF

