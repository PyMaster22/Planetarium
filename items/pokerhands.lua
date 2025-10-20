SMODS.PokerHand{
	key="plt_Royal Flush",
	mult=10,
	chips=120,
	l_mult=6,
	l_chips=60,
	example={
		{"H_A",true},
		{"H_K",true},
		{"H_Q",true},
		{"H_J",true},
		{"H_T",true}
	},
	evaluate=function(parts,hand)
		if(not next(parts._straight) or not next(parts._flush)) then return end
		local royal = true
		for j = 1, #hand do
			local rank = SMODS.Ranks[hand[j].base.value]
			royal = royal and (rank.key == 'Ace' or rank.key == '10' or rank.face)
		end
		if(royal) then
			return{SMODS.merge_lists(parts._straight,parts._flush)}
		end
	end
}

--[[SMODS.PokerHand{
	key="plt_empty",
	mult=1,
	chips=1,
	l_mult=1,
	l_chips=1,
	visible=false,
	example={},
	evaluate=function(parts,hand)
		return{hand and #hand == 0 and {} or nil}
	end
}]]