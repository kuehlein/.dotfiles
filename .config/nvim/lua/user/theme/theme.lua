-- inspired by: https://machineroom.purplekraken.com/posts/neovim-theme-lua/

local theme = require("user.theme.colors");

local colors = theme.colors; -- all colors
local p = theme.palette; -- commonly used colors

local M = {};


-- TODO: i wonder if there's a way to "compile" this so we don't have to run this on every startup
-- TODO: come up with a proper theme name?

-- TODO: colors for things like search/replace & menus?
-- TODO: come back and refine javascript


function M.color_scheme()
    -- theme
    local t = {
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

        -- TODO: can this be lazily loaded upon opening a rust file (if it hasn't already been loaded)?
        -- rust specific highlight groups
        ["@lsp.mod.constant.rust"] = { fg = p.fg.blue },
        ["@lsp.mod.mutable.rust"] = { underline = true },
        ["@lsp.type.enumMember.rust"] = { fg = p.fg.blue },
        ["@lsp.type.formatSpecifier.rust"] = { fg = p.fg.red },
        ["@lsp.type.macro.rust"] = { fg = p.fg.purple },
        ["@lsp.type.parameter.rust"] = { fg = p.fg.orange },
        ["@lsp.type.variable.rust"] = { fg = p.white },
        ["@lsp.typemod.keyword.crateRoot.rust"] = { fg = p.fg.red },
        ["@lsp.typemod.decorator.attribute.rust"] = { fg = p.fg.orange },
        ["@lsp.typemod.function.defaultLibrary.rust"] = { fg = p.fg.blue },
        ["@function.macro.rust"] = { fg = p.fg.pink }, -- probably not this...
        ["@number.rust"] = { fg = colors.blue[1] },
        ["@punctuation.bracket.rust"] = { fg = p.fg.green },
        ["@punctuation.delimiter.rust"] = { fg = p.fg.red },
        ["@string.rust"] = { fg = colors.blue[1] },
        ["@string.escape.rust"] = { fg = p.fg.red },
        ["@type.builtin.rust"] = { fg = p.fg.blue },
        ["@type.qualifier.rust"] = { fg = p.fg.red },

        -- toml
        ["@punctuation.bracket.toml"] = { fg = p.fg.green },

        -- lua
        ["@constructor.lua"] = { fg = p.green },
        ["@punctuation.bracket.lua"] = { fg = p.fg.green },

        -- javascript
        ["@function.javascript"] = { fg = colors.blue[2] },
        ["@lsp.type.parameter.javascript"] = { fg = p.fg.orange },
        ["@lsp.type.variable.javascript"] = { fg = p.white },
        ["@lsp.typemod.variable.readonly.javascript"] = { fg = colors.blue[2] }, -- p.fg.blue??
        ["@lsp.typemod.parameter.declaration.javascript"] = { fg = p.fg.orange },
        ["@punctuation.bracket.javascript"] = { fg = p.fg.green },
        ["@string.escape.javascript"] = { fg = p.fg.red },

        -- typescript
        ["@function.typescript"] = { fg = colors.blue[2] },
        ["@lsp.type.interface.typescriptreact"] = { fg = p.fg.purple },
        ["@lsp.type.parameter.typescript"] = { fg = p.fg.orange },
        ["@lsp.type.parameter.typescriptreact"] = { fg = p.fg.orange },
        ["@lsp.type.type.typescriptreact"] = { fg = p.fg.purple },
        -- ["@lsp.type.variable.typescript"] = { fg = p.white },
        ["@lsp.type.variable.typescriptreact"] = { fg = p.fg.blue },
        ["@lsp.typemod.variable.readonly.typescript"] = { fg = colors.blue[2] }, -- p.fg.blue??
        ["@lsp.typemod.parameter.declaration.typescript"] = { fg = p.fg.orange },
        ["@lsp.typemod.parameter.declaration.typescriptreact"] = { fg = p.fg.orange },
        ["@lsp.typemod.property.declaration.typescriptreact"] = { fg = p.white },
        ["@none.tsx"] = { fg = p.white },
        ["@punctuation.bracket.tsx"] = { fg = p.fg.green },
        ["@punctuation.bracket.typescript"] = { fg = p.fg.green },
        ["@punctuation.special.tsx"] = { fg = p.fg.red },
        ["@string.escape.typescript"] = { fg = p.fg.red },
        ["@tag.attribute.tsx"] = { fg = p.fg.purple },
        ["@tag.builtin.tsx"] = { fg = colors.green[1] },
        ["@tag.tsx"] = { fg = colors.blue[2] },
        ["@type.builtin.tsx"] = { fg = p.fg.blue },

        -- scss
        ["@character.special.scss"] = { fg = p.fg.green },
        ["@number.scss"] = { fg = p.fg.red },
        ["@number.float.scss"] = { fg = p.fg.red },
        -- ["@property.scss"] = { fg = p.fg.green },
        ["@string.scss"] = { fg = p.fg.blue },

        -- json
        ["@punctuation.bracket.json"] = { fg = p.fg.green },
        ["@string.escape.json"] = { fg = p.fg.red },
    };

    -- Each entry into the inner table corresponds to a configuration key,
    -- mapped to a highlight argument. We implement this in a function which we
    -- conveniently call highlight(), just like the vim command we wrap:
    local function highlight(group, style)
        -- 0 is the global level, maybe add level to the `t` object?
        vim.api.nvim_set_hl(0, group, style);
    end;

    -- if another theme is set, clear it, then apply our theme
    if vim.g.colors_name then
        vim.cmd("highlight clear");
    end

    -- name of theme we are applying
    vim.g.colors_name = "theme";
    
    -- apply the theme for each value in `t`
    for group, style in pairs(t) do
        highlight(group, style);
    end
end;


-- TODO: remove this once the colorscheme is finished...
M.color_scheme();


return M;

