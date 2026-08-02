function pings.toggleArmBand(arm, flag)
    models.model.root.Torso.LeftArm.LeftArmBandTrans:setPrimaryTexture("CUSTOM", textures["trans_arm_band"])
    models.model.root.Torso.LeftArm.LeftArmBandEnby:setPrimaryTexture("CUSTOM", textures["enby_arm_band"])
    models.model.root.Torso.RightArm.RightArmBandTrans:setPrimaryTexture("CUSTOM", textures["trans_arm_band"])
    models.model.root.Torso.RightArm.RightArmBandEnby:setPrimaryTexture("CUSTOM", textures["enby_arm_band"])
    if arm == "left" then
        if flag == "trans" then
            models.model.root.Torso.LeftArm.LeftArmBandTrans:setVisible(true)
            models.model.root.Torso.LeftArm.LeftArmBandEnby:setVisible(false)
        elseif flag == "enby" then
            models.model.root.Torso.LeftArm.LeftArmBandTrans:setVisible(false)
            models.model.root.Torso.LeftArm.LeftArmBandEnby:setVisible(true)
        end
    elseif arm == "right" then
        if flag == "trans" then
            models.model.root.Torso.RightArm.RightArmBandTrans:setVisible(true)
            models.model.root.Torso.RightArm.RightArmBandEnby:setVisible(false)
        elseif flag == "enby" then
            models.model.root.Torso.RightArm.RightArmBandTrans:setVisible(false)
            models.model.root.Torso.RightArm.RightArmBandEnby:setVisible(true)
        end
    end
end