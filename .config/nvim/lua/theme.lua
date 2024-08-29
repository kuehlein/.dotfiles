-- inspired by: https://machineroom.purplekraken.com/posts/neovim-theme-lua/

local theme_utils = require("utils.theme");

local colors = theme_utils.colors; -- all colors
local p = theme_utils.palette; -- commonly used colors

local M = {};


-- TODO: i wonder if there's a way to "compile" this so we don't have to run this on every startup
-- TODO: come up with a proper theme name?

function M.color_scheme()
    theme_utils.reset_theme();

    -- show white space
    vim.opt.list = true;

    vim.opt.listchars = {
        tab = "→ ",
        space = "·",
        nbsp = "⎵",
        precedes = "«",
        extends = "»",
    };

    theme_utils.apply_theme({
        Comment = { fg = p.fg.gray },
        Constant = { fg = colors.blue[1] },
        ColorColumn = { bg = colors.gray[8] },
        CursorLine = { bg = colors.gray[8] },
        CursorLineNr = { fg = p.white },
        EndOfBuffer = { fg = p.fg.gray },
        Identifier = { fg = p.fg.purple },
        Keyword = { fg = p.fg.red },
        LineNr = { fg = p.fg.gray },
        NonText = { fg = p.white },
        Normal = { bg = p.bg.gray },
        Pmenu = { bg = colors.gray[8] },
        PmenuSbar = {},
        PmenuSel = { bg = p.gray },
        PmenuThumb = {},
        Search = { bg = p.fg.yellow, fg = p.bg.yellow },
        SignColumn = { bg = p.bg.gray },
        -- SpellBad = { bg = colors.blue[9], undercurl = true },
        Special = { fg = p.white },
        Statement = { fg = p.fg.red },
        Type = { fg = p.fg.orange },
        Visual = { bg = colors.gray[7] },
        Whitespace = { fg = colors.gray[6] },

        -- DiagnosticUnnecessary = { blend = 20 }, -- ?????

        -- toml
        ["@punctuation.bracket.toml"] = { fg = p.fg.green },

        -- lua
        ["@constructor.lua"] = { fg = p.green },
        ["@punctuation.bracket.lua"] = { fg = p.fg.green },

        -- scss
        ["@character.special.scss"] = { fg = p.fg.green },
        ["@number.scss"] = { fg = p.fg.red },
        ["@number.float.scss"] = { fg = p.fg.red },
        -- ["@property.scss"] = { fg = p.fg.green },
        ["@string.scss"] = { fg = p.fg.blue },

        -- json
        ["@punctuation.bracket.json"] = { fg = p.fg.green },
        ["@string.escape.json"] = { fg = p.fg.red },
    });
end;

-- transparent background color
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- TODO: should we run this here?
M.color_scheme();

return M;

