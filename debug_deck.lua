SMODS.Back{
	key="nebulous",
	pos={x=0,y=0},
	config={dollars=1e200,hands=1e200,discards=1e200,hand_size=52-8,joker_slot=100,ante_scaling=4},
	apply=function(self,back)
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                local card=SMODS.create_card({set='Joker',key="j_plt_hypernova"})
                card:set_edition({negative=true})
                --card.ability.eternal=true
                card:add_to_deck()
                card:start_materialize()
                G.jokers:emplace(card)
                return true
            end
        }))
	end,
	calculate = function(self, back, context)
        if context.final_scoring_step then
            return {
                --balance = true
            }
        end
    end,
}
