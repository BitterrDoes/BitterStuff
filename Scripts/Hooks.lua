Bitterstuff = SMODS.current_mod

function decrementingTickEvent(type,tick)
    --event manager
    if type == "G.effectmanager" then
        for i = 1, #G.effectmanager do
            if G.effectmanager[i] and G.effectmanager[i][1] then
                if G.effectmanager[i][1].duration ~= nil and G.effectmanager[i][1].duration >= -1 then
                    _eff = G.effectmanager[i][1]

                    _eff.tfps = _eff.tfps + 1
                    _eff.duration = _eff.duration - 1
                    
                    if _eff.tfps > 100/_eff.fps and _eff.fps ~= 0 then
                        _eff.frame = _eff.frame + 1
                        _eff.tfps = 0

                        if G.effectmanager[i][1].name == "parry" and G.effectmanager[i][1].duration > 77 then 
                            _eff.frame = 1 end     
                    end
                    if _eff.frame > _eff.maxframe then
                        _eff.frame = 1
                    end

                elseif G.effectmanager[i][1].duration ~= nil and G.effectmanager[i][1].duration <= 0 then
                    G.effectmanager[i] = nil
                end
            end
        end
    end

end

local drawhook = love.draw
function love.draw() -- all functions were taken from yahi then, edited by bitter to work better for the circumstance
    drawhook()

    function loadImage(fn) -- fn = file name | Loads specified file and returns loaded image
        local full_path = (Bitterstuff.path 
        .. "Assets/gifs/" .. fn)
        local file_data = assert(NFS.newFileData(full_path),("Epic fail"))
        local tempimagedata = assert(love.image.newImageData(file_data),("Epic fail 2"))
        --print ("LTFNI: Successfully loaded " .. fn)
        return (assert(love.graphics.newImage(tempimagedata),("Epic fail 3")))
    end

    function loadSpritesheet(fn,px,py,subimg,orientation) -- fn = file name, px = pixels x, py = think about it, subimg = amount of images, orientation = direction of sprite sheet | returns loaded image spritesheet
        local full_path = (Bitterstuff.path 
        .. "Assets/gifs/" .. fn)
        local file_data = assert(NFS.newFileData(full_path),("Epic fail"))
        local tempimagedata = assert(love.image.newImageData(file_data),("Epic fail 2"))

        local tempimg = assert(love.graphics.newImage(tempimagedata),("Epic fail 3"))

        local spritesheet = {}
        for i = 1, subimg do
            if orientation == 0 then -- 0 = downwards spritesheet
                table.insert(spritesheet,love.graphics.newQuad(0, (i-1)*py, px, py, tempimg))
            end
            if orientation == 1 then -- 1 = rightwards spritesheet
                table.insert(spritesheet,love.graphics.newQuad((i-1)*px, 0, px, py, tempimg))
            end
        end
        --print ("LTFNIS: Successfully loaded spritesheet " .. fn)

        return (spritesheet)
    end
    

    local _xscale = love.graphics.getWidth()/1920
    local _yscale = love.graphics.getHeight()/1080

    --[[ fish | example for still image 
    -- if G.showfish and (G.showfish > 0) then
    --     --love.graphics.print("ticks:" .. Bitterstuff.ticks, 500, 35)
    --     if Bitterstuff.fishpng == nil then Bitterstuff.fishpng = loadImage("fishondafloo.png") end
    --     love.graphics.setColor(1, 1, 1, 1) 
    --     love.graphics.draw(Bitterstuff.fishpng, 0*_xscale*2, 0*_yscale*2,0,_xscale*2*2,_yscale*2*2)
    -- end

    -- EFFECT MANAGER!!! 
    -- this is where on-screen little gifs play
    --]]

    if G.effectmanager then
        
        --print("Effect manager has "..#G.effectmanager)
        for i = 1, #G.effectmanager do
            --print("G.effectmanager[i].name".. G.effectmanager[i][1].name)
            if G.effectmanager[i] then
                if G.effectmanager[i][1].name == "brick" then
                    Bitterstuff.imagebrick = loadImage("Brick.png")
                    Bitterstuff.imagebricksprite = loadSpritesheet("Brick.png",300,300,86,1)
                    imagetodraw = Bitterstuff.imagebrick
                    quadtodraw = Bitterstuff.imagebricksprite
                    _imgindex = G.effectmanager[i][1].frame
                    --print("_imgindex".. _imgindex)
                    _xpos = G.effectmanager[i][1].xpos
                    _ypos = G.effectmanager[i][1].ypos

                    _xscale = _xscale * 4
                    _yscale = _yscale * 4

                    love.graphics.setColor(1, 1, 1, 1)
                end
                


                
                love.graphics.draw(imagetodraw, quadtodraw[_imgindex], _xpos, _ypos, 0 ,_xscale,_yscale)
            end
        end
    end
end

local upd = Game.update
function Game:update(dt)
    upd(self, dt)

    -- tick based events
    if Bitterstuff.ticks == nil then Bitterstuff.ticks = 0 end
    if Bitterstuff.dtcounter == nil then Bitterstuff.dtcounter = 0 end
    Bitterstuff.dtcounter = Bitterstuff.dtcounter+dt
    Bitterstuff.dt = dt

    while Bitterstuff.dtcounter >= 0.010 do
        Bitterstuff.ticks = Bitterstuff.ticks + 1
        Bitterstuff.dtcounter = Bitterstuff.dtcounter - 0.010

        if #G.effectmanager > 0 then decrementingTickEvent("G.effectmanager",0) end
    end
end

-- local bla = Game.start_run
-- function Game:start_run(table)
--     bla(table)

--     SMODS.Scoring_Calculation({
--         key = "exvertial",
--         func = function(self, chips, mult, flames)
--             print("wawa")
--             return chips * mult * SMODS.get_scoring_parameter('Bitters_exvert', flames)
--         end,
--         parameters = {'chips', 'mult', 'Bitters_exvert'},
--         replace_ui = function(self)
--             local scale = 0.3
--             return
--             {n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
--                 {n=G.UIT.C, config={align = 'cm', id = 'hand_chips'}, nodes = {
--                     SMODS.GUI.score_container({
--                         type = 'chips',
--                         text = 'chip_text',
--                         align = 'cr',
--                         w = 1.1,
--                         scale = scale
--                     })
--                 }},
--                 SMODS.GUI.operator(scale*0.75),
--                 {n=G.UIT.C, config={align = 'cm', id = 'hand_mult'}, nodes = {
--                     SMODS.GUI.score_container({
--                         type = 'mult',
--                         align = 'cm',
--                         w = 1.1,
--                         scale = scale
--                     })
--                 }},
--                 SMODS.GUI.operator(scale*0.75),
--                 {n=G.UIT.C, config={align = 'cm', id = 'hand_Bitters_exvertial'}, nodes = {
--                     SMODS.GUI.score_container({
--                         type = 'Bitters_exvertial',
--                         align = 'cl',
--                         w = 1.1,
--                         scale = scale
--                     })
--                 }},
--             }}
--         end
--     })
-- end

