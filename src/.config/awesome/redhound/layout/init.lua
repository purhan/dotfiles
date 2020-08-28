local awful = require('awful')
local left_panel = require('layout.left-panel')
local workspace_panel = require('layout.workspace-panel')
local tasklist_panel = require('layout.tasklist-panel')
local mode_panel = require('layout.mode-panel')
local date_panel = require('layout.date-panel')
local clock_panel = require('layout.clock-panel')
local systemtray_panel = require('layout.systemtray-panel')

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(
  function(s)
    if s.index == 1 then
      s.left_panel = left_panel(s)
      s.mode_panel = mode_panel(s, true)
	  s.tasklist_panel = tasklist_panel(s, true)
      s.workspace_panel = workspace_panel(s, true)
      s.date_panel = date_panel(s, true)
      s.clock_panel = clock_panel(s, true)
      s.systemtray_panel = systemtray_panel(s, true)
    else
      s.mode_panel = mode_panel(s, false)
      s.workspace_panel = workspace_panel(s, false)
      s.tasklist_panel = tasklist_panel(s, false)
      s.date_panel = date_panel(s, false)
      s.clock_panel = clock_panel(s, false)
      s.systemtray_panel = systemtray_panel(s, false)
    end
  end
)

-- Hide bars when app go fullscreen
function updateBarsVisibility()
  for s in screen do
    if s.selected_tag then
      local fullscreen = s.selected_tag.fullscreenMode
      -- Order matter here for shadow
      s.workspace_panel.visible = not fullscreen
      s.mode_panel.visible = not fullscreen
      s.tasklist_panel.visible = not fullscreen
      s.date_panel.visible = not fullscreen
      s.clock_panel.visible = not fullscreen
      s.systemtray_panel.visible = not fullscreen
      if s.left_panel then
        s.left_panel.visible = not fullscreen
      end
    end
  end
end

_G.tag.connect_signal(
  'property::selected',
  function(t)
    updateBarsVisibility()
  end
)

_G.client.connect_signal(
  'property::fullscreen',
  function(c)
    c.screen.selected_tag.fullscreenMode = c.fullscreen
    updateBarsVisibility()
  end
)

_G.client.connect_signal(
  'unmanage',
  function(c)
    if c.fullscreen then
      c.screen.selected_tag.fullscreenMode = false
      updateBarsVisibility()
    end
  end
)
