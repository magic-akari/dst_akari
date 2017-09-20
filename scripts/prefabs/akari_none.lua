local assets =
{
  Asset( "ANIM", "anim/akari.zip" ),
  Asset( "ANIM", "anim/ghost_akari_build.zip" ),
}

local skins =
{
  normal_skin = "akari",
  ghost_skin = "ghost_akari_build",
}

local base_prefab = "akari"

local tags = {"AKARI", "CHARACTER"}

return CreatePrefabSkin("akari_none",
{
  base_prefab = base_prefab,
  skins = skins,
  assets = assets,
  tags = tags,

  skip_item_gen = true,
  skip_giftable_gen = true,
})
