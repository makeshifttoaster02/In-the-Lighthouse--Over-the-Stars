DialogueTree = Object:extend()

function DialogueTree:new(dialogueList)
    self.dialogueList = dialogueList
    self.dialogueIndex = 0
end

function DialogueTree:trigger()
    self.dialogueIndex = self.dialogueIndex + 1
    DialogueBox:reset()
    if self.dialogueIndex > #self.dialogueList then
        self.dialogueIndex = 0
        DialogueBox:setDialogueTree(nil)
        DialogueBox:setDialogue("")
        DialogueBox:hide()
    else
        DialogueBox:setDialogueTree(self)
        local currSpeaker, currDialogue = table.unpack(self.dialogueList[self.dialogueIndex])
        DialogueBox:setDialogue(currDialogue)
        DialogueBox:show()
    end
end

function DialogueTree:initialize()
    self.dialogueIndex = 0
    self:trigger()
end