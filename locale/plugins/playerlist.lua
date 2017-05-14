local version = 1.0
local minute = 3600
 -- ******************************************************
 -- ***                     GUI                        ***
 -- ******************************************************
 
Event.register(defines.events.on_player_joined_game,function(n)
    local player=game.players[n.player_index]
    if player.gui.left.PlayerList~=nil   then player.gui.left.PlayerList.destroy()    end
    if player.gui.top.PlayerList~=nil    then player.gui.top.PlayerList.destroy()    end
    drawToolbar()
    drawPlayerList()
end)
 
Event.register(defines.events.on_player_left_game,function(n)
    drawPlayerList()
end)
 
Event.register(defines.events.on_tick, function()
    local t = game.tick % minute
       
    if (t == 1) then drawPlayerList() end
 end)

function clearElement(s)
    if s~=nil then
        for t,u in pairs(s.children_names) do
            s[u].destroy()
        end
    end
end
 
function drawToolbar()
    for t,I in pairs(game.players) do
        local z=I.gui.top
        clearElement(z)
        z.add{name="btn_toolbar_playerList",type="button",caption="Playerlist",tooltip="Lists player connected."}
    end
end
 
function playerListGuiSwitch(J)
    if J.gui.left.PlayerList~=nil then
        J.gui.left.PlayerList.style.visible = not J.gui.left.PlayerList.style.visible
    end
end
 
function drawPlayerList()
    for _,I in pairs(game.players) do
        if I.gui.left.PlayerList==nil then I.gui.left.add{name="PlayerList",type="frame",direction="vertical"} end
        clearElement(I.gui.left.PlayerList)
        for t,m in pairs(game.connected_players) do
            if m.admin==true then
                I.gui.left.PlayerList.add{type="label",name=m.name,style="caption_label_style",caption={"", ticktohours(m.online_time), " h ", ticktominutes(m.online_time), " m - ",m.name," ", m.tag}}
                I.gui.left.PlayerList[m.name].style.font_color={r=233,g=63,b=233}
                --m.tag="*"
            else
				I.gui.left.PlayerList.add{type="label",name=m.name,style="caption_label_style",caption={"", ticktohours(m.online_time), " h ", ticktominutes(m.online_time), " m - ",m.name, " " ,m.tag}}
				I.gui.left.PlayerList[m.name].style.font_color={r=24,g=172,b=188}
				--m.tag=""
            end
        end
    end
end
 
 
Event.register(defines.events.on_gui_click,function(n)
    local player=game.players[n.player_index]
    
    if n.element.name=="btn_toolbar_playerList"            then playerListGuiSwitch(player)     
    end
end)

 
function ticktominutes(o)    
    return math.floor(o/3600.)
end
function ticktohours(o)    
    return math.floor(o/216000.)
end