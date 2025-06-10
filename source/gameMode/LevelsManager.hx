package gameMode;

import data.gameData.LevelLayers;
import flixel.FlxState;
import flixel.math.FlxPoint;
import gameObjects.Crate;
import gameObjects.GameObject;
import gameObjects.TargetPoint;
import gameObjects.Wall;
import haxe.Exception;
import haxe.ds.StringMap;
import openfl.utils.Assets;

class LevelsManager
{
	public var allLevels:StringMap<Array<LevelModel>>;

	public var layers:LevelLayers;

	public function new()
	{
		var jsonString = Assets.getText("assets/data/levels/levels.json");
		allLevels = LevelModel.fromJson(jsonString);
		layers = new LevelLayers();
	}

	public function GetPlayerPoint(levelModel:LevelModel):FlxPoint
	{
		for (line in levelModel.Layout)
		{
			var x = line.indexOf("@");
			if (x >= 0)
			{
				var y = levelModel.Layout.indexOf(line);
				return FlxPoint.get(x, y);
			}

			var x = line.indexOf("+");
			if (x >= 0)
			{
				var y = levelModel.Layout.indexOf(line);
				return FlxPoint.get(x, y);
			}
		}

		throw new Exception("not has player on level map");
	}

	public function GetLevelData(levelId:Int, cratesCount:Int):LevelModel
	{
		var key = Std.string(cratesCount);
		if (allLevels.exists(key))
		{
			var levels = allLevels.get(key);
			if (levelId >= 0 && levelId < levels.length)
			{
				return allLevels.get(Std.string(cratesCount))[levelId];
			}
			else
			{
				throw new Exception("wrong array index: " + levels.length);
			}
		}
		else
		{
			throw new Exception("Key absent: " + key);
		}
	}

	public function DrawLevel(state:FlxState, levelModel:LevelModel)
	{
		layers.Clear(levelModel.Width, levelModel.Height);
		for (y in 0...levelModel.Height)
		{
			for (x in 0...levelModel.Width)
			{
				var symbol = levelModel.Layout[y].charAt(x);
				switch (symbol)
				{
					case ".", "*", "+":
						var sprite = AddObject(x, y, ["ui_heart_empty", "ui_heart_empty"], state, TargetPoint); //  target
						layers.AddPoint(x, y, sprite);
					default:
				}
			}
		}

		for (y in 0...levelModel.Height)
		{
			for (x in 0...levelModel.Width)
			{
				var symbol = levelModel.Layout[y].charAt(x);
				switch (symbol)
				{
					case "#":
						var sprite = AddObject(x, y, ["wall_mid", "wall_mid"], state, Wall); //  wall
						layers.AddWall(x, y, sprite);
					case "$":
						var sprite = AddObject(x, y, ["chest_mimic_open_anim_f1", "chest_mimic_open_anim_f1"], state, Crate); //  crate
						layers.AddCrate(x, y, sprite);
					case "*":
						var sprite = AddObject(x, y, ["chest_mimic_open_anim_f1", "chest_mimic_open_anim_f1"], state, Crate); //  crate
						layers.AddCrate(x, y, sprite);
					default:
				}
			}
		}
	}

	function AddObject<T:GameObject>(x:Int, y:Int, textureRegionId:Array<String>, state:FlxState, cls:Class<T>):T
	{
		Core.getInstance().ensureAtlas();
		var rndId = Math.floor(Math.random() * textureRegionId.length);
		var atlas = Core.getInstance().atlas;
		var go = Type.createInstance(cls, [x, y]);
		// sprite.active = false;
		// sprite.moves = false;
		// sprite.immovable = false;
		go.frames = atlas;
		go.frame = atlas.getByName(textureRegionId[rndId]);
		go.pixelPerfectRender = true;
		go.pixelPerfectPosition = true;
		state.add(go);
		return go;
	}

	public function LevelsCount():Int
	{
		var total = 0;
		for (array in allLevels)
		{
			total += array.length;
		}
		return total;
	}

	public function CratesLevelsCount():Array<String>
	{
		return [for (key in allLevels.keys()) key];
	}
}
//     Empty = ' ',
//     Wall = '#',
//     Player = '@',
//     PlayerOnTarget = '+',
//     Target = '.',
//     Crate = '$',
//     CrateOnTarget = '*'
