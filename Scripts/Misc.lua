-- backs
SMODS.Back {
    key = "pirateback",

    loc_txt = {
        name = "Blizzard Deck",
        text = {"Starts with an", "{C:enhanced,E:1}Eternal, Unlucky{}", "Pirate Software", "win ante is #1#", "{C:inactive,s:0.75} 'There's snow on my face' {}"}
    },

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

    loc_txt = {
        name = "Bitter Deck",
        text = {"Start with BitterDoes", "{C:inactive}Super Faster Scaling per new ante"}
    },

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

    loc_txt = {
        name = "Broken Deck",
        text = {"Start with only five cards,", "win ante is #1#"}
    },

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

-- vouchers
-- SMODS.Voucher {
--     key = "negvouch1",
    
--     loc_txt = {
--         name = "Negative Voucher",
--         text = {"All {C:}Negative{} {C:attention}jokers{} are retriggered once"}
--     },

--     atlas = 'voucherAtlas',
--     pos = { x = 0, y = 0 },

--     calculate = function(self, card, context) -- taken from BitterDoes Joker
--         local results = {}

--         for i, other_joker in pairs(G.jokers.cards) do
--             if other_joker.edition and other_joker.edition.key == "e_negative" then
--                 -- print("found one with negative")
--                 local ret = SMODS.blueprint_effect(card, other_joker, context)
--                 if ret then
--                     table.insert(results, ret)
--                 end
--             end
--         end

--         -- print("merging effects") 
--         return SMODS.merge_effects(results)
--     end
-- }

-- SMODS.Voucher {
--     key = "negvouch2",
    
--     loc_txt = {
--         name = "Negative Voucher",
--         text = {"All {C:}Negative{} {C:attention}jokers{} are retriggered once"}
--     },

--     requires = "v_Bitters_negvouch1",
--     atlas = 'voucherAtlas',
--     pos = { x = 0, y = 0 },

--     calculate = function(self, card, context) -- taken from "BitterDoes"
--         local results = {}

--         for i, other_joker in pairs(G.jokers.cards) do
--             if other_joker.edition and other_joker.edition.key then
--                 -- print("found one with negative")
--                 local ret = SMODS.blueprint_effect(card, other_joker, context)
--                 if ret then
--                     table.insert(results, ret)
--                 end
--             end
--         end

--         -- print("merging effects") 
--         return SMODS.merge_effects(results)
--     end
-- }