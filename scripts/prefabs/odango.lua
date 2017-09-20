local assets=
{
	Asset("ANIM", "anim/odango.zip"),
	Asset("ATLAS", "images/inventoryimages/odango.xml"),
}

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_hat", "odango", "swap_hat")
    owner.AnimState:Show("HAT")
    owner.AnimState:Show("HAIR_HAT")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Hide("HAIR")

    owner.AnimState:Hide("HEAD")
    owner.AnimState:Show("HEAD_HAT")

		inst.Light:Enable(true)

end

local function onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_hat")
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAIR_HAT")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")

    owner.AnimState:Show("HEAD")
    owner.AnimState:Hide("HEAD_HAT")

end

local function addequippable (inst)
	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
end

local function onsave(inst, data)
    if inst.components.equippable ~= nil then
        data.equippable = true
    end
end

local function onload(inst, data)
    if data ~= nil and data.equippable then
			addequippable(inst)
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)
	inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

	inst:AddTag("hat")
	inst:AddTag("odango")

	anim:SetBank("odango")
	anim:SetBuild("odango")
	anim:PlayAnimation("anim")

	local light = inst.entity:AddLight()
	light:SetIntensity(0.2)
	light:SetRadius(0.2)
	light:SetFalloff(0.2)
	light:SetColour(214/255,138/255,138/255)
	light:Enable(true)

  if not TheWorld.ismastersim then
      return inst
  end

  inst:AddComponent("inventoryitem")
  inst.components.inventoryitem.atlasname = "images/inventoryimages/odango.xml"
	inst.components.inventoryitem.imagename = "odango"

	inst:ListenForEvent("onputininventory", function (inst, owner)
		if owner:HasTag("akari") and inst.components.equippable == nil then
			addequippable(inst)
		end
	end)

	inst:ListenForEvent("ondropped", function (inst)
		if inst.components.equippable ~= nil then
			inst:RemoveComponent("equippable")
		end
	end)

	inst:AddComponent("inspectable")
  inst:AddComponent("insulator")
  inst.components.insulator:SetInsulation(TUNING.INSULATION_MED)


  inst.OnSave = onsave
  inst.OnLoad = onload

  return inst
end

return Prefab( "common/inventory/odango", fn, assets)
