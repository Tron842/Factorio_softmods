function create_tag_gui(event)
  local player = game.players[event.player_index]
    player.insert{name="submachine-gun", count=1}
  if player.gui.top.tag == nil then
  	  player.gui.top.add{name="tag", type="button", caption="Tag"}
  end   
end

-- Tag list
local roles = {
  {display_name = "Custom"},
  {display_name = "Mining"},
  {display_name = "Power"},
  {display_name = "Oil"},
  {display_name = "Smelt"},
  {display_name = "Rail"},
  {display_name = "Defense"},
  {display_name = "Circuits"},
  {display_name = "Labs"},
  {display_name = "Bots"},  
  {display_name = "AFK"},
  {display_name = "Clear"}}

function custom_tag_gui(player)
  local cframe = player.gui.center["custom-tag-panel"]
  if (cframe) then
    cframe.destroy()
  else
    local cframe = player.gui.center.add{type="frame", name="custom-tag-panel", caption="Add your own tag:"}
    cframe.add{type="label", caption="Enter Tag:"}
    cframe.add{type="textfield", name="ctag-text"}
    cframe.add{type="button", caption="Ok", name="tag-enter-btn"}
    cframe.add{type="button", caption="Cancel", name="cancel-tag-btn"}
  end
end

function expand_tag_gui(player)
    local frame = player.gui.left["tag-panel"]
    if (frame) then
        frame.destroy()
    else
        local frame = player.gui.left.add{type="frame", name="tag-panel", caption="At the moment:"}
    		for _, role in pairs(roles) do
    			frame.add{type="button", caption=role.display_name, name=role.display_name}
 			end
    end
end

local function on_tag_click(event)
    if not (event and event.element and event.element.valid) then return end
    local player = game.players[event.element.player_index]
    local name = event.element.name

		if (name == "tag") then
			expand_tag_gui(player)		
		end
    
    if (name == "tag-enter-btn") then
      local endcframe = player.gui.center["custom-tag-panel"]
      local tbox = player.gui.center["custom-tag-panel"]["ctag-text"]
      local ctext = tbox.text
      if ctext ~= "" then
        if #ctext > 25 then
          tbox.text = ""
          player.print("Invalid Tag - Exceeds 25 Characters")
        else
        player.tag = tbox.text
        endcframe.destroy()
        end
      end
    end
    
    if (name == "cancel-tag-btn") then
        local canceltframe = player.gui.center["custom-tag-panel"]
        canceltframe.destroy()
    end
		
		if (name == "Clear") then 
			player.tag = ""
			return
		end
		for _, role in pairs(roles) do
			if (name == role.display_name) then
        if role.display_name == "Custom" then
          custom_tag_gui(player)
        else          
				  player.tag = "[".. role.display_name.. "]"			
        end
      end
		end
end


Event.register(defines.events.on_gui_click, on_tag_click)
Event.register(defines.events.on_player_joined_game, create_tag_gui)