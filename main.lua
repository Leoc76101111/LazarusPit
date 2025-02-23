local gui          = require "gui"

local local_player

local function update_locals()
    local_player = get_local_player()
end
local function player_in_dungeon()
    local current_zone = get_current_world():get_current_zone_name()
    -- if player in pit or horde, can add nmd next time
    return current_zone == "EGD_MSWK_World_02" or
        current_zone == "EGD_MSWK_World_01" or
        current_zone == "S05_BSK_Prototype02"
end

local function main_pulse()
    local settings = {
        enabled = gui.elements.main_toggle:get(),
        escape_percentage = gui.elements.escape_percentage:get(),
        dungeon_reset = gui.elements.dungeon_reset:get(),
    }
    if not local_player or not settings.enabled then return end
    local player_current_health = local_player:get_current_health();
    local player_max_health = local_player:get_max_health();
    local health_percentage = player_current_health / player_max_health;
    if health_percentage <= (settings.escape_percentage / 100) then
        if player_in_dungeon() and settings.dungeon_reset then
            reset_all_dungeons()
        else
            local consumeable_items = local_player:get_consumable_items()
            for _,item in pairs(consumeable_items) do
                -- sno_id for scroll of escape is 598884
                if item:get_sno_id() == 598884 then
                    loot_manager.use_item(item)
                    return
                end
            end
        end
    end
end

local function render_pulse()
end

on_update(function()
    update_locals()
    main_pulse()
end)

on_render_menu(gui.render)
on_render(render_pulse)
