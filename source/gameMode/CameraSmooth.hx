package gameMode;

import flixel.FlxG;
import gameObjects.Player;

class CameraSmooth
{
	var offsetX:Float;
	var offsetY:Float;

	public function new(target:Player)
	{
		// FlxG.camera.setScrollBounds(0, width, 0, height);

		// offsetX = -width / 2;
		// offsetY = -height / 2;

		// trace("offsetX: " + offsetX);
		// trace("offsetY: " + offsetY);
		// if (offsetX > 0)
		// 	FlxG.camera.scroll.x = offsetX;
		// if (offsetY > 0)
		// 	FlxG.camera.scroll.y = offsetY;

		FlxG.camera.follow(target, TOPDOWN, 0.1);
	}

	// public function Update(player:Player)
	// {
	// 	// var targetX = player.x - FlxG.width / 2 + player.width / 2 - offsetX;
	// 	// var targetY = player.y - FlxG.height / 2 + player.height / 2 - offsetY;
	// 	// var lerpAmount = 1 - Math.pow(0.95, Main.FPS * (1 / Main.FPS));
	// 	// FlxG.camera.scroll.x = FlxG.camera.scroll.x + (targetX - FlxG.camera.scroll.x) * lerpAmount;
	// 	// FlxG.camera.scroll.y = FlxG.camera.scroll.y + (targetY - FlxG.camera.scroll.y) * lerpAmount;

	// 	// FlxG.camera.scroll.x = Math.round(FlxG.camera.scroll.x);
	// 	// FlxG.camera.scroll.y = Math.round(FlxG.camera.scroll.y);
	// 	// FlxG.camera.x = offsetX;
	// 	// FlxG.camera.y = offsetY;
	// }

	public function SetScrollBounds(minX:Int, maxX:Int, minY:Int, maxY:Int,)
	{
		FlxG.camera.setScrollBounds(minX, maxX, minY, maxY);
	}
}
