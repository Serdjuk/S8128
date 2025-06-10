package gameObjects;

import data.gameData.LevelLayers;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.text.FlxText;

class GameObject extends FlxSprite
{
	var X:Float;
	var Y:Float;

	var cellX:Int;
	var cellY:Int;

	var layers:LevelLayers;

	public function new(x:Float, y:Float)
	{
		layers = Core.getInstance().layers;
		cellX = Math.round(x);
		cellY = Math.round(y);
		X = cellX * PlayState.STEP;
		Y = cellY * PlayState.STEP;
		super(X, Y);
	}

	function MoveTowards(current:FlxPoint, target:FlxPoint, maxDistanceDelta:Float):FlxPoint
	{
		var delta = FlxPoint.get(target.x - current.x, target.y - current.y);
		var distance = delta.length;

		if (distance <= maxDistanceDelta || distance == 0)
		{
			delta.put();
			return FlxPoint.get(target.x, target.y);
		}

		delta.normalize();
		delta.scale(maxDistanceDelta);
		var result = FlxPoint.get(current.x + delta.x, current.y + delta.y);
		delta.put();
		return result;
	}

	public function SetPosition(offset:FlxPoint)
	{
		cellX += Math.round(offset.x);
		cellY += Math.round(offset.y);
		X = cellX * PlayState.STEP;
		Y = cellY * PlayState.STEP;
	}

	public function CanMove(offset:FlxPoint):Bool
	{
		var nextX = cellX + offset.x;
		var nextY = cellY + offset.y;
		if (!InBounds(nextX, nextY, layers) || OnWall(nextX, nextY, layers))
			return false;

		return true;
	}

	function OnCrate(x:Float, y:Float, layers:LevelLayers):GameObject
	{
		return layers.OnCrate(x, y);
	}

	function OnWall(x:Float, y:Float, layers:LevelLayers):Bool
	{
		return layers.OnWall(x, y);
	}

	function InBounds(x:Float, y:Float, layers:LevelLayers):Bool
	{
		return x >= 0 && x < layers.width && y >= 0 && y < layers.height;
	}

	public function MoveCrateOnLayer(offset:FlxPoint)
	{
		var x = Math.round(offset.x) + cellX;
		var y = Math.round(offset.y) + cellY;
		layers.crates[y][x] = layers.crates[cellY][cellX];
		layers.crates[cellY][cellX] = null;
	}
}
