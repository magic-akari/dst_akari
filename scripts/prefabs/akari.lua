
local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
  Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {}

-- Custom starting items
local start_inv = {
  "odango",
}

-- When the character is revived from human
local function onbecamehuman(inst)
  -- Set speed when reviving from ghost (optional)
    inst.components.locomotor:SetExternalSpeedMultiplier(inst, "akari_speed_mod", 1)
end

local function onbecameghost(inst)
  -- Remove speed modifier when becoming a ghost
 inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "akari_speed_mod")
end

-- When loading or spawning the character
local function onload(inst)
  inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
  inst:ListenForEvent("ms_becameghost", onbecameghost)

  if inst:HasTag("playerghost") then
      onbecameghost(inst)
  else
    onbecamehuman(inst)
  end
end


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst)
  -- Minimap icon
  inst.MiniMapEntity:SetIcon( "akari.tex" )
  inst:AddTag("akari")
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play
  inst.soundsname = "willow"

  -- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"

  -- Stats
  inst.components.health:SetMaxHealth(150)
  inst.components.hunger:SetMax(150)
  inst.components.sanity:SetMax(200)

  -- Damage multiplier (optional)
  inst.components.combat.damagemultiplier = 1

  -- Hunger rate (optional)
  inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE

  inst:ListenForEvent("killed", function(inst, data)
    if not data.victim:HasTag("monster") then
      inst.components.sanity:DoDelta(-10)
    end
  end)

  inst:ListenForEvent("onattackother", function (inst, data)
    local sanity_percent = inst.components.sanity:GetPercent()
    local health = inst.components.health.currenthealth

    if not data.target:HasTag("monster") then
      if sanity_percent > 0.5 then
        inst.components.sanity:DoDelta(-1)
      end
      if health > 50 then
        inst.components.health:DoDelta(-1)
      end
    end

  end)

  inst:DoPeriodicTask(5, function ()
      local hunger_percent = inst.components.hunger:GetPercent()
      local sanity_percent = inst.components.sanity:GetPercent()

      -- change the speed according to the hunger_percent
      local speedmult = 0.3 + math.exp(hunger_percent - 0.7)
      inst.components.locomotor:SetExternalSpeedMultiplier(inst, "akari_speed_mod", speedmult)

      if sanity_percent > 0.8 then
        inst:AddTag("debugnoattack")
        inst:RemoveTag("scarytoprey")
        inst:AddTag("notarget")

        if inst.components.sanityaura == nil then
          inst:AddComponent("sanityaura")
          inst.components.sanityaura.aura = TUNING.SANITYAURA_MED
        end
      else
        inst:RemoveTag("debugnoattack")
        inst:AddTag("scarytoprey")
        inst:RemoveTag("notarget")

        if inst.components.sanityaura ~= nil then
          inst:RemoveComponent("sanityaura")
        end
      end

  end)


	inst.OnLoad = onload
  inst.OnNewSpawn = onload

end

return MakePlayerCharacter("akari", prefabs, assets, common_postinit, master_postinit, start_inv)
