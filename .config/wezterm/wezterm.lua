local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Aparência
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font('JetBrains Mono', { weight = 'Regular' })
config.font_size = 13.0
config.window_background_opacity = 0.85

-- Tabs
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false

-- Keymaps
config.keys = {
  { key = 'c', mods = 'CTRL',       action = wezterm.action.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL',       action = wezterm.action.PasteFrom 'Clipboard' },
  { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
  { key = 't', mods = 'CTRL',       action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CTRL',       action = wezterm.action.CloseCurrentTab { confirm = false } },
  { key = 'UpArrow',   mods = 'SHIFT', action = wezterm.action.ScrollToPrompt(-1) },
  { key = 'DownArrow', mods = 'SHIFT', action = wezterm.action.ScrollToPrompt(1) },
  {
    key = 'o', mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(win, pane)
      local zones = pane:get_semantic_zones('Output')
      if #zones > 0 then
        win:copy_to_clipboard(pane:get_text_from_semantic_zone(zones[#zones]), 'Clipboard')
      end
    end)
  },
}

-- Mouse
config.mouse_bindings = {
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
}

return config
