hs.hotkey.bind({"cmd", "shift"}, "return", function() hs.execute("open /Applications/Alacritty.app -n ") end)
-- hs.hotkey.bind({"cmd"}, "a", function() hs.alert.show("Hello World") end)

-- Client
hs.hotkey.bind({"cmd", "shift"}, "r", function() hs.reload() end)

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "m", function() 
	local win = hs.window.focusedWindow()
  local max = win:screen():frame()
  local f = win:frame()

  f.x = max.x 
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
	hs.window.focusedWindow():centerOnScreen() 
end)

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "c", function() 
	local win = hs.window.focusedWindow()
  local max = win:screen():frame()
  local f = win:frame()

  f.x = max.x * 0.95
  f.y = max.y * 0.95
  f.w = max.w * 0.95
  f.h = max.h * 0.95
  win:setFrame(f)
	hs.window.focusedWindow():centerOnScreen() 
end)

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "f", function() 
	hs.window.focusedWindow():toggleZoom()
end)

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "left", function() 
	local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "right", function() 
	local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w / 2
  f.y = max.y 
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)
