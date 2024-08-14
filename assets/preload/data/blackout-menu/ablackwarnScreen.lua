function onCreate()
    addHaxeLibrary("FlxText", "flixel.text")
    addHaxeLibrary("FlxTextAlign", "flixel.text.FlxText")
    luaDebugMode = true
end

function onCustomSubstateCreatePost(name)
	if name == 'tutorialPage' then 
        runHaxeCode([[
            warnBG = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFF000000);
            warnBG.alpha = 0;
            CustomSubstate.instance.add(warnBG);

            warnText = new FlxText(0, 0, 0, "
            It look like someone hack the game. 
            You didn't even finish the song yet.
            You need to play the song again.
            don't be late or the 'goo' come and get You.

            (Move your cursor to shine the dark)

            (PRESS ENTER TO Play)
            ", 20);

            warnText.setFormat(Paths.font("vcr.ttf"), 30, 0xFFFFFFFF, "center");
            warnText.alpha = 0;
            warnText.screenCenter();
            warnText.x -= 100;
            CustomSubstate.instance.add(warnText);

            FlxTween.tween(warnBG, {alpha: 0.8}, 1);
            FlxTween.tween(warnText, {alpha: 1}, 1);
            

        ]])
    end
    --setGlobalFromScript("data/".."ammar-menu".."/menu", "noButton", true)
end

function onCustomSubstateUpdatePost(name)
	if name == 'tutorialPage' then 
        if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ESCAPE') then
           runTimer("closeSubsss", 1)
          
            runHaxeCode([[
                FlxTween.tween(warnBG, {alpha: 0, y: -720}, 0.5);
                FlxTween.tween(warnText, {alpha: 0, y: 720}, 0.5);
            ]])
        end
    end

end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "closeSubsss" then 
        closeCustomSubstate()
        runTimer("startCountdown", 0.5)
        setGlobalFromScript("data/".."ammar-menu".."/menu", "noButton", false)
        startCountdown()
    end
end

