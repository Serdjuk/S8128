package;

import data.SaveManager;
import flixel.FlxG;
import flixel.FlxState;
import gameMode.CameraSmooth;
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
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function SelectLevelMenu()
	{
		SaveManager.SaveCompletedLevel("" + currentLevelCratesCount, currentLevel);
		FlxG.switchState(LevelMenuState.new);
	}
}
