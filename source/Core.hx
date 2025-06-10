package;

import data.SaveManager;
import data.gameData.LevelLayers;
import flixel.FlxG;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.util.FlxSave;
import gameMode.LevelModel;
import gameMode.LevelsManager;

class Core
{
	private static var instance:Core = null;

	public var levelsManager:LevelsManager;
	public var random:FlxRandom;
	public var atlas:FlxAtlasFrames;
	public var layers:LevelLayers;

	var atlasGraphic:FlxGraphic;
	static var saveName = "sogress";
	private function new()
	{
		SaveManager.init();
		random = new FlxRandom(892381);
		levelsManager = new LevelsManager();
		layers = levelsManager.layers;
		LoadAtlas();
		// FlxAssets.FONT_DEFAULT = "zx.fnt";
	}

	// Метод для получения экземпляра синглтона
	public static function getInstance():Core
	{
		if (instance == null)
		{
			instance = new Core();
		}
		return instance;
	}

	function LoadAtlas()
	{
		// atlas = FlxAtlasFrames.fromLibGdx("assets/images/atlas/atlas.png", "assets/images/atlas/atlas.atlas");
		atlasGraphic = FlxG.bitmap.add("assets/images/atlas/atlas.png", true, "atlas");
        if (atlasGraphic == null) trace("Текстура atlas.png не загрузилась!");
        atlas = FlxAtlasFrames.fromLibGdx(atlasGraphic, "assets/images/atlas/atlas.atlas");
        if (atlas == null) trace("Атлас не создан!");
	}

	public function ensureAtlas():Void {
        if (atlas == null || atlasGraphic == null || atlasGraphic.destroyOnNoUse) LoadAtlas();
    }

	public function GetLevelData(levelId:Int, cratesCount:Int):LevelModel
	{
		return levelsManager.GetLevelData(levelId, cratesCount);
	}

	public function DrawLevel(state:FlxState, levelModel:LevelModel)
	{
		levelsManager.DrawLevel(state, levelModel);
	}

	public function GetPlayerPosition(levelModel:LevelModel):FlxPoint
	{
		return levelsManager.GetPlayerPoint(levelModel);
	}

}