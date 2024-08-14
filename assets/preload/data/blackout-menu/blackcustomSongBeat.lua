
songBPM = 0

songBeat = 0; local prevSongBeat = 0
songStep = 0; local prevSongStep = 0
songCrochet = 0
songStepCrochet = 0
songTime = 0

function onUpdate(elapsed)
    functionSong(elapsed)
    setProperty("SONG.bpm", songBPM)
    luaDebugMode = true
end
function functionSong(elapsed)
    local time = getPropertyFromClass('flixel.FlxG', 'sound.music.time')
    songTime = time / 1000
 
    songCrochet = ((60 / songBPM) * 1000);
    songStepCrochet = songCrochet / 4;
    
    songBeat = math.ceil(songTime / (songCrochet / 1000)) - 1;
    songStep = (math.ceil(songTime / (songStepCrochet / 1000)) - 1);
 
    if prevSongBeat ~= songBeat then 
        prevSongBeat = songBeat
        runHaxeCode([[
            game.callOnLuas("customBeatHit", []]..tostring(songBeat)..[[]);
            game.setOnLuas("songBeat", ]]..tostring(songBeat)..[[);
        ]])
    end
 
    if prevSongStep ~= songStep then 
        prevSongStep = songStep
        runHaxeCode([[
            game.callOnLuas("customStepHit", []);
            game.setOnLuas("songStep", ]]..tostring(songStep)..[[);
        ]])
    end
 end