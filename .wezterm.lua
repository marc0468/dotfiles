local wezterm = require 'wezterm'

wezterm.on('update-right-status', function(window, pane)
  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    local icon = ''
    if b.state == 'Charging' then
      icon = '🔌'
    elseif b.state == 'Discharging' then
      icon = '🔋'
    elseif b.state == 'Full' then
      icon = '💡'
    elseif b.state == 'Empty' then
      icon = '🪫'
    else
      icon = '❓'
    end
    bat = icon .. string.format('%.0f%%', b.state_of_charge * 100)
  end

  window:set_right_status(wezterm.format {
    { Text = bat .. '  ' .. wezterm.strftime '%m/%d (%a) %H:%M:%S   ' },
  })
end)

return {
  color_scheme = 'MaterialDesignColors',
  window_background_opacity = 0.85,
  font = wezterm.font('RobotoMono Nerd Font Mono'),
  font_size = 12,
  show_update_window = false,
  native_macos_fullscreen_mode = true,
  keys = {
    { key = '\\', mods = 'SHIFT|CMD', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '-',  mods = 'SHIFT|CMD', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = "f",  mods = "SHIFT|CMD", action = "ToggleFullScreen" },
  }
}
