--- ahhhhhhhhhhhhhhhhhhh
to_big = to_big or function(x) return x end
function len(table)
	local count = 0
	for i in pairs(table) do
		count = count + 1
	end
	return count
end

-- variables
Bitterstuff = SMODS.current_mod
Bitterstuff.ModsUsing = 0
G.effectmanager = {}

-- setup
Bitterstuff.optional_features = {
	retrigger_joker = true
}

-- Fucntions
Bitterstuff.calculate = function(self, context)
	if context.setting_blind then
		G.GAME.playing = true
		if G.GAME.round_bonus.dollars and G.GAME.round_bonus.dollars ~= 0 then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					ease_dollars(G.GAME.round_bonus.dollars,true)
					return true
				end
			}))
		end
	elseif context.end_of_round and context.main_eval then
		G.GAME.playing = false
	end
end

function Bitterstuff.Load_file(file) -- basically just SMODS.load_file() but safer, so i can accidentally have somethign break and it be chill
	local chunk = SMODS.load_file(file, "Bitters_Jokers")
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

function Bitterstuff.Load_Dir(directory)
	local files = NFS.getDirectoryItems(Bitterstuff.path .. "/" .. directory)
	local regular_files = {}

	for _, filename in ipairs(files) do -- iterate over all files in the directory
		local file_path = directory .. "/" .. filename
		if file_path:match(".lua$") then -- check if its lua
			if filename:match("^_") then -- i dont even know
				Bitterstuff.Load_file(file_path) -- load lua file
			else
				table.insert(regular_files, file_path) -- add non lua to other table
			end
		end
	end

	for _, file_path in ipairs(regular_files) do
		Bitterstuff.Load_file(file_path) -- load the other things
	end
end

-- okay okay, actually load the objects now
Bitterstuff.Load_Dir("Scripts")
Bitterstuff.Load_Dir("Scripts/Jokers")
Bitterstuff.Load_Dir("Scripts/Assets")

Bitterstuff.crossmodded = {}

for _, file in pairs(NFS.getDirectoryItems(Bitterstuff.path .. "/Scripts/Compatibility")) do
	local mod = SMODS.find_mod(file)
	if next(mod) then
		Bitterstuff.crossmodded[mod[1].id] = mod
		Bitterstuff.Load_Dir("Scripts/Compatibility/".. file)
	end
end

-- other stuff

function Bitterstuff.reset_game_globals(init, _GAME) -- i needed to put this somewhere, and this is the first thing that came to mind
	if not _GAME then 
		Reset_card_picker_selection()
	end
	if G.GAME then
		G.GAME.round_bonus.dollars = 0
	end
	Bitterstuff.ModsUsing = 0
	for i,_ in pairs(SMODS.Mods) do
		Bitterstuff.ModsUsing = Bitterstuff.ModsUsing + (1 / 15)
	end
	Bitterstuff.ModsUsing = math.floor(Bitterstuff.ModsUsing)

	local dir = Bitterstuff.path -- should be C:\Users\[player name]\AppData\Roaming\Balatro\Mods\Bitterstuff
    G.DwnldsDir = string.sub(dir, 0, #dir - 41).. "Downloads" -- becomes C:\Users\[player name]\Downloads
    G.DocDir = string.sub(dir, 0, #dir - 41).. "Videos" -- for tom foolery
	local items = #NFS.getDirectoryItems(G.DwnldsDir) / 20
	if items < 15 then
    	Bitterstuff.Downloads = 15
	else
    	Bitterstuff.Downloads = items
	end
end

function Reset_card_picker_selection()
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

Bitterstuff.reset_game_globals(false, true) -- so sketch