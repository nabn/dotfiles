lua <<EOF

require'zephyr'

require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  indent = { enable = true }
}

require'neofs'.setup {
  mappings = {
    ["<c-e>w"] = function(fm)
      fm.path = vim.fn.expand("%:h")
      fm.refresh()
    end
  }
}

require'format'.setup {
  vim = {
    {
        cmd = {"luafmt -w replace"},
        start_pattern = "^lua <<EOF$",
        end_pattern = "^EOF$"
    }
  },
}

EOF

