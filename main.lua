local core = {}
local key = {}
local buf = {}
local health = 6
local game_over = 0
local ingame = 0
local song = 0
local niveau = 0
local secretRoom = 0
local combo = 1
local vitesse = 1
local start = 0
local line = 0
local maps = {}


function core.ui()
  love.graphics.setColor(1, 1, 1, 0.4)
  love.graphics.rectangle("fill", 95, 0, 60, 600)
  love.graphics.rectangle("fill", 170, 0, 60, 600)
  love.graphics.rectangle("fill", 245, 0, 60, 600)
  love.graphics.rectangle("fill", 320, 0, 60, 600)
end



function key.checkClicked(x)
  for i = 0, core.touch do
    if (buf[i] ~= nil and buf[i].x == x and buf[i].y > 460 and buf[i].y < 600) then
        buf[i].anim = buf[i].anim - 0.4
        buf[i] = nil
        return(1)
    end
  end
  return (0)
end

function key.fadeOut()
    for i = 0, core.touch do
        if (buf[i] ~= nil) then
            if (buf[i].anim < 1) then
                buf[i].anim = buf[i].anim - 0.5
            end
        end
        -- if (buf[i] ~= nil and buf[i].anim == 0) then
        --     buf[i].y = nil
        --     buf[i].x = nil
        --     buf[i] = nil
        -- end
    end
end

function key.setting()
  --key config
  key[0], key[1], key[2], key[3] = {}, {}, {}, {}
  key[0].x = 100
  key[0].y = -50
  key[0].width = 50
  key[0].height = 50
  key[0].mode = 0
  key[1].x = 175
  key[1].y = -50
  key[1].width = 50
  key[1].height = 50
  key[1].mode = 0
  key[2].x = 250
  key[2].y = -50
  key[2].width = 50
  key[2].height = 50
  key[2].mode = 0
  key[3].x = 325
  key[3].y = -50
  key[3].width = 50
  key[3].height = 50
  key[3].mode = 0
end

function love.load()
  for line in love.filesystem.lines("maps/test.txt") do
      table.insert(maps, line)
  end
  succes = love.window.setMode(800, 600, flags)
  core["scene"] = 0
  core["touch"] = -1
  core["mem"] = 0
  key.setting()
  core["score"] = 0
  love.keyboard.setKeyRepeat(false)
  core["logo"] = love.graphics.newImage("assets/logo.png")
  core["logoend"] = love.graphics.newImage("assets/issou.png")
  core["GuitarHeroLogo"] = love.graphics.newImage("assets/GUITAR HERO.png")
  core["thunderstruck"] = love.graphics.newImage("assets/thunderstruck.png")
  core["ACDCLive"] = love.graphics.newImage("assets/ACDC Live.png")
  core["Starset"] = love.graphics.newImage("assets/Starset.png")
  core["Uganda"] = love.graphics.newImage("assets/Uganda.png")
  core["UgandaRemix"] = love.graphics.newImage("assets/UGANDA REMIX.png")
  core["MusDaWay"] = love.audio.newSource("assets/do you know da way.mp3", "stream")
  core["Courtesy"] = love.graphics.newImage("assets/Courtesy.png")
  core["Ariana"] = love.graphics.newImage("assets/ariana.png")
  core["Nicki"] = love.graphics.newImage("assets/nicki.png")
  core["anaconda"] = love.graphics.newImage("assets/anaconda.png")
  core["Johny"] = love.graphics.newImage("assets/johny hallyday.png")
  core["allumer"] = love.graphics.newImage("assets/allumer.png")
  core["NyanPNG"] = love.graphics.newImage("assets/Nyanpng.png")
  core["NyanCat"] = love.graphics.newImage("assets/Nyan cat.png")
  core["TMlogo"] = love.graphics.newImage("assets/TMpng.png")
  core["TMstadium"] = love.graphics.newImage("assets/track mania stadium.png")
  core["TMsong"] = love.audio.newSource("assets/TM song.mp3", "stream")
  core["illuminati"] = love.graphics.newImage("assets/illuminati.png")
  core["ArianaNicki"] = love.graphics.newImage("assets/ariana nicki minaj.png")
  core["thousand"] = love.graphics.newImage("assets/thousand foot krutch.png")
  core["Whatever"] = love.graphics.newImage("assets/Whathever it takes.png")
  core["ImagineDragons"] = love.graphics.newImage("assets/Imagine dragons.png")
  core["GRStarset"] = love.graphics.newImage("assets/GRStarset.png")
  core["MusNyan"] = love.audio.newSource("assets/nyan cat mus.mp3", "stream")
  core["MusThunderstruck"] = love.audio.newSource("assets/acdc thunderstruck.mp3", "stream")
  core["MusIssou"] = love.audio.newSource("assets/Musissou.mp3", "stream")
  core["MusAnaconda"] = love.audio.newSource("assets/nicki minaj anaconda.mp3", "stream")
  core["MusAllumerLeFeu"] = love.audio.newSource("assets/allumer le feu.mp3", "stream")
  core["MusIllumiati"] = love.audio.newSource("assets/illuminati song.mp3", "stream")
  core["MusCourtesy"] = love.audio.newSource("assets/courtesy call.mp3", "stream")
  core["MusCarnivore"] = love.audio.newSource("assets/starset-carnivore.mp3", "stream")
  core["MusWhatever"] = love.audio.newSource("assets/whatever it takes.mp3", "stream")
  core["MusSidetoside"] = love.audio.newSource("assets/side to side.mp3", "stream")
  core["music"] = love.audio.newSource("assets/mama.mp3", "stream")
  core["SPACESHIP"] = love.graphics.newImage("assets/SPACESHIP.png")
  --love.audio.play(core.music)
end

function key.appendBufferMap(ligne)
    for i = 1, string.len(ligne) do
        if string.byte(ligne, i) == 88 then
                core.touch = core.touch + 1
                buf[core.touch] = {}
                buf[core.touch].x = key[i - 1].x
                buf[core.touch].y = -50
                buf[core.touch].anim = 1
        end
    end
end

function love.keypressed(myKey)
    --core.score = core.score + 10
    n = 2
    if ingame == 1 then
        if myKey == "q" and key.checkClicked(100) == 1 then
            core.score = core.score + math.random(1000)*(n+combo)
            n = n + 1
            combo = combo + 1
        elseif myKey == "s" and key.checkClicked(175) == 1 then
            core.score = core.score + math.random(1000)*(n+combo)
            n = n + 1
            combo = combo + 1
        elseif myKey == "d" and key.checkClicked(250) == 1 then
            core.score = core.score + math.random(1000)*(n+combo)
            n = n + 1
            combo = combo + 1
        elseif myKey == "f" and key.checkClicked(325) == 1 then
            core.score = core.score + math.random(1000)*(n+combo)
            n = n + 1
            combo = combo + 1
        else
            health = health - 1
            -- combo = 1
        end
    end
    if ingame == 0 and niveau ~= "fin" and niveau ~= 0 then
        if myKey == "s" then
            secretRoom = 1
            love.audio.play(core.MusIllumiati)
        end
    end
end

function key.appendBuffer()
  if (math.random(1000) < 25) then
    core.touch = core.touch +1
    buf[core.touch] = {}
    buf[core.touch].x = key[math.random(4) - 1].x
    buf[core.touch].y = -50
   buf[core.touch].anim = 1
  end
end

function key.scrolling()
  for i = 0, core.touch do
    if (buf[i] ~= nil) then
      buf[i].y = buf[i].y + 5*vitesse
    end
    if (buf[i] ~= nil and buf[i].y >= 600) then
    --   buf[i].y = nil
    --   buf[i].x = nil
      buf[i] = nil
      combo = 1
    end
  end
end

function memoryCleaner()
  core.mem = core.mem + 1
  if (core.mem == 500) then
    collectgarbage()
  end
end

function love.update(dt)
  if (game_over == 0) then
    dt = math.min(dt, 1/60)

    if core.scene == 1 then
      result = love.timer.getTime() - start
      if result >= 0.1 then
        start = love.timer.getTime()
        if (line < table.getn(maps)) then
          line = line + 1
          key.appendBufferMap(maps[line])
        end
      end        -- key.fadeOut()
        key.scrolling()
        memoryCleaner()
        core.drawSceneGame()
        --love.keypressed()
    end
    -- core.score = core.score + 1
  else
    core.drawSceneMenu()
    memoryCleaner()
    --love.graphics.draw(core.logoend, 0, 0)
  end
  if core.scene == 0 then
    if love.mouse.isDown(1) then
        y = love.mouse.getY()
        if (y > 500 and y < 560) then
            core.scene = 2
            niveau = 12342345123
        end
    end
  end

end

function core.drawSceneGame()
    if niveau == 1 then
        love.audio.play(core.MusThunderstruck)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(core.ACDCLive, 0, 0)
    end
    if niveau == 2 then
        love.audio.play(core.MusCarnivore)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(core.GRStarset, 0, 0)
    end
    if niveau == 3 then
        love.audio.play(core.MusWhatever)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(core.ImagineDragons)
    end
    if niveau == 4 then
        love.audio.play(core.MusCourtesy)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(core.thousand)
    end
    if niveau == 5 then
        love.audio.play(core.MusSidetoside)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(core.Ariana)
    end
    if niveau == 6 then
        love.audio.play(core.MusAllumerLeFeu)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(core.Johny)
    end
    if niveau == "S1" then
        love.audio.play(core.MusDaWay)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(core.UgandaRemix)
    end
    if niveau == "S2" then
        love.audio.play(core.MusAnaconda)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(core.Nicki)
    end
    if niveau == "S3" then
        love.audio.play(core.MusNyan)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(core.NyanCat)
    end
    if niveau == "S4" then
        love.audio.play(core.TMsong)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(core.TMstadium)
    end
    core.ui()
    for i = 0, core.touch do
        -- if object exists, print it with his right color
        if (buf[i] ~= nil) then
            love.graphics.setColor(0, 0.66, 0.66, 1)
            if (buf[i].anim < 1) then
                love.graphics.setColor(0, 0.33, 0.33, buf[i].anim)
            end
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(core.SPACESHIP, buf[i].x, buf[i].y)
            --combo = 1
        end
    end
    --love.audio.play(core.MusThunderstruck)
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.rectangle("fill", 0, 500, 800, 40)
    --score part
    if niveau == 1 or niveau == 2 or niveau == 4 or niveau == 5 or niveau == "S1" or niveau == "S2" then
        love.graphics.setColor(1, 1, 1, 1)
    else
        love.graphics.setColor(0, 0, 0, 1)
    end
    love.graphics.print("SCORE:", 420, 150, 0, 6, 4)
    love.graphics.print(core.score, 420, 200, 0, 4, 4)
    love.graphics.print("COMBO:", 420,250, 0, 4, 4)
    love.graphics.print(combo, 610, 250, 0, 5, 5)
    love.graphics.setColor(1, 0, 0, 1)
    if (game_over == 1) then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(core.logoend, 0, 0)
        love.graphics.setColor(1, 1, 1, 0.8)
        x, y = love.mouse.getPosition( )
        if (x > 300 and x < 500 and y > 400 and y < 460) then
            love.graphics.setColor(0.8, 0.8, 0.8, 1)
            love.graphics.rectangle("fill", 300, 400, 200, 60)
        else
            love.graphics.setColor(1, 1, 1, 0.8)
            love.graphics.rectangle("fill", 300, 400, 200, 60)
        end
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.print("MENU", 320, 400, 0, 4, 4)
        love.graphics.print("Votre score est de:", 200, 300, 0, 4, 4)
        love.graphics.print(tostring(core.score), 250, 350, 0, 4, 4)
    end
    if (health > 0) then
        love.graphics.print("VIE:", 420, 100, 0, 4, 4)
        love.graphics.print(health, 510, 100, 0, 4, 4)
    end
    if (health <= 0) then
        --love.graphics.print("LIVES:0", 420, 100, 0, 4, 4)
        game_over = 1
        niveau = "fin"
        --love.audio.stop()
        if song == 0 then
            love.audio.stop()
            song = song + 1
        end
        love.audio.play(core.MusIssou)
    end
    if love.mouse.isDown(1) then
        x = love.mouse.getX()
        y = love.mouse.getY()
        if (x > 300 and x < 500 and y > 400 and y < 460) then
            song = 0
            love.audio.stop()
            ingame = 0
            game_over = 0
            health = 6
            love.load()
            secretRoom = 0
        end
    end

end

function core.drawSceneMenu()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(core.logo, 0, 0)
    x, y = love.mouse.getPosition( )
    if (y >= 500 and y <= 560) then
        love.graphics.setColor(1, 0, 0, 0.8)
        love.graphics.rectangle("fill", 0, 500, 800, 60)
    else
        love.graphics.setColor(1, 1, 1, 0.8)
        love.graphics.rectangle("fill", 0, 500, 800, 60)
    end
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print("Play", 380, 500, 0, 4, 4)
end

function core.Niveau()
    x, y = love.mouse.getPosition( )
    love.graphics.setColor(1, 1, 1, 1)
    if secretRoom == 0 then
        love.graphics.draw(core.GuitarHeroLogo, 0, 0)
        love.graphics.draw(core.thunderstruck, 50, 0)
        love.graphics.draw(core.Courtesy, 50, 200)
        --love.graphics.draw(core.thunderstruck, 50, 400)
        love.graphics.draw(core.Starset, 330, 0)
        love.graphics.draw(core.ArianaNicki, 330, 200)
        --love.graphics.draw(core.thunderstruck, 330, 400)
        love.graphics.draw(core.Whatever, 600, 0)
        love.graphics.draw(core.allumer, 600, 200)
        --love.graphics.draw(core.thunderstruck, 600, 400)
        love.graphics.setColor(1, 1, 1, 0.8)
        love.graphics.rectangle("fill", 0, 540, 800, 60)
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.print("EASY", 0, 540, 0, 4, 4)
        love.graphics.print("MEDIUM", 200, 540, 0, 4, 4)
        love.graphics.print("HARD", 400, 540, 0, 4, 4)
        love.graphics.print("GOD!!", 600, 540, 0, 4, 4)
        if vitesse == 1 then
            love.graphics.setColor(0, 0, 1, 1)
            love.graphics.rectangle("fill", 0, 540, 200, 60)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print("EASY", 0, 540, 0, 4, 4)
        end
        if vitesse == 2 then
            love.graphics.setColor(0, 1, 1, 1)
            love.graphics.rectangle("fill", 200, 540, 200, 60)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print("MEDIUM", 200, 540, 0, 4, 4)
        end
        if vitesse == 3 then
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.rectangle("fill", 400, 540, 200, 60)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print("HARD", 400, 540, 0, 4, 4)
        end
        if vitesse == 10 then
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.rectangle("fill", 600, 540, 200, 60)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print("GOD!!", 600, 540, 0, 4, 4)
        end
        if (x > 0 and x < 200 and y > 540) then
            love.graphics.setColor(0.8, 0.8, 0.8, 1)
            love.graphics.rectangle("fill", 0, 540, 200, 60)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print("EASY", 0, 540, 0, 4, 4)
            if love.mouse.isDown(1) then
                vitesse = 1
            end
        end
        if (x > 200 and x < 400 and y > 540) then
            love.graphics.setColor(0.8, 0.8, 0.8, 1)
            love.graphics.rectangle("fill", 200, 540, 200, 60)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print("MEDIUM", 200, 540, 0, 4, 4)
            if love.mouse.isDown(1) then
                vitesse = 2
            end
        end
        if (x > 400 and x < 600 and y > 540) then
            love.graphics.setColor(0.8, 0.8, 0.8, 1)
            love.graphics.rectangle("fill", 400, 540, 200, 60)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print("HARD", 400, 540, 0, 4, 4)
            if love.mouse.isDown(1) then
                vitesse = 3
            end
        end
        if (x > 600 and y > 540) then
            love.graphics.setColor(0.8, 0.8, 0.8, 1)
            love.graphics.rectangle("fill", 600, 540, 200, 60)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.print("GOD!!", 600, 540, 0, 4, 4)
            if love.mouse.isDown(1) then
                vitesse = 10
            end
        end

        if love.mouse.isDown(1) then
            if (x > 50 and x < 200 and y > 0 and y < 150) then
                start = love.timer.getTime()
                core.scene = 1
                niveau = 1
                ingame = 1
            end
        end
        if love.mouse.isDown(1) then
            if (x > 330 and x <= 480 and y > 0 and y < 150) then
                start = love.timer.getTime()
                core.scene = 1
                niveau = 2
                ingame = 1
            end
        end
        if love.mouse.isDown(1) then
            if (x > 600 and x < 750 and y > 0 and y < 150) then
                start = love.timer.getTime()
                core.scene = 1
                niveau = 3
                ingame = 1
            end
        end
        if love.mouse.isDown(1) then
            if (x > 50 and x < 200 and y > 200 and y < 350) then
                start = love.timer.getTime()
                core.scene = 1
                niveau = 4
                ingame = 1
            end
        end
        if love.mouse.isDown(1) then
            if (x > 330 and x < 480 and y > 200 and y < 350) then
                start = love.timer.getTime()
                core.scene = 1
                niveau = 5
                ingame = 1
            end
        end
        if love.mouse.isDown(1) then
            if (x > 600 and x < 750 and y > 200 and y < 350) then
                start = love.timer.getTime()
                core.scene = 1
                niveau = 6
                ingame = 1
            end
        end
    end
    if secretRoom == 1 then
        love.graphics.draw(core.illuminati, 0, 0)
        love.graphics.draw(core.Uganda, 50, 0)
        love.graphics.draw(core.TMlogo, 50, 200)
        --love.graphics.draw(core.thunderstruck, 50, 400)
        love.graphics.draw(core.anaconda, 330, 0)
        --love.graphics.draw(core.thunderstruck, 330, 200)
        --love.graphics.draw(core.thunderstruck, 330, 400)
        love.graphics.draw(core.NyanPNG, 600, 0)
        --love.graphics.draw(core.thunderstruck, 600, 200)
        --love.graphics.draw(core.thunderstruck, 600, 400)
        love.graphics.setColor(1, 1, 1, 0.8)
        love.graphics.rectangle("fill", 0, 540, 800, 60)
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.print("EASY", 0, 540, 0, 4, 4)
        love.graphics.print("MEDIUM", 200, 540, 0, 4, 4)
        love.graphics.print("HARD", 400, 540, 0, 4, 4)
        love.graphics.print("GOD!!", 600, 540, 0, 4, 4)
        if vitesse == 1 then
            love.graphics.setColor(0, 0, 1, 1)
            love.graphics.rectangle("fill", 0, 540, 200, 60)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print("EASY", 0, 540, 0, 4, 4)
        end
        if vitesse == 2 then
            love.graphics.setColor(0, 1, 1, 1)
            love.graphics.rectangle("fill", 200, 540, 200, 60)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print("MEDIUM", 200, 540, 0, 4, 4)
        end
        if vitesse == 3 then
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.rectangle("fill", 400, 540, 200, 60)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print("HARD", 400, 540, 0, 4, 4)
        end
        if vitesse == 10 then
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.rectangle("fill", 600, 540, 200, 60)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print("GOD!!", 600, 540, 0, 4, 4)
        end
        if (x > 0 and x < 200 and y > 540) then
            love.graphics.setColor(0.8, 0.8, 0.8, 1)
            love.graphics.rectangle("fill", 0, 540, 200, 60)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print("EASY", 0, 540, 0, 4, 4)
            if love.mouse.isDown(1) then
                vitesse = 1
            end
        end
        if (x > 200 and x < 400 and y > 540) then
            love.graphics.setColor(0.8, 0.8, 0.8, 1)
            love.graphics.rectangle("fill", 200, 540, 200, 60)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print("MEDIUM", 200, 540, 0, 4, 4)
            if love.mouse.isDown(1) then
                vitesse = 2
            end
        end
        if (x > 400 and x < 600 and y > 540) then
            love.graphics.setColor(0.8, 0.8, 0.8, 1)
            love.graphics.rectangle("fill", 400, 540, 200, 60)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.print("HARD", 400, 540, 0, 4, 4)
            if love.mouse.isDown(1) then
                vitesse = 3
            end
        end
        if (x > 600 and y > 540) then
            love.graphics.setColor(0.8, 0.8, 0.8, 1)
            love.graphics.rectangle("fill", 600, 540, 200, 60)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.print("GOD!!", 600, 540, 0, 4, 4)
            if love.mouse.isDown(1) then
                vitesse = 10
            end
        end
        if love.mouse.isDown(1) then
            if x > 50 and x < 200 and y < 150 then
                start = love.timer.getTime()
                core.scene = 1
                niveau = "S1"
                ingame = 1
                love.audio.stop()
            end
        end
        if love.mouse.isDown(1) then
            if x > 330 and x < 480 and y < 150 then
                start = love.timer.getTime()
                core.scene = 1
                niveau = "S2"
                ingame = 1
                love.audio.stop()
            end
        end
        if love.mouse.isDown(1) then
            if x > 600 and x < 750 and y < 150 then
                start = love.timer.getTime()
                core.scene = 1
                niveau = "S3"
                ingame = 1
                love.audio.stop()
            end
        end
        if love.mouse.isDown(1) then
            if x > 50 and x < 200 and y > 200 and y < 350 then
                start = love.timer.getTime()
                core.scene = 1
                niveau = "S4"
                ingame = 1
                love.audio.stop()
            end
        end
    end
    love.keypressed()
end

function love.draw()
    if core.scene == 1 then
        core.drawSceneGame()
    end
    if core.scene == 0 then
        core.drawSceneMenu()
    end
    if (core.scene == 2) then
        core.Niveau()
    end
end
