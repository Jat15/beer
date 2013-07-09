drunklevel = {};

minetest.register_craftitem("beer:cone", {
	description = "cone",
	inventory_image = "beer_cone.png",
})
--[[
minetest.register_globalstep(function(dtime)
	for _, p in ipairs(minetest.get_connected_players()) do
		



	end
end)]]
--je voudrais ajouter des particules autour du joueur quand il est bourré
--I'd like to add some particles around the player when he's drank


minetest.register_craftitem("beer:crude_beer_mix", {
	description = "Crude beer mix",
	inventory_image = "beer_crude_mix.png",
})

minetest.register_craftitem("beer:fine_beer_mix", {
	description = "Fine beer mix",
	inventory_image = "beer_fine_mix.png",
})
minetest.register_craftitem("beer:empty_tankard", {
	description = "Empty tankart",
	inventory_image = "beer_empty_tankart.png",


})

function decrDrunkLevel(name)
	drunklevel[name] = drunklevel[name] - 1
end

minetest.register_craftitem("beer:beer_tankard", {
	description = "Beer tankart",
	inventory_image = "beer_beer_tankart.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		minetest.sound_play("drink_a_beer")
		drunklevel[user:get_player_name()] = drunklevel[user:get_player_name()] + 1
		name = user:get_player_name()
		minetest.after(30, decrDrunkLevel,name)
		return ItemStack("beer:empty_tankard ")
		end

})


--------------------------------------------------

minetest.register_globalstep(function(dtime)


for _, p in ipairs(minetest.get_connected_players()) do
		if drunklevel[p:get_player_name()] == nil
			then
				drunklevel[p:get_player_name()] = 0
			end
		if drunklevel[p:get_player_name()] >= 6
		then

			--local yaw = p:get_look_pitch()--*180/math.pi
			--yaw = yaw + math.random(-10,10)/200			
			--p:set_look_pitch(yaw*math.pi/180)
			local dir = {x=0,y=0,z=0}
			dir.x = p:get_look_dir().x *20
			dir.y = p:get_look_dir().y *20
			dir.z = p:get_look_dir().z *20
			minetest.add_particle(
					{x=p:getpos().x + dir.x/100 + math.random(-10,10)/50,
				 	y=p:getpos().y + 1   + math.random(-10,10)/50,
				 	z=p:getpos().z + dir.z/100 + math.random(-10,10)/50}, 
					{x=dir.x/100 + math.random(-10,10)/100,
					 y=dir.y/100 + 3,
					 z=dir.z/100 + math.random(-10,10)/100},
					 {x=0, y=-5, z=0},
					 0.2,
					 math.random(10,30)/10, false, "spirale.png")
		end
		
		

	end
end)

--------------------------------------------------


minetest.register_craft({
	type = "shapeless",	
	output = "beer:crude_beer_mix",
	recipe = {"beer:cone","bucket:bucket_water"},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
})

minetest.register_craft({
	type = "cooking",	
	output = "beer:fine_beer_mix",
	recipe = "beer:crude_beer_mix",
	cooktime = 10,
})

minetest.register_craft({
	output = "beer:empty_tankard 3",
	recipe = {
		{"default:glass",""		,"default:glass"},
		{"default:glass","default:glass",""		},
		{""		,""		,""		}},
})

minetest.register_craft({
	type = "fuel",
	recipe = "beer:cone",
	burntime = 1
})

dofile(minetest.get_modpath("beer").."/barrel.lua")

