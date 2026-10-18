return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.conceallevel = 0
        end,
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(args)
          local name = vim.api.nvim_buf_get_name(args.buf)
          if vim.fn.fnamemodify(name, ":e") ~= "md" then
            return
          end
          vim.keymap.set("n", "<D-p>", function()
            vim.fn["mkdp#util#toggle_preview"]()
          end, { buffer = args.buf, desc = "Markdown Preview Toggle" })
        end,
      })
    end,
  },
}
