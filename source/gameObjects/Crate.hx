package gameObjects;

import flixel.math.FlxPoint;

class Crate extends GameObject implements IUndo
{

	public function new(x:Float, y:Float)
	{
		super(x, y);
	}

	override function update(elapsed:Float)
	{
		if (x == X && y == Y)
		{
			Undo();
		}

		var point = MoveTowards(FlxPoint.get(x, y), FlxPoint.get(X, Y), Main.FPS * elapsed);
		x = Math.round(point.x);
		y = Math.round(point.y);
		super.update(elapsed);
	}

	public function Undo() {}
}
