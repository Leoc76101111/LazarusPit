local plugin_label = 'lazarus_pit'
local plugin_version = 'v0.0.1'

local gui = {}

local function create_checkbox(value, key)
    return checkbox:new(value, get_hash(plugin_label .. '_' .. key))
end

gui.elements = {
    main_tree = tree_node:new(0),
    main_toggle = create_checkbox(false, 'main_toggle'),
    escape_percentage = slider_int:new(10, 100, 40, get_hash("escape_percentage")),
}

function gui.render()
    if not gui.elements.main_tree:push('Lazarus Pit | Leoric | ' .. plugin_version) then return end
    gui.elements.main_toggle:render("Enable", "Enable the bot")
    if gui.elements.main_toggle:get() then
        gui.elements.escape_percentage:render("Health %%", "%% health to immediately use scroll")
    end
    gui.elements.main_tree:pop()
end

return gui