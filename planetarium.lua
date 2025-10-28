SMODS.current_mod.optional_features={
    retrigger_joker=true,
    post_trigger=true,
    cardareas={
        deck=true,
        discard=true,
    },
}
assert(SMODS.load_file("lib/oth.lua"))()

SMODS.Atlas{
    key="plt_j_atlas",
    px=71,
    py=95,
    path="jokers.png",
}

assert(SMODS.load_file("lib/overrides.lua"))()

assert(SMODS.load_file("items/jokers.lua"))()
assert(SMODS.load_file("items/zodiac.lua"))()
assert(SMODS.load_file("items/pokerhands.lua"))()
assert(SMODS.load_file("items/planets.lua"))()
assert(SMODS.load_file("items/seals.lua"))()
assert(SMODS.load_file("items/spectrals.lua"))()
--assert(SMODS.load_file("items/green_card.lua"))()

assert(SMODS.load_file("debug_deck.lua"))()