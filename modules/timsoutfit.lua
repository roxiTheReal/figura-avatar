local absRoot = models.model.root
local rootUpper = absRoot.Torso

local parts = {
    rootUpper.Body.Shirt, rootUpper.Body.physBoob.boobShirt,

    rootUpper.LeftArm.LeftShirtSleeve, rootUpper.LeftArm.LeftShirtSleeveLayer2,
    rootUpper.RightArm.RightShirtSleeve, rootUpper.RightArm.RightShirtSleeveLayer2,

    absRoot.LeftLeg.LeftTimPants, absRoot.LeftLeg.LeftTimPantsLayer2,
    absRoot.RightLeg.RightTimPants, absRoot.RightLeg.RightTimPantsLayer2,
}

function pings.toggleTimShirtOn()
    for i = 1, #parts do
        parts[i]:setPrimaryTexture("CUSTOM", textures["model.Tims_Outfit"]):setVisible(true)
    end
end

function pings.toggleTimShirtOff()
    for i = 1, #parts do
        parts[i]:setPrimaryTexture("CUSTOM", textures["model.Tims_Outfit"]):setVisible(false)
    end
end