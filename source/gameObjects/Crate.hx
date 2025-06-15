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
		var point = MoveTowards(FlxPoint.get(x, y), FlxPoint.get(X, Y), Main.FPS * elapsed);
		x = Math.round(point.x);
		y = Math.round(point.y);
		super.update(elapsed);
	}

	public function Undo()
	{
		if (lastOffset.x == 0 && lastOffset.y == 0)
			return;
		lastOffset.x = -lastOffset.x;
		lastOffset.y = -lastOffset.y;
		MoveCrateOnLayer(lastOffset);
		SetPosition(lastOffset);
		lastOffset.set(0, 0);
	}
}
