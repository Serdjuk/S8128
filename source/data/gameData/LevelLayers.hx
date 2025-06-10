package data.gameData;

import gameObjects.GameObject;

class LevelLayers
{
	var walls:Array<Array<GameObject>>;
	var points:Array<Array<GameObject>>;

	public var crates:Array<Array<GameObject>>;

	public var width:Int;
	public var height:Int;

	public function new() {}

	public function Clear(width:Int, height:Int)
	{
		this.width = width;
		this.height = height;
		walls = [for (y in 0...height) [for (x in 0...width) null]];
		points = [for (y in 0...height) [for (x in 0...width) null]];
		crates = [for (y in 0...height) [for (x in 0...width) null]];
	}

	public function AddWall(x:Int, y:Int, sprite:GameObject)
	{
		walls[y][x] = sprite;
	}

	public function AddPoint(x:Int, y:Int, sprite:GameObject)
	{
		points[y][x] = sprite;
	}

	public function AddCrate(x:Int, y:Int, sprite:GameObject)
	{
		crates[y][x] = sprite;
	}

	public function OnWall(x:Float, y:Float):Bool
	{
		return walls[Math.round(y)][Math.round(x)] != null;
	}

	public function OnCrate(x:Float, y:Float):GameObject
	{
		return crates[Math.round(y)][Math.round(x)];
	}

	public function IsLevelCompleted()
	{
		for (y in 0...height)
		{
			for (x in 0...width)
			{
				var crate = crates[y][x];
				if (crate != null)
				{
					if (points[y][x] == null)
						return false;
				}
			}
		}
		return true;
	}
}
