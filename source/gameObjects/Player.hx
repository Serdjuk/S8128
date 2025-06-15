package gameObjects;

import flixel.math.FlxPoint;
import gameMode.PlayerInput;
import gameObjects.GameObject;

class Player extends GameObject implements IUndo
{
	var input = new PlayerInput();
	var playState:PlayState;

	public function new(playState:PlayState, x:Float, y:Float)
	{
		super(x, y);
		this.playState = playState;
		Core.getInstance().ensureAtlas();
		frames = Core.getInstance().atlas;
		frame = frames.getByName("player");
		pixelPerfectRender = true;
		pixelPerfectPosition = true;
		// makeGraphic(16, 16, FlxColor.BLUE);
	}

	override function update(elapsed:Float)
	{
		if (Core.getInstance().gamePause)
			return;
		if (x == X && y == Y)
		{
			var cellOffset = input.Move();
			if (CanMove(cellOffset))
			{
				if (!(cellOffset.x == 0 && cellOffset.y == 0))
				{
					lastOffset.set(cellOffset.x, cellOffset.y);
					playState.ClearCratesBOM();
					//	TODO если толкнуть коробку прижатую к стене после прижатия коробки к стене то, BOM сработает только на игрока.
				}
				var nextX = cellX + cellOffset.x;
				var nextY = cellY + cellOffset.y;
				var crate = OnCrate(nextX, nextY, layers);
				if (crate != null)
				{
					if (crate.CanMove(cellOffset))
					{
						if (crate.OnCrate(nextX + cellOffset.x, nextY + cellOffset.y, layers) == null)
						{
							crate.lastOffset.set(cellOffset.x, cellOffset.y);
							crate.MoveCrateOnLayer(cellOffset);
							crate.SetPosition(cellOffset);
							SetPosition(cellOffset);
						}
						else
						{
							lastOffset.set(0, 0);
						}
					}
					else
					{
						lastOffset.set(0, 0);
					}
				}
				else
				{
					SetPosition(cellOffset);
				}
			}
		}

		if (x == X && y == Y)
		{
			if (layers.IsLevelCompleted())
			{
				playState.SelectLevelMenu();
			}
		}

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
		SetPosition(lastOffset);
		lastOffset.set(0, 0);
	}
}
