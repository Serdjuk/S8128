package gameMode;

import data.gameData.LevelLayers;
import flixel.FlxG;
import flixel.math.FlxPoint;
import gameObjects.GameObject;
import lime.math.Vector2;
import openfl.ui.Keyboard;

class PlayerInput
{
	var upKeys = [Keyboard.UP, Keyboard.W];
	var downKeys = [Keyboard.DOWN, Keyboard.S];
	var leftKeys = [Keyboard.LEFT, Keyboard.A];
	var rightKeys = [Keyboard.RIGHT, Keyboard.D];
	var bomKeys = [Keyboard.SPACE];
	var layers:LevelLayers;

	public function new()
	{
		layers = Core.getInstance().layers;
	}

	public function BackOneMove()
	{
		return FlxG.keys.anyJustPressed(bomKeys);
	}

	public function Move():FlxPoint
	{
		var up = FlxG.keys.anyJustPressed(upKeys);
		var down = FlxG.keys.anyJustPressed(downKeys);
		var left = FlxG.keys.anyJustPressed(leftKeys);
		var right = FlxG.keys.anyJustPressed(rightKeys);


		if (up && down)
		{
			up = down = false;
		}
		if (left && right)
		{
			left = right = false;
		}

		if (up)
			return FlxPoint.get(0, -1);
		if (down)
			return FlxPoint.get(0, 1);
		if (left)
			return FlxPoint.get(-1, 0);
		if (right)
			return FlxPoint.get(1, 0);

		return FlxPoint.get(0, 0);
	}

	function OnCrate(x:Int, y:Int):GameObject
	{
		return layers.OnCrate(x, y);
	}

	function OnWall(x:Int, y:Int):Bool
	{
		return layers.OnWall(x, y);
	}

	function InBounds(x:Int, y:Int):Bool
	{
		return x >= 0 && x < layers.width && y >= 0 && y < layers.height;
	}
}
