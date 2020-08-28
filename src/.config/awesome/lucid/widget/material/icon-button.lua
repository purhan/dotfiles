local wibox = require('wibox')
local gears = require('gears')
local clickable_container = require('widget.material.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi

function build(imagebox, args)
    return wibox.widget {
        imagebox,
        shape = gears.shape.circle,
        widget = clickable_container
    }
end

return build
