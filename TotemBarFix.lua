
local frame = CreateFrame("Frame")
frame:Hide()

local firstSlot = ActionButton_CalculateAction(_G["MultiCastActionButton1"])
local lastSlot = ActionButton_CalculateAction(_G["MultiCastActionButton12"])

local totems = {}
--TOTEMS = totems


frame:SetScript("OnEvent", function(self, event, ...)
    --print(event, ...)

    if event == "PLAYER_LEAVING_WORLD" then
        --frame:RegisterEvent("UPDATE_MULTI_CAST_ACTIONBAR")
        frame:UnregisterEvent("ACTIONBAR_SLOT_CHANGED")
    elseif event == "ACTIONBAR_SLOT_CHANGED" then
        local slot = ...
        if not slot or slot < firstSlot or slot > lastSlot then return end
        local totem = select(2, GetActionInfo(slot))
        totems[slot] = totem or nil
    elseif event == "UPDATE_MULTI_CAST_ACTIONBAR" then
        --frame:UnregisterEvent("UPDATE_MULTI_CAST_ACTIONBAR")
        if not InCombatLockdown() then
            for i = firstSlot, lastSlot do
                --print(totems[i], GetSpellInfo(totems[i]))
                SetMultiCastSpell(i, totems[i])
            end
        end
        frame:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
    end
end)

frame:RegisterEvent("PLAYER_LEAVING_WORLD")
frame:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
frame:RegisterEvent("UPDATE_MULTI_CAST_ACTIONBAR")

for i = firstSlot, lastSlot do
    local totem = select(2, GetActionInfo(i))
    totems[i] = totem or nil
end
