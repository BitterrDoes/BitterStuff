-- variables
BitterTestingtuff = SMODS.current_mod
BitterTestingtuff.ModsUsing = 0
G.effectmanager = {}
-- Fucntions

function BitterTestingtuff.Load_file(file) -- basically just SMODS.load_file() but safer, so i can accidentally have somethign break and it be chill
	local chunk = SMODS.load_file(file, "Bittertest_Jokers")
	if chunk then
		local ok, func = pcall(chunk)
		if ok then
			print("Bitter's Stuff | loaded ".. file)
			return func
		else
			print("Bitter's Stuff | Failed on ".. file, " : ", func)
		end
	end
	return nil
end

function BitterTestingtuff.Load_Dir(directory)
	local files = NFS.getDirectoryItems(BitterTestingtuff.path .. "/" .. directory)
	local regular_files = {}

	for _, filename in ipairs(files) do -- iterate over all files in the directory
		local file_path = directory .. "/" .. filename
		if file_path:match(".lua$") then -- check if its lua
			if filename:match("^_") then -- i dont even know
				BitterTestingtuff.Load_file(file_path) -- load lua file
			else
				table.insert(regular_files, file_path) -- add non lua to other table
			end
		end
	end

	for _, file_path in ipairs(regular_files) do
		BitterTestingtuff.Load_file(file_path) -- load the other things
	end
end

-- okay okay, actually load the objects now
BitterTestingtuff.Load_Dir("Scripts")

function BitterTestingtuff.reset_game_globals(init) -- i needed to put this somewhere, and this is the first thing that came to mind
	Reset_card_picker_selection()
	BitterTestingtuff.ModsUsing = 0
	for _, mod in pairs(SMODS.Mods) do
		if mod.disabled ~= nil then goto continue end
		
		BitterTestingtuff.ModsUsing = BitterTestingtuff.ModsUsing + 1
	    ::continue::
	end
end

function Reset_card_picker_selection()
    G.GAME.current_round.card_picker_selection = { rank = 'Ace', suit = 'Spades' }
    local valid_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
            valid_cards[#valid_cards + 1] = playing_card
        end
    end
    local picked_card = pseudorandom_element(valid_cards, 'card_picker' .. G.GAME.round_resets.ante)
    if picked_card then
        G.GAME.current_round.card_picker_selection = {
            rank = picked_card.base.value,
            suit = picked_card.base.suit,
            id = picked_card.base.id
        }
    end
end

BitterTestingtuff.ModsUsing = 0
for _, mod in pairs(SMODS.Mods) do
	if mod.disabled ~= nil then goto continue end
	
	BitterTestingtuff.ModsUsing = BitterTestingtuff.ModsUsing + 1
    ::continue::
end