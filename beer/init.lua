

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
minetest.register_craftitem("beer:beer_tankard", {
	description = "Beer tankart",
	inventory_image = "beer_beer_tankart.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		minetest.sound_play("drink_a_beer")		
		return ItemStack("beer:empty_tankard ")
		end

})

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

