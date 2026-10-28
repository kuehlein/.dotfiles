require("neogit").setup({
  integrations = {
    diffview = true
  },
  signs = {
    hunk = { "", "" },
    item = { "󰘵", "" },
    branch = { "󰘬", "" },
  },
})
