SMODS.current_mod.optional_features={
    retrigger_joker=true,
    post_trigger=true,
    cardareas={
        deck=true,
        discard=true,
    },
}

assert(SMODS.load_file("lib/oth.lua"))()
assert(SMODS.load_file("items/jokers.lua"))()
assert(SMODS.load_file("items/pokerhands.lua"))()
assert(SMODS.load_file("items/planets.lua"))()
assert(SMODS.load_file("items/seals.lua"))()
assert(SMODS.load_file("items/spectrals.lua"))()
--assert(SMODS.load_file("items/green_card.lua"))()

--assert(SMODS.load_file("debug_deck.lua"))()