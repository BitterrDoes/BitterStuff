-- backs
SMODS.Back {
    key = "pirateback",
    name = "Blizzard Deck",

    atlas = "backatlas",
    pos = { x = 0, y = 0 },
    config = { card = "j_Bitters_piratesoftware", ante = 7},
	loc_vars = function(self, info_queue, cad)
		return { vars = {self.config.ante}}
	end,
    apply = function(self, back)
        G.GAME.win_ante = 7
        -- Apply the consumables
        delay(0.4)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.add_card({ key = self.config.card, edition = "e_Bitters_unlucky", stickers = {'eternal'}, force_stickers = true })
                return true
            end
        }))
    end,
}

SMODS.Back {
    key = "BitterBack",
    name = "Bitter Deck",

    atlas = "backatlas",
    pos = { x = 1, y = 0 },
    config = { card = "j_Bitters_bitterjoker" },
    calculate = function(self, back, context)
        if context.end_of_round and G.GAME.blind.boss and context.main_eval then
            G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) * 2.5 -- :trol:
        end
    end,
    apply = function(self, back)
        -- Apply the consumables
        delay(0.4)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.add_card({ key = self.config.card })
                return true
            end
        }))
    end,
}

SMODS.Back {
    key = "BrokenBack",
    name = "Broken Deck",

    atlas = "backatlas",
    pos = { x = 2, y = 0 },
    config = { ante = 6 },
	loc_vars = function(self, info_queue, cad)
		return { vars = {self.config.ante}}
	end,
    in_pool = function(self, args)
        return false
    end,

    apply = function(self, back)
        G.GAME.win_ante = self.config.ante
        G.E_MANAGER:add_event(Event({
            func = function()
                -- SMODS.destroy_cards(G.playing_cards) -- | crashes the game
                for _, v in pairs(G.playing_cards) do
                    SMODS.destroy_cards(v)
                end
                return true
            end
        }))
        -- seperate so it wont be destroyed
        G.E_MANAGER:add_event(Event({
            func = function()
                for i=1, 5 do
                    SMODS.add_card({
                        set = 'Playing Card',
                        area = G.deck
                    })
                end
                
                return true
            end
        }))
    end,
}

SMODS.Sticker {
    key = "s_target",
    loc_txt = {
        name = "Targeted",
        label = 'Targeted',
        text = {"This card is {E:1,C:attention}targeted{}"}
    },
    badge_colour = HEX("EA909C"),

    atlas = "MiscAtlas",
    pos = {x=2,y=0},

    rate = 0,
}