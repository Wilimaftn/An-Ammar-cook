folder = "call/"

SpriteUtil = nil

function onCreate()
    luaDebugMode = true
    package.path = getProperty("modulePath") .. ";" .. package.path
   SpriteUtil = require("SpriteUtil")
end
function onCreatePost()
    SpriteUtil.makeSprite({tag="blackBG",image=folder.."Talk Box", graphicColor = "000000", graphicWidth = 1500, graphicHeight = 412})
    setProperty("blackBG.alpha", 0)
    screenCenter("blackBG")
    runHaxeCode("game.getLuaObject('blackBG').camera = camDiscord;")

    SpriteUtil.makeSprite({tag="modBox",image=folder.."Moderator Box", xSize = 0.935})
    screenCenter("modBox")
    setProperty("modBox.x", getProperty("modBox.x") - 262 )
    setProperty("modBox.alpha", 0)
    runHaxeCode("game.getLuaObject('modBox').camera = camDiscord;")

    SpriteUtil.makeSprite({tag="annBox",image=folder.."Annoyer Box", xSize = 0.935})
    screenCenter("annBox")
    setProperty("annBox.x", getProperty("annBox.x") + 262 )
    setProperty("annBox.alpha", 0)
    runHaxeCode("game.getLuaObject('annBox').camera = camDiscord;")

    SpriteUtil.makeSprite({tag="modTalky",image=folder.."Talk Box", xSize = 0.935})
    setProperty("modTalky.alpha", 0)
    runHaxeCode("game.getLuaObject('modTalky').camera = camDiscord;")

    SpriteUtil.makeSprite({tag="annTalky",image=folder.."Talk Box", xSize = 0.935})
    setProperty("annTalky.alpha", 0)
    runHaxeCode("game.getLuaObject('annTalky').camera = camDiscord;")

    SpriteUtil.makeSprite({tag="modCall",image=folder.."Moderator Calling", xSize = 0.935})
    screenCenter("modCall")
    setProperty("modCall.alpha", 0)
    runHaxeCode("game.getLuaObject('modCall').camera = game.camHUD;")

    SpriteUtil.makeSprite({tag="buttons",image=folder.."callButtons", xSize = 1})
    screenCenter("buttons")
    setProperty('buttons.y', 520)
    setProperty("buttons.alpha", 0)
    runHaxeCode("game.getLuaObject('buttons').camera = camDiscord;")

    runHaxeCode("game.dadGroup.camera = camDiscord;")
    runHaxeCode("game.boyfriendGroup.camera = camDiscord;")


    setProperty("dad.x", 300); setProperty("dad.y", 268)
    setProperty("boyfriend.x", 750); setProperty("boyfriend.y", 242)

    setObjectOrder("dadGroup", getObjectOrder("modTalky")-1)
    setObjectOrder("boyfriendGroup", getObjectOrder("annTalky")-1)

    setProperty('dad.alpha', 0)
    setProperty('boyfriend.alpha', 0)

    setProperty('modTalky.visible', false)
    setProperty('annTalky.visible', false)

    --voiceMode()
end

voiceModer = false
function voiceMode()
    voiceModer = true
    setProperty("modBox.alpha", 1)
    setProperty("annBox.alpha", 1)

    setProperty("blackBG.alpha", 0.5)

    setProperty("channels.alpha", 0)
    setProperty("members.alpha", 0)
    setProperty("topBar.alpha", 0)

    setProperty("player.alpha", 0)
    setProperty("playerText.visible", false)
    setProperty("opponent.alpha", 0)
    setProperty("opponentText.visible", false)

    setProperty("buttons.alpha", 1)

    setProperty('dad.alpha', 1)
    setProperty('boyfriend.alpha', 1)

    setProperty('modTalky.visible', true)
    setProperty('annTalky.visible', true)
end


function onEvent(eventName, value1, value2)
    if eventName == "Change Character" then
        setProperty("dad.x", 300); setProperty("dad.y", 268)
        setProperty("boyfriend.x", 750); setProperty("boyfriend.y", 242)
    end
end

function onBeatHit()
    if curBeat == 316 then
        setProperty("modCall.alpha", 1)
    end
    if curBeat == 320 then
        setProperty("modCall.alpha", 0)
        voiceMode()
    end

    if getProperty("dad.animation.curAnim.name") == "idle" then 
        playAnim("dad", "idle", true)
     end
end
function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if voiceModer then
        setProperty("annTalky.alpha", 1)
        setProperty("annTalky.x", getProperty("annBox.x"))
        setProperty("annTalky.y", getProperty("annBox.y"))
        runTimer("annTalkyEnd", 0.5)
    end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if voiceModer then
        setProperty("modTalky.alpha", 1)
        setProperty("modTalky.x", getProperty("modBox.x"))
        setProperty("modTalky.y", getProperty("modBox.y"))
        runTimer("modTalkyEnd", 0.5)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "annTalkyEnd" then
        setProperty("annTalky.alpha", 0)
    end
    if tag == "modTalkyEnd" then
        setProperty("modTalky.alpha", 0)
    end
end