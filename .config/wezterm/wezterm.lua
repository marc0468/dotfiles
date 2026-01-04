local wezterm = require 'wezterm'

wezterm.on('update-right-status', function(window, pane)
  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    local icon = ''
    if b.state == 'Charging' then
      icon = '🔌 '
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

local target = wezterm.target_triple
local is_windows = target:find('windows') ~= nil
local is_darwin = target:find('darwin') ~= nil
local mod = is_darwin and 'CMD' or (is_windows and 'CTRL' or 'SUPER')

local config = {
  color_scheme = 'MaterialDesignColors',
  window_background_opacity = 0.85,
  macos_window_background_blur = 10,
  font = wezterm.font('RobotoMono Nerd Font Mono'),
  font_size = 12,
  show_update_window = false,
  keys = {
    { key = '\\', mods = 'SHIFT|' .. mod, action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '-',  mods = 'SHIFT|' .. mod, action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'f',  mods = 'SHIFT|' .. mod, action = 'ToggleFullScreen' },
  },
  window_close_confirmation = 'NeverPrompt',
  automatically_reload_config = true
}

if is_windows then
  config.default_domain = 'WSL:Ubuntu-24.04'
  config.font_size = 10
  config.initial_cols = 180
  config.initial_rows = 40
end

if is_darwin then
  config.native_macos_fullscreen_mode = true
end

return config
