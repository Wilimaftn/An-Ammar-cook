shaky = 0 
camShake = 0
alarmAlpha = 0;
healthDrain = 0.015

defaultGhost = true

beatPart = false;
local mechanic = false
function onCreate()
   luaDebugMode = true
   defaultGhost = getPropertyFromClass('ClientPrefs', "ghostTapping")
   
end
function onDestroy()
   setPropertyFromClass('ClientPrefs', "ghostTapping", defaultGhost)
end

function onCreatePost()
   mechanic = getDataFromSave("ammarc", "mechanic")
   if mechanic then 
      --setPropertyFromClass('ClientPrefs', "ghostTapping", false)
   end
   
   makeLuaSprite("red", "", -100,-100)
	makeGraphic("red", 1400, 900, "FF0000")
	scaleObject("red", 1, 1)
	addLuaSprite('red')
   setObjectCamera('red', "hud")
   setProperty("red.alpha", 0)
   setBlendMode("red", "multiply")
   
   if not mechanic then 
      setObjectCamera('glitch', "hud")
      setObjectOrder("glitch", getObjectOrder("strumLineNotes")-1)
     
   else 
      setObjectOrder('red', 30)
   end
end


function onStepHit()
   if getProperty("dad.animation.curAnim.name") == "glitch" then 
      triggerEvent("Add Camera Zoom", 0.015*8, 0.03*5)
      camShake = camShake + 0.05
      playAnim("gf", "scared", true)
      playAnim("boyfriend", "scared", true)
   end

end

function onBeatHit()
   if curBeat == 48 or curBeat == 368 then 
      alarmAlpha = 0.5;
   end
   if curBeat == 400 then 
      alarmAlpha = 0;
   end
   if curBeat == 80 then 
      alarmAlpha = 0;
      beatPart = true
   end
   if curBeat == 112 or curBeat == 272 then 
      alarmAlpha = 0.5;
       shaky = 0.012
       setProperty("glitch.alpha",0.35)
   end
   if curBeat == 304 then 
      alarmAlpha = 0.6;
      shaky = 0.014
      setProperty("glitch.alpha",0.45)
      healthDrain = 0.025
  end
   if curBeat == 144 or curBeat == 336 then 
      alarmAlpha = 0;
      shaky = 0
      setProperty("glitch.alpha",0.1)
      if curBeat == 336 then 
         beatPart = false
      end
  end
  if curBeat >= 304 and curBeat < 336 then 
   playAnim("gf", "scared", true)
   if getProperty("boyfriend.animation.curAnim.name") == "idle" then 
      playAnim("boyfriend", "scared", true)
   end
  end

  if curBeat == 144 then 
   beatPart = false
   setProperty("web.alpha", 1)
	setProperty("whiteBG.alpha", 1)
   cameraFlash("game", "FFFFFF", 1)
   setProperty("gf.antialiasing", false)
   setProperty("dad.antialiasing", false)
   setProperty("boyfriend.antialiasing", false)
  end 
  if curBeat == 240 then 
   beatPart = true
   setProperty("web.alpha", 0)
	setProperty("whiteBG.alpha", 0)
   cameraFlash("game", "FF0000", 1)
   local anti = getPropertyFromClass("ClientPrefs", "globalAntialiasing")
   setProperty("gf.antialiasing", anti)
   setProperty("dad.antialiasing", anti)
   setProperty("boyfriend.antialiasing", anti)
  end 

  if beatPart then 
   triggerEvent("Add Camera Zoom", 0.015 * 8, 0.03 * 1.5)
  end

end


function opponentNoteHit(id, direction, type, sus)
   if not sus then 
      camShake = camShake + 0.003
   end
   camShake = camShake + 0.001

   local hpp = getProperty("health")
   if not sus then
	   hpp = hpp - healthDrain
   else 
      hpp = hpp - (healthDrain / 5)
   end
   if hpp < 0.1 then 
      hpp = 0.1
   end

   setProperty("health", hpp)
end
redAE = 0
function onUpdate(elapsed)
   if not inGameOver then
      if curBeat >= 336 then 
         redAE = redAE +elapsed * 12
      else
         redAE = redAE +elapsed * 6
      end
      setProperty("red.alpha", math.sin(redAE) * (alarmAlpha/2) + alarmAlpha)
      if getProperty("dad.animation.curAnim.name") == "scream" then 
         playAnim("gf", "scared", true)
         triggerEvent("Add Camera Zoom", 0.06 * elapsed * 50, 0.01 * elapsed * 50)
      end
   end
end

function onUpdatePost(elapsed)
   if not inGameOver then
      camShake = lerp(camShake, 0, elapsed * 6)
      local resultShake = camShake + shaky
      
      canGameX = 0.5 * getPropertyFromClass("flixel.FlxG", "width") * (1 - getProperty("camGame.zoom")) * getPropertyFromClass("flixel.FlxG", "scaleMode.scale.x")
      canGameY = 0.5 * getPropertyFromClass("flixel.FlxG", "height") * (1 - getProperty("camGame.zoom")) * getPropertyFromClass("flixel.FlxG", "scaleMode.scale.y")
      canHUDX = 0.5 * getPropertyFromClass("flixel.FlxG", "width") * (1 - getProperty("camHUD.zoom")) * getPropertyFromClass("flixel.FlxG", "scaleMode.scale.x")
      canHUDY = 0.5 * getPropertyFromClass("flixel.FlxG", "height") * (1 - getProperty("camHUD.zoom")) * getPropertyFromClass("flixel.FlxG", "scaleMode.scale.y")
      if resultShake > 0 then 
         --cameraShake("game", resultShake, 0.01)
         --cameraShake("hud", resultShake/2, 0.01)
         local randomX =  getRandomFloat(-resultShake, resultShake) * 700
         local randomY =  getRandomFloat(-resultShake, resultShake) * 700
         setProperty("camGame.canvas.x", canGameX + randomX)
         setProperty("camGame.canvas.y", canGameY + randomY)

         if mechanic then
            setProperty("camHUD.canvas.x", canHUDX + (-randomX*0.5))
            setProperty("camHUD.canvas.y", canHUDY + (-randomY/2*0.5))
         end
         --setProperty("camGame.canvas.rotation", randomX/6)
      end
   end
end

function lerp(a, b, t)
	return a + (b - a) * t
end