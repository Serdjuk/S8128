package;

import data.SaveManager;
import flixel.FlxG;
import flixel.FlxState;
import gameMode.CameraSmooth;
import gameObjects.Crate;
import gameObjects.IUndo;
import gameObjects.Player;
import levelsMenu.LevelMenuState;

class PlayState extends FlxState
{
	public static inline var STEP = 16;

	var cameraSmooth:CameraSmooth;
	var player:Player;
	var core:Core;
	var currentLevel:Int;
	var currentLevelCratesCount:Int;

	var undoObjects:Array<IUndo> = [];

	var gameMenu:GameMenu = null;

	public function new(crates:Int, levelNumber:Int)
	{
		super();
		currentLevelCratesCount = crates;
		currentLevel = levelNumber;
	}

	override public function create()
	{
		super.create();
		core = Core.getInstance();
		var level = core.GetLevelData(currentLevel, currentLevelCratesCount);

		var minX = 0;
		var maxX = level.Width;
		var minY = 0;
		var maxY = level.Height;

		FlxG.camera.setScrollBounds(minX, maxX * 16, minY, maxY * 16);

		var playerPosition = core.GetPlayerPosition(level);
		player = new Player(this, playerPosition.x, playerPosition.y);
		cameraSmooth = new CameraSmooth(player);
		Core.getInstance().DrawLevel(this, level);
		add(player);
		for (obj in members)
		{
			if (obj is IUndo)
			{
				undoObjects.push(cast(obj, IUndo));
			}
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		Input();
		Undo();
	}

	function Undo()
	{
		if (FlxG.keys.justPressed.SPACE)
		{
			for (obj in undoObjects)
			{
				obj.Undo();
			}
		}
	}

	public function ClearCratesBOM()
	{
		for (crate in undoObjects)
		{
			if (crate is Crate)
			{
				cast(crate, Crate).lastOffset.set(0, 0);
			}
		}
	}

	function Input()
	{
		if (FlxG.keys.justPressed.ESCAPE)
		{
			if (gameMenu == null)
			{
				core.gamePause = true;
				gameMenu = new GameMenu();
				add(gameMenu);
			}
			else
			{
				core.gamePause = false;
				if (gameMenu.exists)
				{
					remove(gameMenu); // Сначала удаляем из группы
				}
				gameMenu.destroy(); // Затем уничтожаем
				gameMenu = null;
			}
		}
	}

	public function SelectLevelMenu()
	{
		SaveManager.SaveCompletedLevel("" + currentLevelCratesCount, currentLevel);
		FlxG.switchState(LevelMenuState.new);
	}
}
