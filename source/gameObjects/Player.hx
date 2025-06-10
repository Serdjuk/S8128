package gameObjects;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import gameMode.PlayerInput;
import gameObjects.GameObject;
import mainMenu.MainMenuState;

class Player extends GameObject implements IUndo
{
	var input = new PlayerInput();
	var playState:PlayState;

	public function new(playState:PlayState, x:Float, y:Float)
	{
		super(x, y);
		this.playState = playState;
		makeGraphic(16, 16, FlxColor.BLUE);
	}

	override function update(elapsed:Float)
	{
		if (x == X && y == Y)
		{
			if (input.BackOneMove())
			{
				Undo();
			}
			else
			{
				var cellOffset = input.Move();
				if (CanMove(cellOffset))
				{
					var nextX = cellX + cellOffset.x;
					var nextY = cellY + cellOffset.y;
					var crate = OnCrate(nextX, nextY, layers);
					if (crate != null)
					{
						if (crate.CanMove(cellOffset) && crate.OnCrate(nextX + cellOffset.x, nextY + cellOffset.y, layers) == null)
						{
							crate.MoveCrateOnLayer(cellOffset);
							crate.SetPosition(cellOffset);
							SetPosition(cellOffset);
						}
					}
					else
					{
						SetPosition(cellOffset);
					}
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

	public function Undo() {}
}
