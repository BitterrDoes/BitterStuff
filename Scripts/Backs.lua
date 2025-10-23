SMODS.Back {
    key = "pirateback",

    loc_txt = {
        name = "Snowy Deck",
        text = {"Starts with an", "{C:enhanced,E:1}Eternal, Unlucky{}", "Pirate Software", "win ante is 7", "{C:inactive,s:0.75} 'There's snow on my face' {}"}
    },

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