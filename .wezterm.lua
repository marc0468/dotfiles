local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = 'MaterialDesignColors'
config.window_background_opacity = 0.85
config.font = wezterm.font('RobotoMono Nerd Font Mono', {weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 12

-- ショートカットキー設定
local act = wezterm.action
config.keys = {
    {
        key = '\\',
        mods = 'SHIFT|CMD',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = '-',
        mods = 'SHIFT|CMD',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
}

wezterm.on('update-right-status', function(window, pane)
  local date = wezterm.strftime '%m/%d (%a) %H:%M:%S   '
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
    elseif b.state == 'Unknown' then
      icon = '❓'
    end

    bat = icon .. string.format('%.0f%%', b.state_of_charge * 100)
  end

  window:set_right_status(wezterm.format {
    { Text = bat .. '  ' .. date },
  })
end)

return config
