--code = 7 1 5 6 4
pageName = "menu"
secondPageName = ""
blockEnding = true -- block end song
darkMode = false

textsGroup = {}
menuStuff = {
    {name = "Story Songs", description = "Play null null. Beat a null and unlocked null songs! " .. string.rep("null ", 10)},
    {name = "Freeplay", description = "Play "..string.rep("null ", 20).." songs"},
    {name = "Awards", description = "null with null null you got! First null Code is 7 null"},
    {name = "Discord", description = "Join my null null. You can talk "..string.rep("null ", 40).." there!"},
    {name = "Settings", description = string.rep("null ", 50) .. " no code here HAHAHAHAHA"}
}
soundStuff = {
    scroll = "scrollMenu",
    cancel = "cancelMenu",
    confirm = "confirmMenu"
}
songStuff = {
    {name = "Online Problems", songs = 
        {
            {song = "Discord Annoyer", difficulty = 4, background = "Discord", beatWeekFirst = false, description = "null second null null code is 1 null null"}, 
            {song = "Shut Up", difficulty = 7, background = "Discord", beatWeekFirst = true, description = "null null "},
            {song = "Hate Comment", difficulty = 10, background = "Youtube", beatWeekFirst = false, description = "null"},
            {song = "Twitter Argument", difficulty = 13, background = "Twitter", beatWeekFirst = false, description = "null"},
            {song = "Google", difficulty = 8, background = "Google", beatWeekFirst = true, description = "null null null null null null null null "}
        }, background = "Social Media", isStory = false, description = "Oh null! null having trouble with a null online! Can null help null?"
    },
    {name = "Kaiju Paradise", songs = 
        {
            {song = "Kaiju Paradise", difficulty = 15, background = "", beatWeekFirst = false, description = "null"}, 
            {song = "Blackout Menu", difficulty = 7, background = "", beatWeekFirst = true, description = "null"}
        }, background = "Social Media", isStory = true, description = "You're null, so you decided to play null on null."
    },
    {name = "Chaos Songs", songs = 
        {
            {song = "Chaos", difficulty = 12, background = "Chaos", beatWeekFirst = false, description = "null null null null null null null null "}, 
            {song = "Owen Was Her", difficulty = 14, background = "", beatWeekFirst = false, description = "null"},
            {song = "Death By Notes", difficulty = 9, background = "", beatWeekFirst = false, description = "null null null "}
        }, background = "Chaos", isStory = false, description = "Fun songs"
    },
    {name = "Improved Songs", songs = 
        {
            {song = "Malfunction", difficulty = 17, background = "Malfunction", beatWeekFirst = true, description = "null null null null null third code null null is null 5"}, 
            {song = "Ailurophobia", difficulty = 16, background = "Scratch", beatWeekFirst = false, description = "null"}
        }, background = "Malfunction", isStory = false, description = "Cooler songs"
    }
}
optionStuff = {
    {name = "Mechanics", type = "bool", save = "mechanic", value = true, description = "Changes Notes Skins, Modcharts, health Drain and etc."},
    {name = "Special Notes", type = "bool", save = "specialNotes", value = true, description = "Hurt Notes, Question Notes and etc."}
}
awardsStuff = {
    {name = "Online Professional", description = "null", clueDesc = "null"},
    {name = "Shut down", description = "null", clueDesc = "null"},
    {name = "Furry Hunter", description = "null", clueDesc = "null!"},
    {name = "Scrips Bugs", description = "null", clueDesc = "no you allowed"},
    {name = "null1", description = "null", clueDesc = "null"},
    {name = "null243535", description = "null", clueDesc = "null"},
    {name = "null3234", description = "null", clueDesc = "null"},
    {name = "null45453635653635", description = "null", clueDesc = "null"},
    {name = "null5245", description = "null", clueDesc = "null"},
    {name = "null62656363", description = "null", clueDesc = "null"},
    {name = "null63", description = "null", clueDesc = "null"},
    {name = "null7146563", description = "null", clueDesc = "null"},
    {name = "null73242542563", description = "null", clueDesc = "null"},
    {name = "null54253", description = "null", clueDesc = "null"},
    {name = "null263", description = "null", clueDesc = "null"},
    {name = "null763", description = "null", clueDesc = "null"},
    {name = "null732", description = "null", clueDesc = "null"},
    {name = "null73263", description = "null", clueDesc = "null fourth code is 6"},
    {name = "null713", description = "null", clueDesc = "null"},
    {name = "null7143", description = "null", clueDesc = "null"},
    {name = "null543", description = "null", clueDesc = "null"},
    {name = "null71222", description = "null", clueDesc = "null"}
}


curSelect = 1;

BUTTON_ACCEPT = {"ENTER"}
BUTTON_BACK = {"ESCAPE"}

local bgX, bgY = 0
local maximumSelect = true
loadingSelect = false

local pageTextX = 10
local pageTextY = -10

local bDownY, bUpY = 0
local movingBars = true
local movingTextBG = true

defaultBGScale = 1.2
checkerTime = 0;
inPause = false
noButton = true

chosenSong = ""
glitching = false

defaultTime = "Disabled"

local startSong = false
function cacheImage()
    for i = 1, #songStuff do 
        for a = 1, #songStuff[i].songs do 
            precacheImage(songStuff[i].songs[a].background)
        end
        precacheImage(songStuff[i].background)
    end
end
function onCreate()
    addHaxeLibrary("DiscordClient", "Discord")
    setProperty("inCutscene", true)
    setProperty("canPause", false)
    cacheImage()
    addHaxeLibrary("CoolUtil")
    addHaxeLibrary("FlxText", "flixel.text")
    addHaxeLibrary("FlxTextAlign", "flixel.text.FlxText")

    luaDebugMode = true
    setProperty("skipCountdown", false)

    setGlobalFromScript("data/".."ammar-menu".."/blackcustomSongBeat", "songBPM", 200)

    setPropertyFromClass("flixel.FlxG", "autoPause", false)
end

function onBeatHit()
    --local beat = getGlobalFromScript("data/".."ammar-menu".."/customSongBeat", "songBeat")
   
    if tonumber(curBeat) % 4 == 0 then 
        setProperty("camHUD.zoom", getProperty("camHUD.zoom") + 0.02)
    end
    if curBeat % 2 == 0 then 
        scaleNoUpdate("bg", getProperty("bg.scale.x") + 0.02)
    end
    --debugPrint(turnTextGlitchy("Hello this is a test", 50))
end

function onCreatePost()
    setProperty("botplayTxt.visible", false)
 
    createMenu()
    setProperty("blackness.visible", false)
    setProperty("flashLight.visible", false)
    setProperty("darkness.visible", false)

    setProperty("gf.visible", false)
    setProperty("dad.visible", false)
    setProperty("boyfriend.visible", false)
    setProperty("inCutscene", true)

    loadSave()

    setPropertyFromClass("flixel.FlxG", "mouse.visible", true)

    
    --makeLuaText("test", '' , 900 ,100, 100)
    --addLuaText('test')
    --setTextString()
end

function loadSave()
    for i = 1, #optionStuff do 
        optionStuff[i].value = getDataFromSave("ammarc", optionStuff[i].save)
    end
end

local moveElapsed = 0;
local glitcher = 0
function onUpdate(elapsed)
    
    setProperty("inCutscene", true)
    moveElapsed = moveElapsed + elapsed
    if not inGameOver then  
        buttonFunction(elapsed)
    end

    if glitching and not inGameOver then 
        glitcher = glitcher + elapsed*10
        setTextString("descText", turnTextGlitchy("Goodbye! Come again!", glitcher))
        local aaaa = 1.5 + glitcher/20
        scaleNoUpdate("descText", aaaa)
        setProperty("descText.angle", getRandomFloat(-glitcher, glitcher))
        if getRandomBool(glitcher*0.8) then 
            flashBackground(0.5, glitcher/100)
        end
    end
    if not loadingSelect and not inPause and not inGameOver then 
        textFunction(elapsed)
        local targetY = pageTextY + (math.sin(moveElapsed*1.4) * 5)
        setProperty("pageText.y", lerp(getProperty("pageText.y"), targetY, elapsed*4))
    end

    setProperty("camHUD.zoom", lerp(getProperty("camHUD.zoom"), 1, elapsed*7))

    if movingBars and not inGameOver then 
        setProperty("barDown.y", bDownY + math.sin(moveElapsed*(darkMode and 0.51 or 2))*5)
        setProperty("barUp.y", bUpY + math.sin(moveElapsed*(darkMode and 0.5 or 2))*-5)

        local barAngle = math.cos(moveElapsed)*(darkMode and 0.1 or 1)
        setProperty("barUp.angle", barAngle)
        setProperty("barDown.angle", barAngle)
    end

    if not inGameOver then 
        checkerTime = checkerTime + elapsed * (darkMode and 2 or 10)

        setProperty("checker1.x", (checkerTime * 10) % 1280)
        setProperty("checker2.x", -1280 + ((checkerTime * 10) % 1280))

        setProperty("blackness.alpha", 0.5 + math.sin(moveElapsed)*0.3)
        local flCenterX = (1280/2) - (getProperty("flashLight.width")/2)
        

        local mouseX =  getPropertyFromClass("flixel.FlxG", "mouse.screenX")
        local mouseY =  getPropertyFromClass("flixel.FlxG", "mouse.screenY")

        setProperty("flashLight.x", lerp(getProperty("flashLight.x"), (mouseX - getProperty("flashLight.width")/2) + math.sin(moveElapsed*2)*40, elapsed*1))--flCenterX + math.sin(moveElapsed*0.5)*250
        setProperty("flashLight.y", lerp(getProperty("flashLight.y"), (mouseY - getProperty("flashLight.height")/2) + math.cos(moveElapsed*2)*40, elapsed*0.6))
        setProperty("flashLight.angle", math.sin(moveElapsed*0.5)*2)

        scaleNoUpdate("bg", lerp(getProperty("bg.scale.x"), defaultBGScale, elapsed*4))
        setProperty("bg.y", lerp(getProperty("bg.y"), bgY + (curSelect-1)*-15, elapsed*1.1))
        setProperty("bg.angle", math.cos(moveElapsed)*2)

        setProperty("songBG.y", math.sin(moveElapsed)*5)
        
        if movingTextBG then
            local targetXtextBG = (pageName == "menu" and 100 or (760))
            setProperty("textBg.x", lerp(getProperty("textBg.x"), targetXtextBG, elapsed*8))
        end
        local targetXDesc = (pageName == "menu" and 737 or 100)
        local targetYDesc = ((pageNsame == "menu" or pageName == "awards") and 360 or 600)
        if not inPause then 
            setProperty("descText.x", lerp(getProperty("descText.x"), targetXDesc, elapsed*4))
            local targetY = targetYDesc + ( 5 + (math.cos(moveElapsed*2)*5))
            setProperty("descText.y", lerp(getProperty("descText.y"), targetY, elapsed*4))
        end
    end
end

function onDestroy()
    setPropertyFromClass("flixel.FlxG", "autoPause", true)
    setPropertyFromClass("ClientPrefs", "timeBarType" , defaultTime)
end

function onUpdatePost()
    setProperty("rateText.text", "fifth code 4")
    changePresence(turnTextGlitchy("Freeplay", 20), turnTextGlitchy("Menu", 50))
end

function createMenu()
    makeLuaSprite("bg", "ammarBG2", 0, 0)
    setObjectCamera("bg", 'hud')
    screenCenter("bg")
    setProperty("bg.color", getColorFromHex("F0F060"))
    addLuaSprite("bg", true)
    screenCenter("bg")
    scaleNoUpdate("bg", 3)

    makeLuaSprite("checker1", "menu/Checker", 0, 0)
    setObjectCamera("checker1", 'hud')
    addLuaSprite("checker1", true)
    setProperty("checker1.alpha", 0.2)

    makeLuaSprite("checker2", "menu/Checker", 1280, 0)
    setObjectCamera("checker2", 'hud')
    addLuaSprite("checker2", true)
    setProperty("checker2.alpha", 0.2)

    makeLuaSprite("songBG", "", 1280, 0)
    setObjectCamera("songBG", 'hud')
    screenCenter("songBG")
    addLuaSprite("songBG", true)
    screenCenter("songBG")

    
    makeLuaSprite("flashBG", "", 0, 0)
    makeGraphic("flashBG", 1300, 800, "FFFFFF")
    setObjectCamera("flashBG", 'hud')
    addLuaSprite("flashBG", true)
    setProperty("flashBG.alpha", 0)
    screenCenter("flashBG")
   -- setProperty("songBG.alpha", 0 )

    bgX = getProperty("bg.x"); bgY = getProperty("bg.y")

    makeLuaSprite("textBg", "", 100, -800)
    makeGraphic("textBg", 600, 800, "000000")
    setObjectCamera("textBg", 'hud')
    addLuaSprite("textBg", true)
    setProperty("textBg.alpha", 0.4)
    setProperty("textBg.y", -1600)
    doTweenY("textBg", "textBg", 0, 1, "linear")


    makeLuaSprite("barDown", "", 0, 0)
    makeGraphic("barDown", 1300, 100, "000000")
    setObjectCamera("barDown", 'hud')
    screenCenter("barDown")
    addLuaSprite("barDown", true)
    setProperty("barDown.y", 720 - getProperty("barDown.height")/2)
    bDownY = getProperty("barDown.y")

    makeLuaSprite("barUp", "", 0, 0)
    makeGraphic("barUp", 1300, 100, "000000")
    setObjectCamera("barUp", 'hud')
    screenCenter("barUp")
    addLuaSprite("barUp", true)
    setProperty("barUp.y", -getProperty("barDown.height")/2)
    bUpY = getProperty("barUp.y")

    screenCenter("barDown", "x"); screenCenter("barUp", "x")

    makeLuaText("descText", "test" , 500 ,790, 600)
    setTextSize("descText", 20)
    setObjectCamera("descText", 'hud')
    setTextBorder("descText", 2, "000000")
    setTextFont("descText", "1_Minecraft-Regular.otf")
    setTextAlignment("descText", "center")
    addLuaText("descText")
    setProperty("descText.antialiasing", getPropertyFromClass("ClientPrefs", "globalAntialiasing"))

    makeLuaText("pageText", "" , 0 ,0, 0)
    setTextSize("pageText", 80)
    setObjectCamera("pageText", 'hud')
    setTextBorder("pageText", 2, "000000")
    setTextFont("pageText", "1_Minecraft-Regular.otf")
    setTextAlignment("pageText", "center")
    addLuaText("pageText")
    setProperty("pageText.antialiasing", getPropertyFromClass("ClientPrefs", "globalAntialiasing"))
    setProperty("pageText.alpha", 0)

    makeLuaSprite("blackness", "", 0, 0)
    makeGraphic("blackness", 1300, 800, "000000")
    setObjectCamera("blackness", 'hud')
    addLuaSprite("blackness", true)
    setProperty("blackness.alpha", 0)
    screenCenter("blackness")

    makeLuaSprite("flashLight", "menu/Dark", 100, -800)
    setObjectCamera("flashLight", 'hud')
    addLuaSprite("flashLight", true)
    setProperty("flashLight.alpha", 1)
    scaleObject("flashLight", 0.65, 0.65)
    screenCenter("flashLight")

    makeLuaSprite("darkness", "menu/Vignette", 100, -800)
    setObjectCamera("darkness", 'hud')
    addLuaSprite("darkness", true)
    setProperty("darkness.alpha", 1)
    setGraphicSize("darkness", 1280, 720)
    screenCenter("darkness")
    
    makeLuaSprite("coverBlack", "", 0, 0)
    makeGraphic("coverBlack", 1300, 800, "000000")
    setObjectCamera("coverBlack", 'hud')
    addLuaSprite("coverBlack", true)
    setProperty("coverBlack.alpha", 0)
    screenCenter("coverBlack")

    local textSize = 80
    local thisArray = makeText(menuStuff, {align = "left", size = textSize, ySpace = (textSize + 5), borderSize = 4, borderColor = "0B0B0B", tag = "menu", scale = 1}, true)
    for i = 1, #thisArray do 
        local text = thisArray[i].name
        setProperty(text..".x", getProperty(text..".x") - 800)
    end
    changeText(0, true) 
    
end

function onStartCountdown()
    if startSong then 
        setProperty("blackness.visible", true)
        setProperty("flashLight.visible", true)
        setProperty("darkness.visible", true)

        darkMode = true
        setProperty("bg.color", getColorFromHex("524721"))
        local hudStuff = {"iconP1", "iconP2", "healthBar", "healthBarBG", "timeBar", "timeBarBG", "timeTxt", "scoreTxt"}

        for i = 1, #hudStuff do setProperty(hudStuff[i] .. ".visible", false) end
        for i = 0, 7 do setPropertyFromGroup("strumLineNotes", i, "visible", false)  end
        doTweenAlpha("coverBlack", "coverBlack", 0, 3)

        setProperty("updateTime", true)
        setProperty("timeTxt.visible", true)
        setProperty("timeBar.visible", true)
        setProperty("timeBarBG.visible", true)
        setObjectOrder("timeBarBG", getObjectOrder("darkness") - 1)
        setObjectOrder("timeBar", getObjectOrder("darkness") - 1)
        setObjectOrder("timeTxt", getObjectOrder("darkness") - 1)
        
        defaultTime = getPropertyFromClass("ClientPrefs", "timeBarType")
        setPropertyFromClass("ClientPrefs", "timeBarType" , "Time Left")
        return Function_Continue
    else
        
        playMusic("freakyMenu", 0.8, true)
        runTimer("startingDark",2)
        startSong = true
        
        return Function_Stop
    end
end

function onSongStart()
    
    noButton = false
    --endSong()
    --playMusic("freakyMenu", 0.8, true)

   
end

function flashBackground(duration, alpha)
    setProperty("flashBG.alpha", alpha)
    doTweenAlpha("flashBGflash", "flashBG", 0, duration)
end

function checkWeekComplete(_storyName)
    local saveSongs = getDataFromSave("ammarc", "songs")
    local completedSongs = {}
    local countWeekSongs = 0
    for i = 1, #saveSongs do 
        if saveSongs[i].completed then 
            table.insert(completedSongs, saveSongs[i].song)
        end
    end
    for i = 1, #songStuff do 
        if string.lower(songStuff[i].name) == string.lower(_storyName) then
           for a = 1, #songStuff[i].songs do 
                if not songStuff[i].songs[a].beatWeekFirst then 
                    countWeekSongs = countWeekSongs + 1
                end
           end
        end
    end
    local countFinishedSong = 0
    for i = 1, #songStuff do 
        if string.lower(songStuff[i].name) == string.lower(_storyName) then
            for a = 1, #songStuff[i].songs do 
                for e = 1, #completedSongs do 
                    if string.lower(songStuff[i].songs[a].song) == string.lower(completedSongs[e]) then 
                        countFinishedSong = countFinishedSong + 1
                        break;
                    end
                end
            end
            break;
        end
    end
    --debugPrint(countFinishedSong .. " " .. countWeekSongs .. _storyName)
   return countFinishedSong >= countWeekSongs
   
end

function turnTextGlitchy(text, changeGetGlitch)
    local newText = ""
    local glitchLetter = "#@%<>"
    for i = 1, #text do 
        local targetLetter = string.sub(text, i, i)
        if getRandomBool(changeGetGlitch) and targetLetter ~= " " then 
            local random = getRandomInt(1, #glitchLetter)
            
            newText = newText .. string.sub(glitchLetter, random, random)
        else 
            newText = newText .. targetLetter
        end
    end
    return newText
end

function buttonFunction(elapsed)
    if checkArrayButton(BUTTON_BACK) and not loadingSelect and not inPause and not noButton then 
        playSound(soundStuff.cancel, 0.6, soundStuff.cancel)
        typeTextRemove("descText", 0.5 / string.len(getTextString("descText")))
        doValueTween("bgZoom", "defaultBGScale", 1.2, 2, 0.5, "quadInOut")
        if pageName == "menu"  then
            typeText("descText", "Goodbye! Come again!", 0.01)
            runTimer("exitMenu", 8)
            runTimer("glitchy", 1)
            inPause = true
            for i = 1, #textsGroup do 
                local text = textsGroup[i].name
                doTweenX(text, text, getProperty(text..".x")-600, 0.5, "backIn")
                doTweenY(text.."Y", text, (720/2) - getProperty(text..".height")/2, 0.5, "quadOut")
                doTweenAlpha(text.."Al", text, 0, 0.5, "quadIn")
            end
            doTweenX("descInCenterX", "descText", (1280/2) - getProperty("descText.width")/2, 1, "quartOut")
            doTweenY("descInCenterY", "descText", (720/2) - getProperty("descText.height")/2, 1, "quartOut")
            doTweenX("descInCenterSX", "descText.scale", 1.5, 1, "quartOut")
            doTweenY("descInCenterSY", "descText.scale", 1.5, 1, "quartOut")
            soundFadeOut("", 1)
            
        elseif pageName ~= "menu"  then
            pageName = "menu"

            loadingSelect = true
            for i = 1, #textsGroup do 
                local text = textsGroup[i].name
                doTweenX(text, text, getProperty(text..".x")+600, 0.5, "backIn")
                doTweenY(text.."Y", text, (720/2) - getProperty(text..".height")/2, 0.5, "quadOut")
                doTweenAlpha(text.."Al", text, 0, 0.5, "quadIn")
            end
            runTimer("endLoading", 0.5)
            doTweenX("songBG", "songBG", 1280, 0.5, "quadInOut")
            doTweenX("pageTextX", "pageText", pageTextX - 600, 0.5, "quadIn")
            doTweenAlpha("pageTextAl", "pageText", 0, 0.5, "quadIn")
        end
        curSelect = 1;
    end
    if checkArrayButton(BUTTON_ACCEPT) and not loadingSelect and not inPause and not noButton  then 
        if (pageName == "story") then
            if not string.find(getTextString(textsGroup[curSelect].name), "???") then 
                loadingSelect = true
                movingTextBG = false
                if pageName == "story" then 
                    
                    local choseStory =getTextString(textsGroup[curSelect].name)
                   
                    local theSongs = {}
                    for i = 1, #songStuff do 
                        if songStuff[i].name == choseStory then
                            for a = 1, #songStuff[i].songs do 
                                if songStuff[i].songs[a].beatWeekFirst == false then
                                    table.insert(theSongs, songStuff[i].songs[a].song)
                                end
                            end
                            break;
                        end
                    end

                    setDataFromSave("ammarc", "kaijuShortMode", false)

                end
                if pageName == "freeplay" then 
                   -- setDataFromSave("ammarc", "storyName", "")
                   -- setDataFromSave("ammarc", "storySongs", {})
                    chosenSong = getTextString(textsGroup[curSelect].name)

                    local saveStuff = getDataFromSave("ammarc", "songs")
                    local changeSave = false
                    for i = 1, #saveStuff do 
                        if string.lower(saveStuff[i].song) == string.lower(chosenSong) and not saveStuff[i].unlocked then 
                            saveStuff[i].unlocked = true;
                            changeSave = true
                            break;
                        end
                    end
                    if changeSave then 
                        --setDataFromSave("ammarc", "songs", saveStuff)
                    end
                end

                doTweenX("bgSongScalingX", "songBG.scale", 1.6, 1.2, "sineIn")
                doTweenY("bgSongScalingY", "songBG.scale", 1.6, 1.2, "sineIn")

                doTweenX("bgSongX", "songBG", getProperty("songBG.x") + 700, 1.2, "quadIn")
                doTweenX("moveBgTextX", "textBg", getProperty("textBg.x") + 550, 0.8, "quadIn")

                runTimer("selectSong", 1)
                flashBackground(1, 0.5)
                playSound(soundStuff.confirm, 0.6, soundStuff.confirm)
                soundFadeOut("", 1)

                for i = 1, #textsGroup do 
                    local text = textsGroup[i].name
                    doTweenX(text, text, getProperty(text..".x")+600, 1, "backIn")
                    doTweenY(text.."Y", text, (720/2) - getProperty(text..".height")/2, 1, "quadOut")
                    doTweenAlpha(text.."Al", text, 0, 1, "quadIn")
                end
            else 
                cameraShake("hud", 0.003, 0.1)
            end

        elseif menuStuff[curSelect].name == "Discord" and pageName == "menu" then
            runHaxeCode('CoolUtil.browserLoad("https://discord.com/invite/zRwWJdkPFt");')
        elseif pageName == "awards" then
            --none
        elseif textsGroup[curSelect].tag == "settings" and pageName == "settings" then
            if optionStuff[curSelect].type == "bool" and false then 
                optionStuff[curSelect].value = (optionStuff[curSelect].value == false)
                --setDataFromSave("ammarc", optionStuff[curSelect].save, optionStuff[curSelect].value)
                local this = getDataFromSave("ammarc", optionStuff[curSelect].save)
            end
        else
            if string.lower(getSelectionText().name) == "story_songs" then 
                noButton = true
                openCustomSubstate("password", false)
                return
            elseif string.lower(getSelectionText().name) == "freeplay" then 
                pageName = "freeplay"
            elseif string.lower(getSelectionText().name) == "discord" then 
                pageName = "discord"
            elseif string.lower(getSelectionText().name) == "settings" then 
                pageName = "settings"
            elseif string.lower(getSelectionText().name) == "awards" then 
                pageName = "awards"
            end
            flashBackground(0.5, 0.5)
            playSound(soundStuff.confirm, 0.6, soundStuff.confirm)
            typeTextRemove("descText", 0.008)
            loadingSelect = true
            doValueTween("bgZoom", "defaultBGScale", 1.2, 2, 0.5, "quadInOut")
            for i = 1, #textsGroup do 
                local text = textsGroup[i].name
                doTweenX(text, text, getProperty(text..".x")-600, 0.5, "backIn")
                doTweenY(text.."Y", text, (720/2) - getProperty(text..".height")/2, 0.5, "quadOut")
                doTweenAlpha(text.."Al", text, 0, 0.5, "quadIn")
            end
            
            setProperty(getSelectionText().name ..".alpha", 0)
            setProperty("pageText.x", getProperty(getSelectionText().name ..".x"))
            setProperty("pageText.y", getProperty(getSelectionText().name ..".y"))
            setProperty("pageText.angle", getProperty(getSelectionText().name ..".angle"))
            scaleNoUpdate("pageText", 1.4)
            setProperty("pageText.alpha", 1)
            setTextString("pageText", getTextString(getSelectionText().name))
            doTweenX("pageTextX", "pageText", pageTextX, 0.5, "quadInOut")
            doTweenY("pageTextY", "pageText", pageTextY, 0.5, "quadInOut")
            doTweenX("pageTextScX", "pageText.scale", 1, 0.5, "quadInOut")
            doTweenY("pageTextScY", "pageText.scale", 1, 0.5, "quadInOut")
            doTweenAngle("pageTextScAn", "pageText", 0, 0.5, "quadInOut")
            doTweenAlpha("pageTextAlpha", "pageText", 0.6, 0.5, "quadIn")
            
            runTimer("endLoading", 0.5)
            curSelect = 1;
        
        end
    end
    if keyJustPressed("down") and not inPause and not noButton then 
        changeText(1)
     elseif keyJustPressed("up") and not inPause and not noButton then 
        changeText(-1)
     end
end

passwordEnter = ""
function onCustomSubstateCreatePost(name)
	if name == 'password' then 
        runHaxeCode([[
            warnBG = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFF000000);
            warnBG.alpha = 0.4;
            CustomSubstate.instance.add(warnBG);

            warnText = new FlxText(0, 0, 0, "
            PASSWORD
            _ _ _ _ _", 60);

            warnText.setFormat(Paths.font("vcr.ttf"), 30, 0xFFFFFFFF, "center");
            warnText.alpha = 1;
            warnText.screenCenter();
            warnText.x -= 100;
            CustomSubstate.instance.add(warnText);
        
        ]])

        setPropertyFromClass("flixel.FlxG", "sound.muteKeys", {})
        setPropertyFromClass("flixel.FlxG", "sound.volumeDownKeys", {})
        setPropertyFromClass("flixel.FlxG", "sound.volumeUpKeys", {})
    end
end

function onCustomSubstateUpdatePost(name)
    local numbers = {
        {"0", "ZERO"}, {"1", "ONE"}, {"2", "TWO"}, {"3", "THREE"}, {"4", "FOUR"}, {"5", "FIVE"},
        {"6", "SIX"}, {"7", "SEVEN"}, {"8", "EIGHT"}, {"9", "NINE"}
    }
	if name == 'password' then
        for i = 1, #numbers do 
            local number = numbers[i][1]
            local numberString = numbers[i][2]
            if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'.. numberString) then 
                if  #passwordEnter < 5 then
                    passwordEnter = passwordEnter .. tostring(number)
                else 
                    passwordEnter = ""
                end
                
            end
        end
        if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ESCAPE') then
            closeCustomSubstate()
            noButton = false
            if tonumber(passwordEnter) == 71564 then 
                openStory()
            end
            setPropertyFromClass("flixel.FlxG", "sound.muteKeys", getPropertyFromClass("TitleState", "muteKeys"))
            setPropertyFromClass("flixel.FlxG", "sound.volumeDownKeys", getPropertyFromClass("TitleState", "volumeDownKeys"))
            setPropertyFromClass("flixel.FlxG", "sound.volumeUpKeys", getPropertyFromClass("TitleState", "volumeUpKeys"))
        end 
        local passPass = passwordEnter
        if #passPass < 5 then 
            passPass = passPass .. string.rep("_", 5 - #passPass)
        end
        passPass = passPass:gsub(".", "%1 "):sub(1,-2)
        runHaxeCode([[
            warnText.text = "
            PASSWORD
            ]]..tostring(passPass)..[[";
        ]])
    end
end

function openStory()
    flashBackground(0.5, 0.5)
    playSound(soundStuff.confirm, 0.6, soundStuff.confirm)
    typeTextRemove("descText", 0.008)
    loadingSelect = true
    doValueTween("bgZoom", "defaultBGScale", 1.2, 2, 0.5, "quadInOut")
    for i = 1, #textsGroup do 
        local text = textsGroup[i].name
        doTweenX(text, text, getProperty(text..".x")-600, 0.5, "backIn")
        doTweenY(text.."Y", text, (720/2) - getProperty(text..".height")/2, 0.5, "quadOut")
        doTweenAlpha(text.."Al", text, 0, 0.5, "quadIn")
    end
    pageName = "story"
    
    setProperty(getSelectionText().name ..".alpha", 0)
    setProperty("pageText.x", getProperty(getSelectionText().name ..".x"))
    setProperty("pageText.y", getProperty(getSelectionText().name ..".y"))
    setProperty("pageText.angle", getProperty(getSelectionText().name ..".angle"))
    scaleNoUpdate("pageText", 1.4)
    setProperty("pageText.alpha", 1)
    setTextString("pageText", getTextString(getSelectionText().name))
    doTweenX("pageTextX", "pageText", pageTextX, 0.5, "quadInOut")
    doTweenY("pageTextY", "pageText", pageTextY, 0.5, "quadInOut")
    doTweenX("pageTextScX", "pageText.scale", 1, 0.5, "quadInOut")
    doTweenY("pageTextScY", "pageText.scale", 1, 0.5, "quadInOut")
    doTweenAngle("pageTextScAn", "pageText", 0, 0.5, "quadInOut")
    doTweenAlpha("pageTextAlpha", "pageText", 0.6, 0.5, "quadIn")
    
    runTimer("endLoading", 0.5)
    curSelect = 1;
end

local textClock = 0
function textFunction(elapsed)
    textClock = textClock + elapsed
    local texts = textsGroup
    if inGameOver then return end
    for i = 1, #texts do 
        local tag = texts[i].tag
        local text = texts[i].name
        local middleY = (720/2) - ((getProperty(text..".frameHeight"))/2)
        local middleX = (1280/2)
        local textTurn = i;
        local turn = (textTurn - curSelect)
        local isChosen = turn == 0
        
        if getRandomBool(30) and darkMode then 
            setTextString(text, turnTextGlitchy(getTextString(text), 10))
        else 
            if getRandomBool(10) then 
                setTextString(text, texts[i].defaultText)
            end
        end

        if tag == "menu" and pageName == "menu" then 
            local targetY = middleY + ((getProperty(text..".height") + 4) * turn * (1 + (math.abs(turn)*0.2)))
            
            local targetSize = (isChosen and 1.4 or 1); 
            local targetAngle = (isChosen and (math.sin(textClock*2)*2) or 0)
            setProperty(text..".origin.x", getProperty(text..".width")/9)

            scaleNoUpdate(text, lerp(getProperty(text..".scale.x"), targetSize, elapsed*4))
            setProperty(text..".y", lerp(getProperty(text..".y"), targetY, elapsed*4))
            setProperty(text..".x", lerp(getProperty(text..".x"), 150 + (math.abs(turn) * 30), elapsed*3))
            setProperty(text..".alpha", lerp(getProperty(text..".alpha"), 1 + (math.abs(turn) * -0.24), elapsed*5))

            setProperty(text..".angle", lerp(getProperty(text..".angle"), targetAngle, elapsed*(darkMode and 0.3 or 4)))

        end
        if (tag == "story" and pageName == "story") or (tag == "freeplay" and pageName == "freeplay") then 
            local targetY = middleY + ((getProperty(text..".height") + 4) * turn)
            
            local targetSize = (isChosen and 1.4 or 1); 
            if (tag == "freeplay" and pageName == "freeplay") then targetSize = (isChosen and 1.5 or 1) end
            local targetAngle = (isChosen and (math.sin(textClock*2)*2) or 0)
            setProperty(text..".origin.x", (getProperty(text..".width")/9) * 8)

            scaleNoUpdate(text, lerp(getProperty(text..".scale.x"), targetSize, elapsed*4))
            setProperty(text..".y", lerp(getProperty(text..".y"), targetY, elapsed*3))
            setProperty(text..".x", lerp(getProperty(text..".x"), -150 + (math.abs(turn) * 10), elapsed*3))
            if (tag == "freeplay" and pageName == "freeplay") then 
                setProperty(text..".alpha", lerp(getProperty(text..".alpha"), 1 + (math.abs(turn) * -0.15), elapsed*5)) 
            else
                setProperty(text..".alpha", lerp(getProperty(text..".alpha"), 1 + (math.abs(turn) * -0.24), elapsed*5)) 
            end

            setProperty(text..".angle", lerp(getProperty(text..".angle"), targetAngle, elapsed*(darkMode and 1 or 4)))

        end
        if (tag == "settings" and pageName == "settings") then 
            local targetY = middleY + ((getProperty(text..".height") + 4) * turn)
            
            local targetSize = (isChosen and 1.4 or 1); 
            local targetAngle = (isChosen and (math.sin(textClock*2)*2) or 0)
            setProperty(text..".origin.x", (getProperty(text..".width")/9) * 8)

            scaleNoUpdate(text, lerp(getProperty(text..".scale.x"), targetSize, elapsed*4))
            setProperty(text..".y", lerp(getProperty(text..".y"), targetY, elapsed*4))
            setProperty(text..".x", lerp(getProperty(text..".x"), -150 + (math.abs(turn) * 10), elapsed*4))
            if (tag == "freeplay" and pageName == "freeplay") then 
                setProperty(text..".alpha", lerp(getProperty(text..".alpha"), 1 + (math.abs(turn) * -0.15), elapsed*5)) 
            else
                setProperty(text..".alpha", lerp(getProperty(text..".alpha"), 1 + (math.abs(turn) * -0.24), elapsed*5)) 
            end

            setProperty(text..".angle", lerp(getProperty(text..".angle"), targetAngle, elapsed*(darkMode and 1 or 4)))

            if optionStuff[curSelect].type == "bool" then 
                for i = 1, #textsGroup do 
                    local boolString = (optionStuff[i].value and "True" or "False")
                    setTextString(textsGroup[i].name ,boolString.." : " ..optionStuff[i].name)
                end
            end
        end
        if (tag == "awards" and pageName == "awards") then 
            local targetY = middleY + ((getProperty(text..".height") + 4) * turn)
            
            local targetSize = (isChosen and 1.4 or 1); 
            local targetAngle = (isChosen and (math.sin(textClock*2)*2) or 0)
            setProperty(text..".origin.x", (getProperty(text..".width")/9) * 8)

            scaleNoUpdate(text, lerp(getProperty(text..".scale.x"), targetSize, elapsed*4))
            setProperty(text..".y", lerp(getProperty(text..".y"), targetY, elapsed*4))
            setProperty(text..".x", lerp(getProperty(text..".x"), -150 + (math.abs(turn) * 10), elapsed*3))
            setProperty(text..".alpha", lerp(getProperty(text..".alpha"), 1 + (math.abs(turn) * -0.24), elapsed*5)) 
          

            setProperty(text..".angle", lerp(getProperty(text..".angle"), targetAngle, elapsed*(darkMode and 1 or 4)))

        end
    end
end

local targetText = ""
local targetSprText = ""
function typeText(_textSpr, text, delay)
    cancelTimer("textRemove")
    targetSprText = _textSpr
    targetText = tostring(text)
    runTimer('textTyping', delay, string.len(tostring(text)))
end

function typeTextRemove(_textSpr, delay)
    cancelTimer("textTyping")
    targetSprText = _textSpr
    runTimer('textRemove', delay, string.len(getTextString(targetSprText)))
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "startingDark" then 
        soundFadeOut("", 2)
        runTimer("darkTime", 2)
        doTweenAlpha("coverBlack", "coverBlack", 1, 2)
    end
    if tag == "glitchy" then
        playSound("glitchIntense", 0.8, "glitch") 
        glitching = true
    end
    if tag == "darkTime" then 
        openCustomSubstate("tutorialPage", true)
    end
    if tag == "startCountdown" then 
        startCountdown()
    end
    if tag == "endLoading" then 
        loadingSelect = false
        if pageName == "story" then 
            local textSize = 40
            local thisArray = makeText(getAllStories(true), {align = "right", size = textSize, ySpace = (textSize + 5), borderSize = 3, borderColor = "0B0B0B", tag = "story", scale = 1}, true)
            for i = 1, #thisArray do 
                local text = thisArray[i].name
                setProperty(text..".x", getProperty(text..".x") + 350)
                setProperty(text..".y", (720/2) - getProperty(text..".height")/2)
            end
        end
        if pageName == "freeplay" then 
            local textSize = 40
            local thisArray = makeTextForFreeplay({align = "right", size = textSize, ySpace = (textSize + 5), borderSize = 3, borderColor = "0B0B0B", tag = "freeplay", scale = 1})
            for i = 1, #thisArray do 
                local text = thisArray[i].name
                setProperty(text..".x", getProperty(text..".x") + 350)
                setProperty(text..".y", (720/2) - getProperty(text..".height")/2)
            end
            changeText(1, true, true) 
        end
        if pageName == "menu" then 
            local textSize = 80
            local thisArray = makeText(menuStuff, {align = "left", size = textSize, ySpace = (textSize + 5), borderSize = 4, borderColor = "0B0B0B", tag = "menu", scale = 1}, true)
            for i = 1, #thisArray do 
                local text = thisArray[i].name
                setProperty(text..".x", getProperty(text..".x") - 350)
                setProperty(text..".y", (720/2) - getProperty(text..".height")/2)
            end
        end
        if pageName == "settings" then 
            local textSize = 40
            local thisArray = makeText(optionStuff, {align = "right", size = textSize, ySpace = (textSize + 5), borderSize = 3, borderColor = "0B0B0B", tag = "settings", scale = 1}, true)
            for i = 1, #thisArray do 
                local text = thisArray[i].name
                setProperty(text..".x", getProperty(text..".x") + 350)
                setProperty(text..".y", (720/2) - getProperty(text..".height")/2)
            end
        end
        if pageName == "awards" then 
            local textSize = 40
            local thisArray = makeText(turnAwardsIntoArray(), {align = "right", size = textSize, ySpace = (textSize + 5), borderSize = 3, borderColor = "0B0B0B", tag = "awards", scale = 1}, true)
            for i = 1, #thisArray do 
                local text = thisArray[i].name
                setProperty(text..".x", getProperty(text..".x") + 350)
                setProperty(text..".y", (720/2) - getProperty(text..".height")/2)
            end
        end
        changeText(0, true, true) 
        if pageName == "story" or pageName == "freeplay" then 
            setProperty("songBG.x", 1280)
            doTweenX("songBG", "songBG", 0, 0.5, "quadOut")
        end
        doValueTween("bgZoom", "defaultBGScale", 2, 1.2, 0.5, "quadInOut")
    end
    if tag == 'textTyping' then
        setTextString(targetSprText, string.sub(targetText, 0, ((loops) - (loopsLeft))))
    end
    if tag == 'textRemove' then
        setTextString(targetSprText, string.sub(getTextString(targetSprText), 0, loopsLeft ))
        if loopsLeft <= 0 then 
            setTextString(targetSprText, "")
        end
     end
     if tag == "exitMenu" then 
        addHealth(-999999999999)
        stopSound("glitch")
     end
     if tag == "selectSong" then 
        setDataFromSave("ammarc", "kaijuShortMode", false)
        loadSong("Kaiju Paradise", -1)
     end
end

local targetBGChange = ""
function onTweenCompleted(tag)
    if tag == "barDownSC" then
        doTweenY("barDownSC2", "barDown.scale", 1, 0.25, "quadOut")
    end
    if tag == "barUpSC" then
        doTweenY("barUpSC2", "barUp.scale", 1, 0.25, "quadOut")
        loadGraphic("songBG", targetBGChange) 
        setGraphicSize("songBG", 1280, 720)
    end
end

function turnSongsIntoArray(_storyName)
    local songArray = songStuff
    local storyName = tostring(_storyName)
    local returnArray = {}

    for i = 1, #songArray do 
        if string.lower(songArray[i].name) == string.lower(storyName) then 
            for a = 1, #songArray[i].songs do 
                local aSong =songArray[i].songs[a]
                table.insert(returnArray, 
                    {
                        song = aSong.song,
                        name = aSong.song, -- because makeText()
                        difficulty = aSong.difficulty,
                        background = aSong.background,
                        beatWeekFirst = aSong.beatWeekFirst,
                        description = aSong.description
                    }
                )
            end
            return returnArray;
        end
    end
    
    return {}
end

function turnAllSongsIntoArray()
    local songArray = songStuff
    local returnArray = {}

    for i = 1, #songArray do 
        for a = 1, #songArray[i].songs do 
            local aSong = songArray[i].songs[a]
            table.insert(returnArray, 
                {
                    song = aSong.song,
                    name = aSong.song, -- because makeText()
                    difficulty = aSong.difficulty,
                    background = aSong.background,
                    beatWeekFirst = aSong.beatWeekFirst,
                    description = aSong.description
                }
            )
        end
    end
    return returnArray;
end

function turnAwardsIntoArray()
    local _array = awardsStuff

    local returnArray = {}

    for i = 1, #_array do 
        local everyArray = _array[i]
        local awardName = everyArray.name
        if not findAwardSave(awardName) then 
            awardName = string.rep("?", #awardName)
        end
        table.insert(returnArray, 
            {
                name = awardName,
                nameTag = everyArray.name,
                description = everyArray.description,
                clueDesc = everyArray.clueDesc,
                background = ""
            }
        )

    end
    return returnArray;
end

function findAwardSave(awardName)
    local awardsSave = getDataFromSave("ammarc", "achievement")
    if #awardsSave <= 0 then return false end
    for i = 1, #awardsSave do 
        if awardName == awardsSave[i] then 
            return true
        end
    end
    return false
end

function getAllStories(onlyStory)
    local songArray = songStuff
    local storyName = tostring(_storyName)
    local returnArray = {}

    for i = 1, #songArray do 
        if (songArray[i].isStory or not onlyStory) then 
            table.insert(returnArray, {name = songArray[i].name, description = songArray[i].description, background = songArray[i].background})
        end
    end
    return returnArray
end

function changeText(_amount, noSound, noMoveBars) 
    curSelect = curSelect + _amount
    if curSelect < (#textsGroup) and curSelect >= 1 then
        if textsGroup[curSelect].songTitle ~= nil then 
            curSelect = curSelect + _amount;
        end
    end
    
    if maximumSelect then 
        if curSelect > #textsGroup then 
            curSelect = 1
        elseif curSelect < 1 then 
            curSelect = #textsGroup
        end
    end

    if curSelect < (#textsGroup) and curSelect >= 1 then
        if textsGroup[curSelect].songTitle ~= nil then 
            curSelect = curSelect + _amount;
        end
    end
   
    
    if not noSound then 
        playSound(soundStuff.scroll, 0.6, soundStuff.scroll)
    end

    if  textsGroup[curSelect].background ~= nil and (textsGroup[curSelect].background ~= "") and not string.find(getTextString(textsGroup[curSelect].name), "???") then 
        if targetBGChange ~= "menu/" .. textsGroup[curSelect].background then 
            targetBGChange = "menu/" .. textsGroup[curSelect].background
            
            setProperty("songBG.y", 0)
            if not noMoveBars then 
                cancelTween("barDownSC2") cancelTween("barUpSC2")
                doTweenY("barDownSC", "barDown.scale", 8, 0.25, "quadInOut")
                doTweenY("barUpSC", "barUp.scale", 8, 0.25, "quadInOut")
            else 
                loadGraphic("songBG", targetBGChange) 
                setGraphicSize("songBG", 1280, 720)
            end
        end
    end
    if textsGroup[curSelect].tag == "awards" then 
        if string.find(getTextString(textsGroup[curSelect].name), "???") then 
            typeText("descText", "Hint : ".. awardsStuff[curSelect].clueDesc, 0.03)
        else 
            typeText("descText", awardsStuff[curSelect].description .. "\n(" .. awardsStuff[curSelect].clueDesc .. ")", 0.03)
        end
    else
        if textsGroup[curSelect].description ~= nil then
            typeText("descText", textsGroup[curSelect].description, 0.03)
        end
    end
end

function scaleNoUpdate(name, scaleX, scaleY)
    if scaleY == nil then 
        setProperty(name..".scale.x", scaleX)
        setProperty(name..".scale.y", scaleX)
    else
        setProperty(name..".scale.x", scaleX)
        setProperty(name..".scale.y", scaleY)
    end
end

function makeText(__array, _textOption, _clearTexts)
    local _array = __array
    local align = "right"; local font = "1_Minecraft-Regular.otf"; local size = 32; local ySpace = 36; local borderSize = 1; local borderColor = "000000"; local scale = 1;
    local textTag = ""
    local clearTexts = _clearTexts
    if _textOption ~= nil then 
        if _textOption.align ~= nil then align = _textOption.align end
        if _textOption.font ~= nil then font = _textOption.font end
        if _textOption.size ~= nil then size = _textOption.size end
        if _textOption.ySpace ~= nil then ySpace = _textOption.ySpace end
        if _textOption.borderSize ~= nil then borderSize = _textOption.borderSize end
        if _textOption.borderColor ~= nil then borderColor = _textOption.borderColor end
        if _textOption.tag ~= nil then textTag = _textOption.tag end
        if _textOption.scale ~= nil then scale = _textOption.scale end
    end
    

    if clearTexts then 
        for i = 1, #textsGroup do 
            removeLuaText(textsGroup[i])
            cancelTween(textsGroup[i])
        end
        textsGroup = {}
    end
    local loadedText = {}

    for i = 1, #_array do 
        local nameTag = (_array[i].name):gsub( " ", "_")
        if _array[i].nameTag ~= nil then nameTag = _array[i].nameTag end
        makeLuaText(nameTag, _array[i].name , 1280 ,0, 100 + (i * ySpace))
        setTextSize(nameTag, size)
        setObjectCamera(nameTag, 'hud')
        setTextBorder(nameTag, borderSize, borderColor)
        setTextFont(nameTag, font)
        setTextAlignment(nameTag, align)
        addLuaText(nameTag)
        setProperty(nameTag..".antialiasing", getPropertyFromClass("ClientPrefs", "globalAntialiasing"))
        scaleObject(nameTag, scale, scale)
        setObjectOrder(nameTag, getObjectOrder("blackness")-1)
        
        local desc = ""
        if _array[i].description ~= nil then desc = _array[i].description end
        local textBG = ""
        if _array[i].background ~= nil then textBG = _array[i].background end

        local textArray = {name = nameTag, tag = textTag, spaceDistance = ySpace, description = desc, background = textBG, defaultText = _array[i].name}
        table.insert(loadedText, textArray)
        table.insert(textsGroup, textArray)
    end
    return loadedText
end

function makeTextForFreeplay(_textOption)
    local _array = songStuff
    local align = "right"; local font = "1_Minecraft-Regular.otf"; local size = 32; local ySpace = 36; local borderSize = 1; local borderColor = "000000"; local scale = 1;
    local textTag = "freeplay"
    local clearTexts = _clearTexts
    if _textOption ~= nil then 
        if _textOption.align ~= nil then align = _textOption.align end
        if _textOption.font ~= nil then font = _textOption.font end
        if _textOption.size ~= nil then size = _textOption.size end
        if _textOption.ySpace ~= nil then ySpace = _textOption.ySpace end
        if _textOption.borderSize ~= nil then borderSize = _textOption.borderSize end
        if _textOption.borderColor ~= nil then borderColor = _textOption.borderColor end
        if _textOption.tag ~= nil then textTag = _textOption.tag end
        if _textOption.scale ~= nil then scale = _textOption.scale end
    end

    for i = 1, #textsGroup do 
        removeLuaText(textsGroup[i])
        cancelTween(textsGroup[i])
    end
    textsGroup = {}
    
    local loadedText = {}

    for i = 1, #_array do 
        local titleName = _array[i].name
        local nameTag =_array[i].name:gsub( " ", "_").."_Title"
        makeLuaText(nameTag,  "-- " ..titleName.. " --" , 1280 ,0, 100 + (i * ySpace))
        setTextSize(nameTag, size)
        setObjectCamera(nameTag, 'hud')
        setTextBorder(nameTag, borderSize, borderColor)
        setTextFont(nameTag, font)
        setTextAlignment(nameTag, align)
        addLuaText(nameTag)
        setProperty(nameTag..".antialiasing", getPropertyFromClass("ClientPrefs", "globalAntialiasing"))
        scaleObject(nameTag, scale, scale)
        
        local desc = _array[i].description
        local textBG = ""
        if _array[i].background ~= nil then textBG = _array[i].background end

        local textArray = {name = nameTag, tag = textTag, spaceDistance = ySpace, description = desc, background = textBG, songTitle = true, defaultText = "-- " ..titleName.. " --"}
        table.insert(loadedText, textArray)
        table.insert(textsGroup, textArray)

        setObjectOrder(nameTag, getObjectOrder("blackness")-1)

        for a = 1, #_array[i].songs do
            local songTag = _array[i].songs[a].song:gsub( " ", "_")
            local aText = _array[i].songs[a].song
            if _array[i].songs[a].beatWeekFirst then 
                if not checkWeekComplete(titleName) then 
                    aText = string.rep("?", #aText)
                end
            end
            makeLuaText(songTag, aText , 1280 ,0, 100 + (i * ySpace))
            setTextSize(songTag, size)
            setObjectCamera(songTag, 'hud')
            setTextBorder(songTag, borderSize, borderColor)
            setTextFont(songTag, font)
            setTextAlignment(songTag, align)
            addLuaText(songTag)
            setProperty(songTag..".antialiasing", getPropertyFromClass("ClientPrefs", "globalAntialiasing"))
            scaleObject(songTag, scale, scale)
            
            local desc = _array[i].songs[a].description
            local textBG = ""
            if _array[i].songs[a].background ~= nil then textBG = _array[i].songs[a].background end
            if aText == "?????" then textBG = "" end

            local textArrayS = {name = songTag, tag = textTag, spaceDistance = ySpace, description = desc, background = textBG, defaultText = aText}
            table.insert(loadedText, textArrayS)
            table.insert(textsGroup, textArrayS)

            setObjectOrder(songTag, getObjectOrder("blackness")-1)
        end

      
    end
    return loadedText
end

function doValueTween(_tag, _variable, _startValue, _endValue, _dur, _ease)
	callScript("scripts/coolFunctions", "varTween", { _tag, _variable, _startValue, _endValue, _dur, _ease, scriptName })
end

function cancelTweenValue(_tag)
	callScript("scripts/coolFunctions", "cancelVarTween", { _tag })
end

function getSelectionText()
    return textsGroup[curSelect]
end

function checkArrayButton(_array)
    for i = 1, #_array do
        if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'.._array[i]) then 
            return true
        end
    end
    return false
end

function onEndSong() if blockEnding then return Function_Stop; else return Function_Continue; end end

function lerp(a, b, t) return a + (b - a) * t end

function round(x) return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5) end

