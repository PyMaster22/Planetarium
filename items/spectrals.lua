

SMODS.Consumable{
	key="plt_merge_seals",
	set="Spectral",
	pos={x=3,y=5},
	config={max_highlighted=2,min_highlighted=2},
	loc_vars=function(self,info_queue,card)
		return{vars={card.ability.max_highlighted}}
	end,
	use=function(self,card,area,copier)
		local function helper(seal)
			if(seal=="Blue") then return(2) end
			if(seal=="Red") then return(3) end
			if(seal=="Gold") then return(5) end
			if(seal=="Purple") then return(7) end
			return(1)
		end
		local card1=G.hand.highlighted[1]
		local card2=G.hand.highlighted[2]
		local newseal=helper(card1.seal)*helper(card2.seal)
		G.E_MANAGER:add_event(Event({
			func=function()
				play_sound("tarot1")
				SMODS.destroy_cards(card1)
				card2:juice_up(0.3,0.5)
				return(true)
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger="after",
			delay=0.1,
			func=function()
				-- Blue + Blue -> Navy ( Planet when played )
				-- Blue + Red -> Tanzanite ( Negative planet when retriggered )
				-- Blue + Gold -> Royal Blue ( $2 Per planet card in "inventory" )
				-- Blue + Purple -> Blurple ( Planet when discarded )
				-- Red + Red -> Ruby ( Retrigger cards agjacent once )
				-- Red + Gold -> Citrine ( $3 when triggered )
				-- Red + Purple -> Amethyst ( Negative tarot when retriggered - To OP?? )
				-- Gold + Gold -> Platinum ( $3 when held in hand )
				-- Gold + Purple -> Rose Gold ( Money related tarots )
				-- Purple + Purple -> Ultramarine ( Spectral card when held in hand at end of round, higher chance of Combinare )
				-- Nil + [Any] -> [Any] (Just deletes the one card)
				--local newseal=helper(seal1)*helper(card2.seal)
				if(newseal==1*2) then card2:set_seal("Blue",nil,true) end
				if(newseal==1*3) then card2:set_seal("Red",nil,true) end
				if(newseal==1*5) then card2:set_seal("Gold",nil,true) end
				if(newseal==1*7) then card2:set_seal("Purple",nil,true) end
				if(newseal==2*2) then card2:set_seal("plt_navy",nil,true) end
				if(newseal==2*3) then card2:set_seal("plt_tanzanite",nil,true) end
				if(newseal==2*5) then card2:set_seal("plt_royal_blue",nil,true) end
				if(newseal==2*7) then card2:set_seal("plt_blurple",nil,true) end
				if(newseal==3*3) then card2:set_seal("plt_ruby",nil,true) end
				if(newseal==3*5) then card2:set_seal("plt_citrine",nil,true) end
				if(newseal==3*7) then card2:set_seal("plt_amethyst",nil,true) end
				if(newseal==5*5) then card2:set_seal("plt_platinum",nil,true) end
				if(newseal==5*7) then card2:set_seal("plt_rose_gold",nil,true) end
				if(newseal==7*7) then card2:set_seal("plt_ultramarine",nil,true) end
				
				return(true)
			end
		}))

		delay(0.5)
		G.E_MANAGER:add_event(Event({
			trigger="after",
			delay=0.2,
			func=function()
				G.hand:unhighlight_all()
				return(true)
			end
		}))
	end,
	add_to_deck=function(self, card, from_debuff)end,
}

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
		SMODS.smart_level_up_hand(card,G.FUNCS.get_poker_hand_info(G.hand.highlighted),true,1)
	end,
	add_to_deck=function(self, card, from_debuff)end,
}