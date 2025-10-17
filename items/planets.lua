SMODS.Consumable{
	key="plt_royal_planet",
	set="Planet",
	cost=3,
	pos={x=7,y=3},
	config={hand_type="plt_royal_flush"},
	loc_vars=function(self,info_queue,card)
		return{vars={
			G.GAME.hands[card.ability.hand_type].level,
			localize(card.ability.hand_type,"poker_hands"),
			G.GAME.hands[card.ability.hand_type].l_mult,
			G.GAME.hands[card.ability.hand_type].l_chips,
			colours={(G.GAME.hands[card.ability.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)])}
		}}
	end
}

-- Actually spectral, upgrades planets!
SMODS.Consumable{
	key="plt_nullius_planet",
	set="Spectral",
	soul_set="Celestial",
	hidden=false,
	cost=4,
	pos={x=8,y=3},
	config={extra={lmult_gain=1,lchips_gain=5}},
	loc_vars=function(self,info_queue,card)
		if(G.hand==nil)then
			return{vars={
				card.ability.extra.lmult_gain,
				card.ability.extra.lchips_gain,
				"none"
			}}
		end
		return{vars={
			card.ability.extra.lmult_gain,
			card.ability.extra.lchips_gain,
			#G.hand.highlighted>0 and localize(G.FUNCS.get_poker_hand_info(G.hand.highlighted),"poker_hands") or "none"
		}}
	end,
	can_use=function(self,card)
		--return(true)
		return(#G.hand.highlighted>0)
	end,
	use=function(self,card,area,copier)
		local used_consumable = copier or card
		local hand=G.FUNCS.get_poker_hand_info(G.hand.highlighted)
		if(#G.hand.highlighted<1)then
			local card2=copy_card(card)
			card2:add_to_deck()
			G.consumeables:emplace(card2)
			return(true)
		end
		G.GAME.hands[hand].l_mult=G.GAME.hands[hand].l_mult+card.ability.extra.lmult_gain
		G.GAME.hands[hand].l_chips=G.GAME.hands[hand].l_chips+card.ability.extra.lchips_gain
		update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
			{handname=hand,chips="+"..tostring(card.ability.extra.lchips_gain),mult="+"..tostring(card.ability.extra.lmult_gain),level=""}
		)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.2,
			func = function()
				play_sound("tarot1")
				used_consumable:juice_up(0.8, 0.5)
				G.TAROT_INTERRUPT_PULSE = true
				return true
			end,
		}))
		update_hand_text({delay=0},{mult=tostring(G.GAME.hands[hand].l_mult),StatusText=true})
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.2,
			func = function()
				play_sound("tarot1")
				used_consumable:juice_up(0.8, 0.5)
				G.TAROT_INTERRUPT_PULSE = true
				return true
			end,
		}))
		update_hand_text({delay=0},{chips=tostring(G.GAME.hands[hand].l_chips),StatusText=true})
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.9,
			func = function()
				play_sound("tarot1")
				used_consumable:juice_up(0.8, 0.5)
				G.TAROT_INTERRUPT_PULSE = nil
				return true
			end,
		}))
		update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "Empowered" })
		delay(1.3)
		update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)
	end,
	add_to_deck=function(self, card, from_debuff)end,
}

--[[SMODS.Consumable{
	key="plt_strengthen_pluto",
	set="Planet",
	cost=4,
	pos={x=8,y=3},
	config={extra={lmult_gain=1,lchips_gain=5}},
	loc_vars=function(self,info_queue,card)
		return{vars={card.ability.extra.lmult_gain,card.ability.extra.lchips_gain}}
	end,
	can_use=function(self,card) return(true) end,
	use=function(self,card,area,copier)
		G.GAME.hands["High Card"].l_mult=G.GAME.hands["High Card"].l_mult+card.ability.extra.lmult_gain
		G.GAME.hands["High Card"].l_chips=G.GAME.hands["High Card"].l_chips+card.ability.extra.lchips_gain
	end
}]]