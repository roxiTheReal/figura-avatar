function pings.toggleArmBand(arm, flag)
    models.model.root.LeftArm.LeftArmBandTrans:setPrimaryTexture("CUSTOM", textures["trans_arm_band"])
    models.model.root.LeftArm.LeftArmBandEnby:setPrimaryTexture("CUSTOM", textures["enby_arm_band"])
    models.model.root.RightArm.RightArmBandTrans:setPrimaryTexture("CUSTOM", textures["trans_arm_band"])
    models.model.root.RightArm.RightArmBandEnby:setPrimaryTexture("CUSTOM", textures["enby_arm_band"])
    if arm == "left" then
        if flag == "trans" then
            models.model.root.LeftArm.LeftArmBandTrans:setVisible(true)
            models.model.root.LeftArm.LeftArmBandEnby:setVisible(false)
        elseif flag == "enby" then
            models.model.root.LeftArm.LeftArmBandTrans:setVisible(false)
            models.model.root.LeftArm.LeftArmBandEnby:setVisible(true)
        end
    elseif arm == "right" then
        if flag == "trans" then
            models.model.root.RightArm.RightArmBandTrans:setVisible(true)
            models.model.root.RightArm.RightArmBandEnby:setVisible(false)
        elseif flag == "enby" then
            models.model.root.RightArm.RightArmBandTrans:setVisible(false)
            models.model.root.RightArm.RightArmBandEnby:setVisible(true)
        end
    end
end