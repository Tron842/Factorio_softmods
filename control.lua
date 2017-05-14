local version = 1.0

local pluginlist = require "pluginlist"

require "/locale/stdlib/event/event"
--require "/locale/plugins/tag"

local load_debug = true
function loadPlug(plug)
	local success, error = pcall(require, "/locale/plugins/" .. plug)
	if not success and load_debug and not (error:sub(1, #("module "..plug.." not found")) == ("module "..plug.." not found")) then
				log(plug)
				log(error)
	end
end


for i,v in pairs(pluginlist) do
	loadPlug(v)
end