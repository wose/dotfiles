---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "Source Code Pro 8"

theme.bg_normal     = "#0F0E0F"
theme.bg_focus      = "#0F0E0F"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#434045"

theme.fg_normal     = "#A59461"
theme.fg_focus      = "#B45B00"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "1"
theme.border_normal = "#0F0F0F"
theme.border_focus = "#A59461"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "~/.config/awesome/themes/zunder/taglist/squarefw.png"
theme.taglist_squares_unsel = "~/.config/awesome/themes/zunder/taglist/squarew.png"

theme.tasklist_floating_icon = "~/.config/awesome/themes/zunder/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_border-width = "0"
theme.menu_submenu_icon = "~/.config/awesome/themes/zunder/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "150"
theme.menu_border_width = "0"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "/usr/bin/xsetroot -solid '#0F0F0F'" }

-- You can use your own layout icons like this:
theme.layout_fairh = "~/.config/awesome/themes/zunder/layouts/fairhw.png"
theme.layout_fairv = "~/.config/awesome/themes/zunder/layouts/fairvw.png"
theme.layout_floating  = "~/.config/awesome/themes/zunder/layouts/floatingw.png"
theme.layout_magnifier = "~/.config/awesome/themes/zunder/layouts/magnifierw.png"
theme.layout_max = "~/.config/awesome/themes/zunder/layouts/maxw.png"
theme.layout_fullscreen = "~/.config/awesome/themes/zunder/layouts/fullscreenw.png"
theme.layout_tilebottom = "~/.config/awesome/themes/zunder/layouts/tilebottomw.png"
theme.layout_tileleft   = "~/.config/awesome/themes/zunder/layouts/tileleftw.png"
theme.layout_tile = "~/.config/awesome/themes/zunder/layouts/tilew.png"
theme.layout_tiletop = "~/.config/awesome/themes/zunder/layouts/tiletopw.png"
theme.layout_spiral  = "~/.config/awesome/themes/zunder/layouts/spiralw.png"
theme.layout_dwindle = "~/.config/awesome/themes/zunder/layouts/dwindlew.png"

theme.widget_cpu = "~/.config/awesome/themes/zunder/icons/cpu.png"
theme.widget_mem = "~/.config/awesome/themes/zunder/icons/mem.png"
theme.widget_temp = "~/.config/awesome/themes/zunder/icons/temp.png"
theme.widget_vol = "~/.config/awesome/themes/zunder/icons/vol-hi.png"
theme.widget_mute = "~/.config/awesome/themes/zunder/icons/vol-mute.png"
theme.widget_netup = "~/.config/awesome/themes/zunder/icons/up.png"
theme.widget_netdown = "~/.config/awesome/themes/zunder/icons/down.png"
theme.widget_wifi4 = "~/.config/awesome/themes/zunder/icons/net-wifi-link4.png"
theme.widget_wifi3 = "~/.config/awesome/themes/zunder/icons/net-wifi-link3.png"
theme.widget_wifi2 = "~/.config/awesome/themes/zunder/icons/net-wifi-link2.png"
theme.widget_wifi1 = "~/.config/awesome/themes/zunder/icons/net-wifi-link1.png"
theme.widget_bat = "~/.config/awesome/themes/zunder/icons/power-bat2.png"
theme.widget_ac = "~/.config/awesome/themes/zunder/icons/power-ac.png"

theme.widget_fg = "#A59461"
theme.widget_bg = "#0F0F0F"

theme.awesome_icon = "~/.config/awesome/themes/zunder/logo.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
