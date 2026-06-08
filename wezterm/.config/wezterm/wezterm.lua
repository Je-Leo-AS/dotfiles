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
  foreground = '#d8cec0',
  background = '#2f2b27',
  cursor_bg = '#caa77d',
  cursor_fg = '#2f2b27',
  cursor_border = '#caa77d',
  selection_fg = '#2f2b27',
  selection_bg = '#b9a58d',
  scrollbar_thumb = '#5f564d',
  split = '#6f6257',

  ansi = {
    '#2f2b27',
    '#b98273',
    '#9da87b',
    '#c2a36b',
    '#8f9fb0',
    '#b495a8',
    '#8ea9a0',
    '#d8cec0',
  },
  brights = {
    '#6b6259',
    '#d39a89',
    '#b6bf91',
    '#d7b97b',
    '#aab8c5',
    '#c9a9bd',
    '#a5beb5',
    '#f0e6d8',
  },

  tab_bar = {
    background = '#28241f',
    active_tab = {
      bg_color = '#4a4037',
      fg_color = '#f0e6d8',
    },
    inactive_tab = {
      bg_color = '#342f2a',
      fg_color = '#b9a58d',
    },
    inactive_tab_hover = {
      bg_color = '#403830',
      fg_color = '#f0e6d8',
    },
    new_tab = {
      bg_color = '#342f2a',
      fg_color = '#b9a58d',
    },
    new_tab_hover = {
      bg_color = '#403830',
      fg_color = '#f0e6d8',
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
