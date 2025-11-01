-- backs
SMODS.Back {
    key = "pirateback",

    loc_txt = {
        name = "Blizzard Deck",
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

-- oh god
-- SMODS.Scoring_Calculation{
--     key = "math_display",
--     order = 999,
--     func = function (self, chips, mult, flames)
--         local to_big = to_big or function(x) return x end
--         if flames then
--             if to_big(G.GAME.aikoyori_evaluation_value) == to_big(G.GAME.blind.chips) then
--                 return to_big(G.GAME.aikoyori_evaluation_value) * 100
--             end
--             return 0
--         else
--             return to_big(G.GAME.aikoyori_evaluation_value) - to_big(G.GAME.chips)
--         end
--     end,
--     replace_ui = function(self)
--         return {
--             n = G.UIT.R,
--             config = { align = "cm", padding = 0.1, id = 'hand_operator_container' },
--             nodes = {
--                 {
--                     n = G.UIT.O,
--                     config = {
--                         object = DynaText({ string = {{ ref_table = G.GAME, ref_value = "aikoyori_evaluation_value" }}, scale = 0.6, colours = {G.C.WHITE}, akyrs_number_format = 1e15 })
--                     }
--                 }
--             }
--         }
--     end,
--     update_ui = function (self, container, chip_display, mult_display, operator)
--         container.UIBox:update()
--     end
-- }

SMODS.Scoring_Parameter({
    key = 'exvertial',
    default_value = 1,
    colour = mix_colours(G.C.PURPLE, G.C.YELLOW, 0.5),
    calculation_keys = {'exvert'},
    hands = {
        ['Pair'] = {['Bitters_exvert'] = 10, ['l_Bitters_exvert'] = 5, ['s_Bitters_exvert'] = 10},
        ['Four of a Kind'] = {['Bitters_exvert'] = 10, ['l_Bitters_exvert'] = 5, ['s_Bitters_exvert'] = 10},
        ["Flush Five"] = {['Bitters_exvert'] = 1, ['l_Bitters_exvert'] = 5, ['s_Bitters_exvert'] = 1},
        ["Flush House"] = {['Bitters_exvert'] = 1, ['l_Bitters_exvert'] = 5, ['s_Bitters_exvert'] = 1},
        ["Five of a Kind"] = {['Bitters_exvert'] = 1, ['l_Bitters_exvert'] = 5, ['s_Bitters_exvert'] = 1},
        ["Straight Flush"] = {['Bitters_exvert'] = 1, ['l_Bitters_exvert'] = 5, ['s_Bitters_exvert'] = 1},
        ["Full House"] = {['Bitters_exvert'] = 1, ['l_Bitters_exvert'] = 5, ['s_Bitters_exvert'] = 1},
        ["Flush"] = {['Bitters_exvert'] = 1, ['l_Bitters_exvert'] = 5, ['s_Bitters_exvert'] = 1},
        ["Straight"] = {['Bitters_exvert'] = 1, ['l_Bitters_exvert'] = 5, ['s_Bitters_exvert'] = 1},
        ["Three of a Kind"] = {['Bitters_exvert'] = 1, ['l_Bitters_exvert'] = 5, ['s_Bitters_exvert'] = 1},
        ["Two Pair"] = {['Bitters_exvert'] = 1, ['l_Bitters_exvert'] = 5, ['s_Bitters_exvert'] = 1},
        ["High Card"] = {['Bitters_exvert'] = 1, ['l_Bitters_exvert'] = 5, ['s_Bitters_exvert'] = 1},
    },
    calc_effect = function(self, effect, scored_card, key, amount, from_edition)
        if not SMODS.Calculation_Controls.chips then return end

        if key == 'exvert' and amount then
            if effect.card and effect.card ~= scored_card then juice_card(effect.card) end

            self:modify(amount)
            ard_eval_status_text(scored_card, 'extra', nil, percent, nil,
            {message = localize{type = 'variable', key = amount > 0 and 'a_chips' or 'a_chips_minus', vars = {amount}}, colour = self.colour})
            return true
        end
    end,
})