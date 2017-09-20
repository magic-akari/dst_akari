PrefabFiles = {
  "akari",
  "akari_none",
  "odango"
}

Assets = {
  Asset( "IMAGE", "images/saveslot_portraits/akari.tex" ),
  Asset( "ATLAS", "images/saveslot_portraits/akari.xml" ),

  Asset( "IMAGE", "images/selectscreen_portraits/akari.tex" ),
  Asset( "ATLAS", "images/selectscreen_portraits/akari.xml" ),

  Asset( "IMAGE", "images/selectscreen_portraits/akari_silho.tex" ),
  Asset( "ATLAS", "images/selectscreen_portraits/akari_silho.xml" ),

  Asset( "IMAGE", "bigportraits/akari.tex" ),
  Asset( "ATLAS", "bigportraits/akari.xml" ),

  Asset( "IMAGE", "images/map_icons/akari.tex" ),
  Asset( "ATLAS", "images/map_icons/akari.xml" ),

  Asset( "IMAGE", "images/avatars/avatar_akari.tex" ),
  Asset( "ATLAS", "images/avatars/avatar_akari.xml" ),

  Asset( "IMAGE", "images/avatars/avatar_ghost_akari.tex" ),
  Asset( "ATLAS", "images/avatars/avatar_ghost_akari.xml" ),

  Asset( "IMAGE", "images/avatars/self_inspect_akari.tex" ),
  Asset( "ATLAS", "images/avatars/self_inspect_akari.xml" ),

  Asset( "IMAGE", "images/names_akari.tex" ),
  Asset( "ATLAS", "images/names_akari.xml" ),

  Asset( "IMAGE", "bigportraits/akari_none.tex" ),
  Asset( "ATLAS", "bigportraits/akari_none.xml" ),
}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.akari = "Akaza Akari"
STRINGS.CHARACTER_NAMES.akari = "Akaza Akari"
STRINGS.CHARACTER_DESCRIPTIONS.akari = "*A harmony-loving, nice girl.\n*Enjoy being with friends.\n*Don't like violence."
STRINGS.CHARACTER_QUOTES.akari = "\"Akaza Akari is the main Character.\""

STRINGS.CHARACTERS.GENERIC.DESCRIBE.ODANGO = "Akari's Odango is kawaii."


-- Custom speech strings
STRINGS.CHARACTERS.AKARI = require "speech_akari"

-- The character's name as appears in-game
STRINGS.NAMES.AKARI = "Akari"
STRINGS.NAMES.ODANGO = "Akari's Odango"


AddMinimapAtlas("images/map_icons/akari.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("akari", "FEMALE")
