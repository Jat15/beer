local S

if intllib then
	S = intllib.Getter()
else
	S = function(s) return s end
end

minetest.register_node("beer:beer_barrel", {
	description = S("Beer barrel"),
	tiles = {"beer_barrel.png", "beer_barrel.png", "beer_barrel.png^[transformR90",
	"beer_barrel.png^[transformR90", "beer_barrel_face.png", "beer_barrel_face.png"},
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	furnace_burntime = 20,
	on_rightclick = function(pos, node, clicker, itemstack)
		local meta = minetest.get_meta(pos);
		local beer_amount = meta:get_int("beer_amount")
		if itemstack:to_string() == "beer:empty_tankard" then
			meta:set_int("beer_amount",beer_amount - 1)
			meta:set_string("infotext",S("Beer barrel, %d beers left"):format(beer_amount))
			if meta:get_int("beer_amount") <= -1 then
				minetest.sound_play("empty_barrel",{pos = pos, max_hear_distance = 15,})
				meta:set_int("beer_amount",0)
				return
			end
			minetest.sound_play("have_a_beer",{pos = pos, max_hear_distance = 15,})
			return ItemStack("beer:beer_tankard ")
		end
		if string.find(itemstack:to_string(), "fine_beer_mix") ~= nil then
			minetest.sound_play("filled_barrel",{pos = pos, max_hear_distance = 15,})
			if meta:get_int("beer_amount") >=99 then
				return
			end
			meta:set_int("beer_amount",beer_amount + 10)
			meta:set_string("infotext",S("Beer barrel, %d beers left"):format(beer_amount))
			itemstack:take_item(1)
			return itemstack
		end
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		if meta:get_int("beer_amount") == nil then
			meta:set_int("beer_amount", 0)
		end
		meta:set_string("infotext",S("Beer barrel, %d beers left"):format(meta:get_int("beer_amount")))
	end,
})

minetest.register_craft({
	output = "beer:beer_barrel",
	recipe = {
		{"default:steel_ingot","default:wood","default:steel_ingot"},
		{"default:wood",""			,"default:wood"},
		{"default:steel_ingot","default:wood","default:steel_ingot"}},
})