local utils = require "utils"

local M = {}

M.showPanel = function()
  awesome.emit_signal "panel:open"
end

M.switch_config = function()
  utils.config_switcher("awesome-awesome-rc")
end

return M
