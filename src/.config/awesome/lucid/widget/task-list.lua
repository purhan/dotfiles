local awful = require('awful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local capi = {
    button = _G.button
}
local gears = require('gears')
local clickable_container = require('widget.material.clickable-container')
local tasklist_mode = 'text'
local beautiful = require('beautiful')
--- Common method to create buttons.
-- @tab buttons
-- @param object
-- @treturn table
local function create_buttons(buttons, object)
    if buttons then
        local btns = {}
        for _, b in ipairs(buttons) do
            -- Create a proxy button object: it will receive the real
            -- press and release events, and will propagate them to the
            -- button object the user provided, but with the object as
            -- argument.
            local btn = capi.button {
                modifiers = b.modifiers,
                button = b.button
            }
            btn:connect_signal('press', function()
                b:emit_signal('press', object)
            end)
            btn:connect_signal('release', function()
                b:emit_signal('release', object)
            end)
            btns[#btns + 1] = btn
        end

        return btns
    end
end

local function list_update(w, buttons, label, data, objects)
    -- update the widgets, creating them if needed
    w:reset()
    for i, o in ipairs(objects) do
        local cache = data[o]
        local ib, tb, bgb, tbm, ibm, l, ll, bg_clickable
        if cache then
            ib = cache.ib
            tb = cache.tb
            bgb = cache.bgb
            tbm = cache.tbm
            ibm = cache.ibm
        else
            ib = wibox.widget.imagebox()
            tb = wibox.widget.textbox()
            bg_clickable = clickable_container()
            bgb = wibox.container.background()
            tbm = wibox.container.margin(tb, dpi(4), dpi(4), dpi(1), dpi(1))
            ibm = wibox.container.margin(ib, dpi(1), dpi(1), dpi(1), dpi(1))
            l = wibox.layout.fixed.horizontal()
            ll = wibox.layout.flex.horizontal()

            -- All of this is added in a fixed widget
            l:fill_space(true)
            l:add(ibm)
            l:add(tbm)
            ll:add(l)

            bg_clickable:set_widget(ll)
            -- And all of this gets a background
            bgb:set_widget(bg_clickable)

            l:buttons(create_buttons(buttons, o))

            data[o] = {
                ib = ib,
                tb = tb,
                bgb = bgb,
                tbm = tbm,
                ibm = ibm
            }
        end

        local text, bg, bg_image, icon, args = label(o, tb)
        args = args or {}

        -- The text might be invalid, so use pcall.
        if tasklist_mode == 'icon' then
            text = nil
        elseif tasklist_mode == 'text' then
            icon = nil
        end
        if text == nil or text == '' then
            tbm:set_margins(0)
        else
            if not tb:set_markup_silently(text) then
                tb:set_markup('<i>&lt;Invalid text&gt;</i>')
            end
        end
        bgb:set_bg(bg)
        if type(bg_image) == 'function' then
            bg_image = bg_image(tb, o, nil, objects, i)
        end
        bgb:set_bgimage(bg_image)
        if icon then
            ib.image = icon
            ib.resize = true
        else
            ibm:set_margins(0)
        end

        bgb.shape = args.shape
        bgb.shape_border_width = args.shape_border_width
        bgb.shape_border_color = args.shape_border_color
        tb.align = 'center'

        w:add(bgb)
    end
end

local tasklist_buttons = awful.util.table.join(awful.button({}, 1, function(c)
    if c == _G.client.focus then
        c.minimized = true
    else
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible() and c.first_tag then
            c.first_tag:view_only()
        end
        -- This will also un-minimize
        -- the client, if needed
        _G.client.focus = c
        c:raise()
    end
end), awful.button({}, 4, function()
    awful.client.focus.byidx(1)
end), awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
end), awful.button({}, 2, function(c)
    c.kill(c)
end))

local TaskList = function(s)
    return awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons, nil, list_update)
end

return TaskList
