-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

-- scatch
local scratch = require("scratch")

-- orglendar
require("orglendar")

-- Load Debian menu entries
require("debian.menu")

-- vicious
vicious = require("vicious")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/wose/.config/awesome/themes/zunder/theme.lua")

terminal = "urxvt"
editor = "emacsclient"
editor_cmd = editor .. " --alternate-editor=\"\" "
browser = "conkeror"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ "⠁", "⠃", "⠉", "⠙", "⠑", "⠋", "⠛", "⠓", "⠊" },s,
    {       layouts[7], layouts[10], layouts[2],   -- tag 1 2 3
            layouts[2], layouts[2],  layouts[2],   -- tag 4 5 6
            layouts[2], layouts[2], layouts[2] })  -- tag 7 8 9
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Debian", debian.menu.Debian_menu.Debian },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

orglendar.files = { "/home/wose/org/cal.org" }
orglendar.register(mytextclock)

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
wibottom = {}
myspacer = widget({ type = "textbox" })
myspacer.text = " :: "

-- CPU usage
cpuicon = widget({ type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)

cpuwidgettext = widget({ type = "textbox" })
cpuwidgettext.width = 30
vicious.register(cpuwidgettext, vicious.widgets.cpu, "$1%")

-- CPU Graph
cpuwidget = awful.widget.progressbar()
cpuwidget:set_vertical(false)
cpuwidget:set_width(100)
cpuwidget:set_height(6)
cpuwidget:set_background_color(beautiful.widget_bg)
cpuwidget:set_color(beautiful.widget_fg)
awful.widget.layout.margins[cpuwidget.widget] = { top = 7 }
--cpuwidget:set_height(7)
-- cpuwidget:set_gradient_colors({ "#B45B00", "#A59461" })
vicious.register(cpuwidget, vicious.widgets.cpu, "$1   ", 2)

-- MEM usage
memicon = widget({ type = "imagebox" })
memicon.image = image(beautiful.widget_mem)

memwidgettext = widget({ type = "textbox" })
vicious.register(memwidgettext, vicious.widgets.mem, "$1% ($2MB/$3MB)", 13) 

-- MEM Progressbar
memwidget = awful.widget.progressbar()
memwidget:set_width(100)
memwidget:set_height(6)
memwidget:set_vertical(false)
memwidget:set_background_color(beautiful.widget_bg)
memwidget:set_color(beautiful.widget_fg)
awful.widget.layout.margins[memwidget.widget] = { top = 7 }
-- memwidget:set_gradient_colors({ "#B45B00", "#A59461" })
vicious.register(memwidget, vicious.widgets.mem, "$1   ", 1)

-- BAT status
baticon = widget({ type = "imagebox" })
baticon.image = image( beautiful.widget_bat )

batwidget = awful.widget.progressbar()
batwidget:set_width(100)
batwidget:set_height(6)
batwidget:set_vertical(false)
batwidget:set_color(beautiful.widget_fg)
batwidget:set_background_color(beautiful.widget_bg)
awful.widget.layout.margins[batwidget.widget] = { top = 7 }
vicious.register(batwidget, vicious.widgets.bat,
                 function (widget, args)
                    if args[3] == "N/A" then
                       baticon.image = image(beautiful.widget_ac)
                       return args[2]
                    else
                       baticon.image = image(beautiful.widget_bat)
                       return args[2]
                    end
                 end, 61, "BAT0"
                )


-- core temperature
tempicon = widget({ type = "imagebox" })
tempicon.image = image(beautiful.widget_temp)

tempwidget = widget({ type = "textbox" })
vicious.register(tempwidget, vicious.widgets.thermal, "$1°C", 5, {"coretemp.0", "core"})

-- Volume
volicon = widget({ type = "imagebox" })
volicon.image = image(beautiful.widget_vol)

volwidget = awful.widget.progressbar()

volwidget:set_vertical(false)
volwidget:set_height(6)
volwidget:set_width(100)
volwidget:set_background_color(beautiful.widget_bg)
volwidget:set_color(beautiful.widget_fg)
vicious.cache(vicious.widgets.volume)
awful.widget.layout.margins[volwidget.widget] = { top = 7 }
vicious.register(volwidget, vicious.widgets.volume, "$1", 1, "Master")

upicon = widget({ type = "imagebox" })
upicon.image = image(beautiful.widget_netup)

downicon = widget({ type = "imagebox" })
downicon.image = image(beautiful.widget_netdown)

netwidget = widget({ type = "textbox" })
vicious.register(netwidget, vicious.widgets.net, '${wlan0 down_kb} ${wlan0 up_kb}', 3)

wifiicon = widget({ type = "imagebox" })
vicious.register(wifiicon, vicious.widgets.wifi,
                 function (widget, args)
                    if args["{linp}"] > 75 then
                       widget.image = image(beautiful.widget_wifi4)
                    elseif args["{linp}"] > 50 then
                       widget.image = image(beautiful.widget_wifi3)
                    elseif args["{linp}"] > 25 then
                       widget.image = image(beautiful.widget_wifi2)
                    else
                       widget.image = image(beautiful.widget_wifi1)
                    end
                 end, 5, "wlan0"
                )


rbracket = widget({ type = "textbox" })
rbracket.text = "]"

lbracket = widget({ type = "textbox" })
lbracket.text = "["

space = widget({ type = "textbox" })
space.text = " "

mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    wibottom[s] = awful.wibox({ position = "bottom", screen = s, height = 17 })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            myspacer,
            mytaglist[s],
            myspacer,
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        myspacer,
        mytextclock,
        myspacer,
--        s == 1 and mysystray or nil,
        mytasklist[s],
        myspacer,
        layout = awful.widget.layout.horizontal.rightleft
    }

    wibottom[s].widgets = {
       {
          space, cpuicon, space, lbracket, space, cpuwidget, space, rbracket, space, space, 
          space, memicon, space, lbracket, space, memwidget, space, rbracket, space, space,
          space, baticon, space, lbracket, space, batwidget, space, rbracket, space, space,
          space, volicon, space, lbracket, space, volwidget, space, rbracket, space, space,
          layout = awful.widget.layout.horizontal.leftright
       },
       space, tempwidget, space, tempicon, space, space,
       space, wifiicon, space, 
       space, upicon, netwidget, downicon, space,

       layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",                 awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",                awful.tag.viewnext       ),
    awful.key({                   }, "XF86AudioMute",        function () awful.util.spawn_with_shell("amixer -q set Master mute") end),
    awful.key({                   }, "XF86AudioLowerVolume", function () awful.util.spawn_with_shell("amixer -q set Master unmute 5000-") end),
    awful.key({                   }, "XF86AudioRaiseVolume", function () awful.util.spawn_with_shell("amixer -q set Master unmute 5000+") end),
    awful.key({                   }, "XF86Back",             awful.tag.viewprev       ),
    awful.key({                   }, "XF86Forward",          awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape",               awful.tag.history.restore),
    awful.key({ modkey,           }, "F12",                  function () scratch.drop("urxvt", "bottom") end),
    awful.key({ modkey,           }, "F11",                  function () scratch.drop("xcalc", "center", "left", 200, 300) end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
                function ()
                        -- awful.client.focus.history.previous()
                        awful.client.focus.byidx(-1)
                        if client.focus then
                        client.focus:raise()
                end
    end),

    awful.key({ modkey, "Shift"   }, "Tab",
                function ()
                         -- awful.client.focus.history.previous()
                         awful.client.focus.byidx(1)
                         if client.focus then
                         client.focus:raise()
                end
    end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    { rule = { class = "Firefox" },
      properties = { tag = tags[1][2] } },
    { rule = { class = "Conkeror" },
      properties = { tag = tags[1][2] } },
    { rule = { class = "Emacs" },
      properties = { tag = tags[1][1] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)


function run_once(prg)
    if not prg then
        do return nil end
    end
    awful.util.spawn_with_shell("pgrep -f -u $USER -x " .. prg .. " || (" .. prg .. ")")
end

run_once("nm-applet")
awful.util.spawn_with_shell("xset +fp /home/wose/.fonts")
awful.util.spawn_with_shell("xset b off")
run_once("urxvt")
run_once("conkeror")
-- }}}
