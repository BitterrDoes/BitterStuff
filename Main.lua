-- variables
Bitterstuff = SMODS.current_mod
Bitterstuff.ModsUsing = #NFS.getDirectoryItems(string.reverse(string.sub(string.reverse(Bitterstuff.path), 9, -1))) -- i dunno how to get name of mod folder so ig this is enough
-- Fucntions

function Bitterstuff.Load_file(file) -- basically just SMODS.load_file() but safer, so i can accidentally have somethign break and it be chill
	local chunk = SMODS.load_file(file, "BitterJokers")
	if chunk then
		local ok, func = pcall(chunk)
		if ok then
			print("loaded ".. file)
			return func
		else
			print("Failed on ".. file)
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