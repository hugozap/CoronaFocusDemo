
local storyboard = require("storyboard")
local scene = storyboard.newScene()
local normal -- normal image
local mask
local lens

function scene:createScene()

	local view = self.view
	local blurred = display.newImageRect( view, "blurred.png", 1024, 748 )
	blurred.anchorX = 0
	blurred.anchorY = 0

	normal = display.newImageRect( view, "normal.png", 1024, 748 )

	normal.x = display.contentCenterX
	normal.y = display.contentCenterY

	lens = display.newImageRect( view, "lens.png", 390, 390 )
	lens.x = display.contentCenterX
	lens.y = display.contentCenterY

	mask = graphics.newMask( "mask.png" )
	normal:setMask(mask)
	

	blurred:addEventListener( "touch", function(ev)

		if ev.phase == "began" then
			normal.hasFocus = true
			display.getCurrentStage():setFocus(ev.target)
			--normal.alpha = 1
			lens.alpha = 1
			lens.x = ev.x 
			lens.y = ev.y 

			normal.maskX = ev.x - display.contentCenterX
			normal.maskY = ev.y - display.contentCenterY
			

	
		elseif normal.hasFocus then

			if ev.phase == "moved" then
				normal.maskX = ev.x - display.contentCenterX
				normal.maskY = ev.y - display.contentCenterY
				print("maskX:" .. normal.maskX)

				lens.x = ev.x
				lens.y = ev.y
				print("move")
			elseif ev.phase == "ended" then
				normal.hasFocus = false
				display.getCurrentStage():setFocus(nil)
			end
		end

	end )
	print("yeah")
end

function scene:enterFrame()

end

scene:addEventListener( "createScene", scene )
Runtime:addEventListener( "enterFrame", scene )


return scene