package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.system.scaleModes.RatioScaleMode;
import levelsMenu.LevelMenuState;
import mainMenu.MainMenuState;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static inline var FPS = 60;

	public function new()
	{
		super();
		// addChild(new FlxGame(256, 192, MainMenuState, FPS, FPS, true));
		addChild(new FlxGame(256, 192, LevelMenuState, FPS, FPS, true));
		FlxG.camera.filtersEnabled = false;
		FlxG.fixedTimestep = true;
		FlxG.updateFramerate = FPS;
		FlxG.drawFramerate = FPS;
		FlxG.camera.antialiasing = false;
		FlxG.camera.pixelPerfectRender = true;
		FlxG.game.stage.quality = LOW;
		// FlxG.scaleMode = new RatioScaleMode(true);
		FlxG.scaleMode = new RatioScaleMode();
	}
}
