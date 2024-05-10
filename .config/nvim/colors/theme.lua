-- clear the current theme
package.loaded["theme"] = nil;

-- TODO: delete this, just for dev
vim.cmd("highlight clear");

-- require the theme & execute code for the theme
-- require("user.theme").color_scheme();


-- not sure if this is required...
-- perhaps we can manually run this if necessary... will that improve performance?

