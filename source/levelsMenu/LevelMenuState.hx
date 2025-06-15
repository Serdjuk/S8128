package levelsMenu;

import data.SaveManager;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class LevelMenuState extends FlxState
{
	var cratesGroup:FlxGroup;
	var core:Core;
	var levelsCountByCrates:FlxText;
	var top:LevelMenuTop;
	var left:LevelMenuLeft;
	var hundred:LevelMenuHundred;
	var playButton:FlxButton;

	override public function create()
	{
		super.create();
		core = Core.getInstance();
		core.levelsManager.cratesPerLevel = SaveManager.get("selectedLevelCratesNumber", 0);
		core.levelsManager.hundredPerLevel = SaveManager.get("selectedLevelHandred", 0);
		core.levelsManager.numberPerHundred = SaveManager.get("selectedLevelNumber", 0);

		top = new LevelMenuTop();
		add(top);
		left = new LevelMenuLeft();
		add(left);
		hundred = new LevelMenuHundred();
		add(hundred);

		top.Init((s:String) ->
		{
			left.Recalculate();
		});
		left.Init((s:String) ->
		{
			hundred.Recalculate();
		});
		left.Recalculate();
		hundred.Init();
		hundred.Recalculate();
		var crates = core.levelsManager.CratesLevelsCount();
		crates.reverse();

		playButton = new FlxButton(0, 172, "Play", StartSelectedLevel);
		add(playButton);

		ButtonControl();
		//	todo  да тут всезде нада TODO пушо полный пиздец....
		for (crateNumber in crates)
		{
			SaveManager.LoadCompletedLevels(crateNumber);
		}

		top.UpdateLevelsCountByCrates();
		top.UpgradeAllCompletedLevels();
	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		ButtonControl();
	}

	function ButtonControl()
	{
		playButton.active = CanPlay();
		playButton.alpha = playButton.active ? 1.0 : 0.4;
	}

	function CanPlay():Bool
	{
		if (core.levelsManager.cratesPerLevel > 1 && core.levelsManager.cratesPerLevel < 7)
		{
			var levelsLengthByCrates = core.levelsManager.allLevels.get("" + top.core.levelsManager.cratesPerLevel).length;
			var selectedNumber = CalculateSelectedLevelId();
			// trace(top.selectedCrates + ", " + selectedNumber + ", " + levelsLengthByCrates);
			if (selectedNumber < levelsLengthByCrates)
			{
				return true;
			}
		}
		return false;
	}

	function CalculateSelectedLevelId():Int
	{
		return core.levelsManager.hundredPerLevel * 100 + core.levelsManager.numberPerHundred;
	}

	function StartSelectedLevel()
	{
		// SaveManager.set("selectedLevelCratesNumber", top.selectedCrates);
		// SaveManager.set("selectedLevelHandred", left.selectedHundred);
		// SaveManager.set("selectedLevelNumber", hundred.selectedNumber);
		FlxG.switchState(() -> new LevelInfo());
	}
}
