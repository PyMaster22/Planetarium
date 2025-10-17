SMODS.Rarity{
	key="celestial",
	badge_colour=G.C.SECONDARY_SET.Planet,
	default_weight=0,
	get_weight=function(self,weight,object_type)
		return(weight)
	end,
	pools={["Joker"]=true}
}

SMODS.Joker{
	key="plt_hypernova",
	blueprint_compat=true,
	perishable_compat=true,
	rarity="plt_celestial",
    --pools={["plt_celestial_jokers"]=true},
	in_pool=function(self,args) return{false,{allow_duplicates=true}} end,
	cost=0,
	pos={x=2,y=4},
	config={extra={xmult_per=1.1}},
	loc_vars=function(self,info_queue,card)
		return{vars={card.ability.extra.xmult_per}}
	end,
	calculate=function(self,card,context)
		-- WHY TF DO YOU ONLY WORK WITH CRYPTID!?!?!??!?!
		-- hold on, missing mod setting
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == card then
			return {
				message = localize("k_again_ex"),
				repetitions = to_number(G.GAME.hands[G.FUNCS.get_poker_hand_info(G.play.cards)].played)-1,
				card=card
			}
		end
		if(context.joker_main --[[or context.retrigger_joker]])then
			local XMult=1
			for i=1,G.GAME.hands[context.scoring_name].played do
				XMult=XMult*card.ability.extra.xmult_per
			end
			return{xmult=card.ability.extra.xmult_per}--XMult}
		end
	end,
	add_to_deck=function(self, card, from_debuff)end,
}