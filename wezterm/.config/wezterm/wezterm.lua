local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

local function table_contains(values, value)
  for _, item in ipairs(values) do
    if item == value then
      return true
    end
  end

  return false
end

local function sorted_keys(values)
  local keys = {}

  for key, _ in pairs(values) do
    table.insert(keys, key)
  end

  table.sort(keys)
  return keys
end

local function basename(domain_name)
  if not domain_name or domain_name == '' then
    return 'local'
  end

  return domain_name:gsub('^SSH:', '')
end

local function is_local_domain(domain_name)
  return not domain_name
      or domain_name == ''
      or domain_name == 'local'
      or domain_name:match('^local:')
end

local function tab_title(tab)
  local pane = tab.active_pane
  local domain_name = pane and pane.domain_name or ''

  if not is_local_domain(domain_name) then
    return basename(domain_name)
  end

  return pane and pane.title or 'local'
end

local function add_ssh_shortcut(keys, key, host, known_hosts)
  if not table_contains(known_hosts, host) then
    return
  end

  table.insert(keys, {
    key = key,
    mods = 'CTRL|SHIFT',
    action = act.SpawnCommandInNewTab {
      domain = { DomainName = host },
    },
  })
end

-- Aparencia
local color_schemes = wezterm.get_builtin_color_schemes()
if color_schemes['Catppuccin Mocha'] then
  config.color_scheme = 'Catppuccin Mocha'
end

config.colors = {
  foreground = '#c8ccd4',
  background = '#1a1d23',
  cursor_bg = '#8aa9c9',
  cursor_fg = '#1a1d23',
  cursor_border = '#8aa9c9',
  selection_fg = '#c8ccd4',
  selection_bg = '#2f3947',
  scrollbar_thumb = '#3a4150',
  split = '#2a2f38',

  ansi = {
    '#1a1d23',
    '#e07a7a',
    '#7aa67a',
    '#d4b06a',
    '#7a9ec9',
    '#9a8fc4',
    '#7fb3a8',
    '#c8ccd4',
  },
  brights = {
    '#6b7280',
    '#e88c8c',
    '#8fba8f',
    '#dfbf7d',
    '#8aa9c9',
    '#aa9fd4',
    '#91c2b8',
    '#e4e7ec',
  },

  tab_bar = {
    background = '#1a1d23',
    active_tab = {
      bg_color = '#2f3947',
      fg_color = '#c8ccd4',
    },
    inactive_tab = {
      bg_color = '#1f232b',
      fg_color = '#6b7280',
    },
    inactive_tab_hover = {
      bg_color = '#3a4150',
      fg_color = '#c8ccd4',
    },
    new_tab = {
      bg_color = '#1f232b',
      fg_color = '#6b7280',
    },
    new_tab_hover = {
      bg_color = '#3a4150',
      fg_color = '#c8ccd4',
    },
  },
}

config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 11.5
config.window_padding = {
  left = 6,
  right = 6,
  top = 4,
  bottom = 4,
}

-- Tabs
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false

-- SSH domains gerados a partir de ~/.ssh/config.
local ssh_hosts = sorted_keys(wezterm.enumerate_ssh_hosts())
config.ssh_domains = {}

for _, host in ipairs(ssh_hosts) do
  table.insert(config.ssh_domains, {
    name = host,
    remote_address = host,
    multiplexing = 'None',
  })
end

wezterm.on('update-right-status', function(window, pane)
  local domain_name = pane:get_domain_name()
  local label = 'LOCAL'

  if not is_local_domain(domain_name) then
    label = 'SSH: ' .. basename(domain_name)
  end

  window:set_right_status(wezterm.format {
    { Attribute = { Intensity = 'Bold' } },
    { Text = ' ' .. label .. ' ' },
  })
end)

wezterm.on('format-tab-title', function(tab, tabs, panes, cfg, hover, max_width)
  local title = tab_title(tab)
  if #title > max_width - 2 then
    title = wezterm.truncate_right(title, max_width - 2)
  end

  return {
    { Text = ' ' .. title .. ' ' },
  }
end)

config.keys = {
  -- Ctrl+C/Ctrl+V continuam indo para o programa aberto, por exemplo nvim.
  { key = 'c', mods = 'CTRL', action = act.SendKey { key = 'c', mods = 'CTRL' } },
  { key = 'v', mods = 'CTRL', action = act.SendKey { key = 'v', mods = 'CTRL' } },

  -- Copiar e colar do terminal.
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },

  { key = 't', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CTRL', action = act.CloseCurrentTab { confirm = false } },

  {
    key = 's',
    mods = 'CTRL|SHIFT',
    action = act.ShowLauncherArgs {
      flags = 'FUZZY|DOMAINS',
    },
  },

  {
    key = 'i',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane {
      direction = 'Down',
      size = { Percent = 35 },
      command = { args = { 'codex' } },
    },
  },

  {
    key = '-',
    mods = 'CTRL|SHIFT',
    action = act.SplitVertical {
      domain = 'CurrentPaneDomain',
    },
  },
  {
    key = '=',
    mods = 'CTRL|SHIFT',
    action = act.SplitHorizontal {
      domain = 'CurrentPaneDomain',
    },
  },

  { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
}

add_ssh_shortcut(config.keys, 'm', 'moto', ssh_hosts)
add_ssh_shortcut(config.keys, 'h', 'homelab', ssh_hosts)

return config
