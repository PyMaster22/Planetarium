SMODS.Back{
	key="nebulous",
	pos={x=0,y=0},
	config={dollars=1e200,hands=1e200,discards=1e200,hand_size=52-8,joker_slot=100,ante_scaling=4},
	apply=function(self,back)
        G.E_MANAGER:add_event(Event({
            func=function()
                for k,v in pairs(G.playing_cards)do
                    if(v.base.rank~="Ace")then
                        --SMODS.destroy_cards(v)
                    end
                end
                for k,v in pairs(G.playing_cards)do
                    v.base.chips=1
                end
                return(true)
            end
        }))
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                local _cards={"j_plt_aries"}
                for i=1,#_cards do
                    SMODS.add_card({key=_cards[i]})
                    --[[local card=SMODS.create_card({set='Joker',key="j_plt_hypernova"})
                    card:set_edition({negative=true})
                    card:add_to_deck()
                    card:start_materialize()
                    G.jokers:emplace(card)]]
                end
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
