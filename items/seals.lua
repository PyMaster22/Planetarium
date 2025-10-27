SMODS.Seal{
	-- planet card of played hand when played
	key="plt_navy",
	pos={x=6,y=4},
	badge_colour=HEX("0000A0"),
	calculate=function(self,card,context)
		if(context.main_scoring and context.cardarea==G.play
		and #G.consumeables.cards + G.GAME.consumeable_buffer<G.consumeables.config.card_limit)then
			G.GAME.consumeable_buffer=G.GAME.consumeable_buffer+1
			G.E_MANAGER:add_event(Event({
				trigger="before",
				delay=0.0,
				func=function()
					local _planet=nil
					for k,v in pairs(G.P_CENTER_POOLS.Planet)do
						if(v.config.hand_type==G.GAME.last_hand_played)then
							_planet=v.key
						end
					end
					if(_planet)then
						SMODS.add_card({key=_planet})
					end
					G.GAME.consumeable_buffer=0
					return(true)
				end
			}))
			return{message=localize("k_plus_planet"),color=G.C.SECONDARY_SET.Planet}
		end
	end
}

SMODS.Seal{
	-- negative planet card of played hand when retriggered
	key="plt_tanzanite",
	pos={x=6,y=4},
	config={extra={triggers=0}},
	badge_colour=HEX("4646f0"),
	calculate=function(self,card,context)
		if(context.main_scoring)then
			card.ability.seal.extra.triggers=card.ability.seal.extra.triggers+1
			if(card.ability.seal.extra.triggers>1)then
				G.E_MANAGER:add_event(Event({
					trigger="before",
					delay=0.0,
					func=function()
						local _planet=nil
						for k,v in pairs(G.P_CENTER_POOLS.Planet)do
							if(v.config.hand_type==G.GAME.last_hand_played)then
								_planet=v.key
							end
						end
						if(_planet)then
							SMODS.add_card{key=_planet,edition="e_negative"}
						end
						return(true)
					end
				}))
				return{message=localize("k_plus_planet"),color=G.C.SECONDARY_SET.Planet}
			end
		end
		if(context.final_scoring_step)then
			card.ability.seal.extra.triggers=0
		end
	end
}

SMODS.Seal{
	-- Needs refactor
	key="plt_royal_blue",
	pos={x=6,y=4},
	config={extra={money=2,counted_planets=0}},
	badge_colour=HEX("305CDE"),
	loc_vars=function(self,info_queue,card)
		return{vars={card.ability.seal.extra.money}}
	end,
	calculate=function(self,card,context)
		if(context.main_scoring and context.cardarea==G.play)then
			if(context.other_consumeable and context.other_consumable.ability.set=="Planet")then
				card.ability.extra.seal.counted_planets=card.ability.seal.extra.counted_planets+1
			end
			if(not context.other_consumable)then
				return{dollars=card.ability.seal.extra.money*card.ability.seal.extra.counted_planets}
			end
		end
		if(context.end_of_round)then
			card.ability.seal.extra.counted_planets=0
		end
	end
}

SMODS.Seal{
	-- +10 chips per card in full deck with this seal
	key="plt_foiled",
	pos={x=6,y=4},
	config={extra={chips_per=10}},
	badge_colour=HEX("b5c4c4"),
	loc_vars=function(self,info_queue,card)
		local foiled_tally=0
        for _, playing_card in ipairs(G.playing_cards) do
            if(playing_card.seal=="plt_foiled")then
				foiled_tally=foiled_tally+1
			end
        end
		return{vars={card.ability.seal.extra.chips_per,card.ability.seal.extra.chips_per*foiled_tally}}
	end,
	calculate=function(self,card,context)
		if(context.main_scoring and context.cardarea==G.play)then
			local foiled_tally=0
            for _, playing_card in ipairs(G.playing_cards) do
                if(playing_card.seal=="plt_foiled")then
					foiled_tally=foiled_tally+1
				end
            end
			return{chips=card.ability.seal.extra.chips_per*foiled_tally}
		end
	end
}