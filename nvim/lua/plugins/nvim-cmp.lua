return {

  {

    "hrsh7th/nvim-cmp",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",

      -- Uncomment this if you want Git completions:

      -- "petertriho/cmp-git",

    },

    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For vsnip users
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" },
        }, {
          { name = "buffer" },

        }),

      })

      -- Optional: Git completion for commit messages

      --[[ require("cmp_git").setup()

      cmp.setup.filetype("gitcommit", {

        sources = cmp.config.sources({

          { name = "git" },

        }, {

          { name = "buffer" },

        }),

      }) ]]

      -- Cmdline completion

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },

      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },

      })

      -- LSP capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- Example if you want to apply to a specific LSP
      -- require("lspconfig").pyright.setup({ capabilities = capabilities })
    end,

  },

}
