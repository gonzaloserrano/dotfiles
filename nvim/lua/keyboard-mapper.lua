-- keyboard-mapper.lua
local M = {}

-- Keyboard layouts
local layouts = {
  us = {
    { "`", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "BS" },
    { "TAB", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "[", "]", "\\" },
    { "CAPS", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "'", "ENTER" },
    { "SHIFT", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/", "SHIFT" },
    { "CTRL", "WIN", "ALT", "SPACE", "ALT", "WIN", "MENU", "CTRL" }
  },
  es = {
    { "º", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "'", "¡", "BS" },
    { "TAB", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "`", "+", "ENTER" },
    { "CAPS", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Ñ", "´", "Ç" },
    { "SHIFT", "<", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "-", "SHIFT" },
    { "CTRL", "WIN", "ALT", "SPACE", "ALT", "WIN", "MENU", "CTRL" }
  }
}

-- Key widths for special keys
local key_widths = {
  BS = 6,
  TAB = 5,
  CAPS = 6,
  ENTER = 7,
  SHIFT = 7,
  CTRL = 6,
  WIN = 5,
  ALT = 5,
  SPACE = 25,
  MENU = 6
}

local state = {
  mode = "n",
  layout = "us",
  row = 1,
  col = 1,
  main_buf = nil,
  main_win = nil,
  info_buf = nil,
  info_win = nil,
  mappings = {}
}

-- Get key width
local function get_key_width(key)
  return key_widths[key] or 3
end

-- Get all mappings for current mode
local function get_mappings()
  state.mappings = {}
  local mode_mappings = vim.api.nvim_get_keymap(state.mode)
  
  for _, mapping in ipairs(mode_mappings) do
    local lhs = mapping.lhs:upper()
    -- Handle special keys
    lhs = lhs:gsub("<SPACE>", "SPACE")
    lhs = lhs:gsub("<TAB>", "TAB")
    lhs = lhs:gsub("<CR>", "ENTER")
    lhs = lhs:gsub("<BS>", "BS")
    lhs = lhs:gsub("<ESC>", "ESC")
    
    state.mappings[lhs] = {
      rhs = mapping.rhs or mapping.callback and "<Lua function>" or "",
      desc = mapping.desc or ""
    }
  end
end

-- Render keyboard layout
local function render_keyboard()
  local lines = {}
  local current_layout = layouts[state.layout]
  
  -- Header
  table.insert(lines, string.format("Mode: %s | Layout: %s", 
    state.mode == "n" and "Normal" or
    state.mode == "i" and "Insert" or
    state.mode == "v" and "Visual" or
    state.mode == "c" and "Command" or state.mode,
    state.layout:upper()
  ))
  table.insert(lines, string.rep("─", 70))
  table.insert(lines, "")
  
  -- Render keyboard rows
  for row_idx, row in ipairs(current_layout) do
    local line = "  "
    for col_idx, key in ipairs(row) do
      local display_key = key
      local width = get_key_width(key)
      
      -- Check if this is the selected key
      local is_selected = row_idx == state.row and col_idx == state.col
      
      -- Check if key has mapping
      local has_mapping = state.mappings[key:upper()] ~= nil
      
      -- Format the key
      if is_selected then
        display_key = "{" .. key .. "}"
      elseif has_mapping then
        display_key = "[" .. key .. "]"
      else
        display_key = " " .. key .. " "
      end
      
      -- Pad to width
      local padding = width - vim.fn.strdisplaywidth(display_key)
      if padding > 0 then
        display_key = display_key .. string.rep(" ", padding)
      end
      
      line = line .. display_key .. " "
    end
    table.insert(lines, line)
    table.insert(lines, "")
  end
  
  -- Footer
  table.insert(lines, string.rep("─", 70))
  table.insert(lines, "Controls: [m]ode | [l]ayout | [q]uit | [arrows] navigate")
  
  -- Update buffer
  vim.api.nvim_buf_set_lines(state.main_buf, 0, -1, false, lines)
end

-- Render info window
local function render_info()
  if not state.info_buf or not vim.api.nvim_buf_is_valid(state.info_buf) then
    return
  end
  
  local current_layout = layouts[state.layout]
  local key = current_layout[state.row][state.col]
  local mapping = state.mappings[key:upper()]
  
  local lines = {
    "Key: " .. key,
    string.rep("─", 30),
  }
  
  if mapping then
    table.insert(lines, "Mapping: " .. (mapping.rhs or ""))
    if mapping.desc and mapping.desc ~= "" then
      table.insert(lines, "Description: " .. mapping.desc)
    end
  else
    table.insert(lines, "No mapping")
  end
  
  vim.api.nvim_buf_set_lines(state.info_buf, 0, -1, false, lines)
end

-- Navigate keyboard
local function navigate(direction)
  local current_layout = layouts[state.layout]
  
  if direction == "up" and state.row > 1 then
    state.row = state.row - 1
    -- Adjust column if necessary
    if state.col > #current_layout[state.row] then
      state.col = #current_layout[state.row]
    end
  elseif direction == "down" and state.row < #current_layout then
    state.row = state.row + 1
    -- Adjust column if necessary
    if state.col > #current_layout[state.row] then
      state.col = #current_layout[state.row]
    end
  elseif direction == "left" and state.col > 1 then
    state.col = state.col - 1
  elseif direction == "right" and state.col < #current_layout[state.row] then
    state.col = state.col + 1
  end
  
  render_keyboard()
  render_info()
end

-- Switch mode
local function switch_mode()
  local modes = { "n", "i", "v", "c" }
  local current_idx = vim.tbl_contains(modes, state.mode) and 
                      vim.fn.index(modes, state.mode) + 1 or 1
  
  state.mode = modes[(current_idx % #modes) + 1]
  get_mappings()
  render_keyboard()
  render_info()
end

-- Switch layout
local function switch_layout()
  state.layout = state.layout == "us" and "es" or "us"
  render_keyboard()
  render_info()
end

-- Setup keymaps for the plugin
local function setup_keymaps()
  local opts = { buffer = state.main_buf, silent = true }
  
  -- Navigation
  vim.keymap.set("n", "<Up>", function() navigate("up") end, opts)
  vim.keymap.set("n", "<Down>", function() navigate("down") end, opts)
  vim.keymap.set("n", "<Left>", function() navigate("left") end, opts)
  vim.keymap.set("n", "<Right>", function() navigate("right") end, opts)
  
  -- Commands
  vim.keymap.set("n", "m", switch_mode, opts)
  vim.keymap.set("n", "l", switch_layout, opts)
  vim.keymap.set("n", "q", function() M.close() end, opts)
end

-- Open the keyboard mapper
function M.open()
  -- Create main buffer
  state.main_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(state.main_buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(state.main_buf, "filetype", "keyboard-mapper")
  
  -- Calculate window size and position
  local width = 75
  local height = 20
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  
  -- Create main window
  state.main_win = vim.api.nvim_open_win(state.main_buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    border = "rounded",
    title = " Keyboard Mapper ",
    title_pos = "center",
  })
  
  -- Create info buffer and window
  state.info_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(state.info_buf, "bufhidden", "wipe")
  
  local info_width = 35
  local info_height = 6
  local info_row = row + 5
  local info_col = col + width + 2
  
  state.info_win = vim.api.nvim_open_win(state.info_buf, false, {
    relative = "editor",
    row = info_row,
    col = info_col,
    width = info_width,
    height = info_height,
    border = "rounded",
    title = " Key Info ",
    title_pos = "center",
  })
  
  -- Setup
  setup_keymaps()
  get_mappings()
  render_keyboard()
  render_info()
  
  -- Set cursor position
  vim.api.nvim_win_set_cursor(state.main_win, {1, 0})
end

-- Close the keyboard mapper
function M.close()
  if state.main_win and vim.api.nvim_win_is_valid(state.main_win) then
    vim.api.nvim_win_close(state.main_win, true)
  end
  if state.info_win and vim.api.nvim_win_is_valid(state.info_win) then
    vim.api.nvim_win_close(state.info_win, true)
  end
  
  state.main_buf = nil
  state.main_win = nil
  state.info_buf = nil
  state.info_win = nil
end

-- Setup function for the plugin
function M.setup(opts)
  opts = opts or {}
  
  -- Create command
  vim.api.nvim_create_user_command("KeyboardMapper", function()
    M.open()
  end, {})
  
  -- Optional: Create a keymap to open the mapper
  if opts.keymap then
    vim.keymap.set("n", opts.keymap, M.open, { desc = "Open Keyboard Mapper" })
  end
end

return M