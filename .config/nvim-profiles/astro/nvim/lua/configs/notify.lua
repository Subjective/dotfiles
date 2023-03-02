local notify = require "notify"
notify.setup(astronvim.user_plugin_opts("plugins.notify", { stages = "fade" }))
-- vim.notify = notify

local banned_messages = { "No information available" }
vim.notify = function(msg, ...)
  for _, banned in ipairs(banned_messages) do
    if msg == banned then
      return
    end
  end
  require("notify")(msg, ...)
end
