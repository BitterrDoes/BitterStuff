-- this makes me control what can and cant go through pool

local smods_add_to_pool = SMODS.add_to_pool
function SMODS.add_to_pool(prototype_obj, args)
	if G.GAME.selected_back_key ~= nil and G.GAME.selected_back_key.add_to_pool ~= nil then
		if not G.GAME.selected_back_key:add_to_pool(prototype_obj, args) then
			return false
		end
	end
	return smods_add_to_pool(prototype_obj, args)
end

function cloverpit.reset_game_globals(init)
		print(cloverpit.ModsUsing)
	if init then
		SMODS.change_voucher_limit(2)
		G.GAME.starting_params.ante_scaling = 3
		cloverpit.StoredChips = 0
	end
end