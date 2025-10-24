-- variables
Bitterstuff = SMODS.current_mod
Bitterstuff.ModsUsing = 0
-- Fucntions

function Bitterstuff.Load_file(file) -- basically just SMODS.load_file() but safer, so i can accidentally have somethign break and it be chill
	local chunk = SMODS.load_file(file, "BitterJokers")
	if chunk then
		local ok, func = pcall(chunk)
		if ok then
			print("loaded ".. file)
			return func
		else
			print("Failed on ".. file, " : ", func)
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
print(Bitterstuff.ModsUsing, " mod(s)")

function Bitterstuff.reset_game_globals(init) -- i needed to put this somewhere, and this is the first thing that came to mind
	Bitterstuff.ModsUsing = 0
	for _, mod in pairs(SMODS.Mods) do
		if mod.disabled == nil then goto continue end
		
		Bitterstuff.ModsUsing = Bitterstuff.ModsUsing + 1
	    ::continue::
	end
end

Bitterstuff.ModsUsing = 0
for _, mod in pairs(SMODS.Mods) do
	if mod.disabled == nil then goto continue end
	
	Bitterstuff.ModsUsing = Bitterstuff.ModsUsing + 1
    ::continue::
end