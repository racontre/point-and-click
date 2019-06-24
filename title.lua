require "system"

buttons = {}
buttons[1] = {376, 380, 360, 72, "New Gameaaaaaaaaaaaaaaaaaaaaaaaa"}
buttons[2] = {376, 476, 360, 72, "Continue"}
buttons[3] = {150, WINDOW_HEIGHT - 50, 360, 72, ""}; bottomTextIndex = 3; --bottom text

buttons.message = ""
title={}
function title.load()
maintitle = love.graphics.newImage('img/titulo.png')
scale = 1
end

function title.draw()
	 if gameState.room == "MainMenu" then
	love.graphics.setColor(1, 1, 1)
	    love.graphics.draw(maintitle)
	love.graphics.setColor(0, 0, 0.1)
	    love.graphics.printf("CAVERN", 0, 140 , 400, "center")
    buttons.message = ""

    for _,b in ipairs(buttons) do

      -- Get attributes stored for the current button

      local bX = b[1] * scale;
      local bY = b[2] * scale;
      local bW = b[3] * scale;
      local bH = b[4] * scale;
      local bText = b[5];
	  
      if buttons:mouseCheck(b) then -- if the mouse is over the button...

        -- Button border
        -- love.graphics.setColor(0.384, 0.604, 0.475) -- enemy color
        love.graphics.setColor(0, 0, 0) -- white
        love.graphics.setLineWidth(6)
        love.graphics.rectangle("line", bX, bY, bW, bH)

        -- Update the button message at the bottom of the screen
        if bText == "New Gameaaaaaaaaaaaaaaaaaaaaaaaa" then
          buttons[bottomTextIndex][5] = "Start a new game - erases old save file"
        elseif bText == "Continue" then
          buttons[bottomTextIndex][5] = "Continue from where you left off"
        elseif bText == ".sound" then
          buttons[bottomTextIndex][5] = "Turn music and sound effects on or off"
        elseif bText == ".github" then
          buttons[bottomTextIndex][5] = "View the code on GitHub"
        end

      end

      love.graphics.setColor(0, 0, 0, 1)

      if bText == ".sound" then
        if not soundOn then
          love.graphics.setColor(0.35, 0.35, 0.35, 0.5)
        end 
        love.graphics.draw(sprites.ui.sound, bX + 15 * scale, bY + 9 * scale, 0, scale, scale)
      elseif bText == ".github" then
        love.graphics.draw(sprites.ui.github, bX + 9 * scale, bY + 8 * scale, 0, scale, scale)
      else
        love.graphics.printf(bText, bX, bY + 8 * scale, bW, "center")
      end

    end

end

end
function buttons:mouseCheck(b)

  -- Get mouse coordinates
  local mx, my = love.mouse.getPosition()

  -- Get attributes stored for the passed button
  local bX = b[1] * scale;
  local bY = b[2] * scale;
  local bW = b[3] * scale;
  local bH = b[4] * scale;

  -- Compare coordinates to see if mouse is inside button
  if mx > bX and mx < bX+bW and my > bY and my < bY+bH then
    return true
  end

  return false

end

function buttons:click()

  for i,b in ipairs(self) do

    -- If the mouse is on the current button...
    if buttons:mouseCheck(b) then

love.graphics.print("test", 10, 100)

      -- The button has been clicked

      if i == 1 then -- New Game button

        -- This is the state for new game sequence
 --       intro.state = 1
  --      intro.timer = 1
        buttons.message = ""
  --      soundManager:musicFade()
	gameState.room = "Intro"
 --       changeToMap("rmIntro")

      elseif i == 2 then -- Continue button

        -- This is the state for intro's load sequence
--        intro.state = 100
 --       intro.timer = 1.5
        buttons.message = ""
   --     soundManager:musicFade()
 --       changeToMap("rmIntro")

      elseif i == 3 then -- Sound button

        -- Toggle sound to be on/off
  --      soundOn = not soundOn
        if soundOn then
 --         soundManager:startMusic("menu")
        else
--          soundManager:musicFade()
        end

      elseif i == 4 then -- GitHub button

        -- Open the GitHub page for this game!
        love.system.openURL("https://github.com/kyleschaub/cavern")

      end

 --     soundManager:play("click")

    end

  end

end