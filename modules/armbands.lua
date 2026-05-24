-- == Script to manage armbands == --
local baseModel = models.model.root

local armbands = {
  RightEnby = baseModel.RightArm.RightArmBandEnby,
  RightTrans = baseModel.RightArm.RightArmBandTrans,
  LeftEnby = baseModel.LeftArm.LeftArmBandEnby,
  LeftTrans = baseModel.LeftArm.LeftArmBandTrans
}

---Toggles the specified armband
---@param arm string
---@param band string
function pings.toggleArmBand(arm, band)
  if arm:lower() == ("right"):lower() then
    if band:lower() == ("enby"):lower() then
      armbands.RightEnby:setVisible(true)
      armbands.RightTrans:setVisible(false)
    elseif band:lower() == ("trans"):lower() then
      armbands.RightTrans:setVisible(true)
      armbands.RightEnby:setVisible(false)
    else
      return
    end
  elseif arm:lower() == ("left"):lower() then
    if band:lower() == ("enby"):lower() then
      armbands.LeftEnby:setVisible(true)
      armbands.LeftTrans:setVisible(false)
    elseif band:lower() == ("trans"):lower() then
      armbands.LeftTrans:setVisible(true)
      armbands.LeftEnby:setVisible(false)
    else
      return
    end
  else
    return
  end
end

armbands.RightEnby:setPrimaryTexture("CUSTOM", textures["enby_arm_band"])
armbands.LeftEnby:setPrimaryTexture("CUSTOM", textures["enby_arm_band"])
armbands.RightTrans:setPrimaryTexture("CUSTOM", textures["trans_arm_band"])
armbands.LeftTrans:setPrimaryTexture("CUSTOM", textures["trans_arm_band"])