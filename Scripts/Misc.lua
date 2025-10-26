-- backs
SMODS.Back {
    key = "pirateback",

    loc_txt = {
        name = "Snowy Deck",
        text = {"Starts with an", "{C:enhanced,E:1}Eternal, Unlucky{}", "Pirate Software", "win ante is 7", "{C:inactive,s:0.75} 'There's snow on my face' {}"}
    },

    atlas = "backatlas",
    pos = { x = 0, y = 0 },
    config = { card = "j_Bitters_piratesoftware" },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.card } }
    end,
    apply = function(self, back)
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

-- vouchers
-- SMODS.Voucher {
--     key = "negvouch1",
    
--     loc_txt = {
--         name = "Negative Voucher",
--         text = {"All {C:}Negative{} {C:attention}jokers{} are retriggered once"}
--     },

--     atlas = 'voucherAtlas',
--     pos = { x = 0, y = 0 },

--     calculate = function(self, card, context) -- taken from "BitterDoes"
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