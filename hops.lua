minetest.register_craftitem("farming:hops_seed", {
	description = "hops Seeds",
	inventory_image = "farming_hops_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
		if above.name == "air" then
			above.name = "farming:hops_1"
			minetest.env:set_node(pointed_thing.above, above)
			itemstack:take_item(1)
			return itemstack
		end
	end
})

minetest.register_node("farming:hops_1", {
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_hops_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+6/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:hops_2", {
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_hops_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+12/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:hops", {
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_hops.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'farming:hops_seed'} },
			{ items = {'farming:hops_seed'}, rarity = 2},
			{ items = {'farming:hops_seed'}, rarity = 5},
			{ items = {'beer:cone'} },
			{ items = {'beer:cone'}, rarity = 2 },
			{ items = {'beer:cone'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

farming:add_plant("farming:hops", {"farming:hops_1", "farming:hops_2"}, 50, 20)



-- ========= FUEL =========
minetest.register_craft({
	type = "fuel",
	recipe = "farming:hops_seed",
	burntime = 1
})


