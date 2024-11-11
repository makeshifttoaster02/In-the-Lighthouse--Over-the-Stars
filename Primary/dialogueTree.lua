DialogueTree = Object:extend()

function DialogueTree:new(dialogueList)
    self.dialogueList = dialogueList
    self.dialogueIndex = 0
end

function DialogueTree:trigger()
    self.dialogueIndex = self.dialogueIndex + 1
    DialogueBox:reset()
    local currDialogueChain = self.dialogueList[DayManager:getDay()]
    if self.dialogueIndex > #currDialogueChain then
        self.dialogueIndex = 0
        DialogueBox:setDialogueTree(nil)
        DialogueBox:setDialogue("")
        DialogueBox:hide()
        DialogueBox:setNotHovering()

        local _, lastDialogue = table.unpack(currDialogueChain[#currDialogueChain])
        if lastDialogue == "Go to sleep?" then
            DayManager:nextDay()
        end

        if lastDialogue == "Tomorrow is a better day." then
            DayManager:nextDay()
        end

        if lastDialogue == "If you do this, your journey will truly be over. Are you sure?" then
            End:trigger()
        end
    else
        DialogueBox:setDialogueTree(self)
        local currSpeaker, currDialogue = table.unpack(currDialogueChain[self.dialogueIndex])
        DialogueBox:setDialogue(currDialogue)
        DialogueBox:show()
    end
end

function DialogueTree:initialize()
    self.dialogueIndex = 0
    self:trigger()
end

function DialogueTree:escape()
    DialogueBox:reset()
    self.dialogueIndex = 0
    DialogueBox:setDialogueTree(nil)
    DialogueBox:setDialogue("")
    DialogueBox:hide()
    DialogueBox:setNotHovering()
end

function DialogueTree:back()
    self.dialogueIndex = self.dialogueIndex - 2
    if self.dialogueIndex < 0 then
        self:escape()
    else
        self:trigger()
    end
end

function DialogueTree:setDialogueList(dialogueList)
    self.dialogueList = dialogueList
end

function DialogueTree:getDialogueList()
    return self.dialogueList
end