package levelsMenu;

import data.SaveManager;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class LevelMenuTop extends LevelMenuButtonsGroup
{
	static var completedLevelColor = new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.GREEN), "$");

	var levelInfoLabel:FlxText;
	var completedInfoMarkup = new FlxTextFormat(0xFF00FF00);

	public var selectedCrates = 0;

	public function Init(action:(text:String) -> Void = null)
	{
		this.action = action;
		var startX = 5;
		var count = 2;
		for (x in 0...5)
		{
			var _x = (x + startX) * buttonSize + space * x;
			var _y = 2;
			var btn = new FlxSprite(_x, _y);
			btn.loadGraphic(sharedGraphic);
			btn.updateHitbox();
			btn.ID = count;
			buttons.add(btn);
			var t = new FlxText(_x, _y, 0, "" + count);
			add(t);
			count++;
		}

		var label = new FlxText(0, 4, 0, "Crates at level:", false);
		label.color = FlxColor.ORANGE;

		levelInfoLabel = new FlxText(176, 0);

		var allLelelsInfo = new FlxText(176, 8);
		var completed = 0;
		var number = core.levelsManager.LevelsCount();
		allLelelsInfo.applyMarkup("$" + completed + "$/" + number, [completedLevelColor]);
		add(levelInfoLabel);
		add(allLelelsInfo);
		add(label);
		buttons.members[selectedCrates - 2].alpha = 0.4;
	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed)
		{
			for (obj in buttons.members)
			{
				if (FlxG.mouse.overlaps(obj))
				{
					selectedCrates = obj.ID;
					SaveManager.set("selectedLevelCratesNumber", selectedCrates);
					UpdateLevelsCountByCrates();
					action("");
				}
			}
		}
	}

	function UpdateLevelsCountByCrates()
	{
		var cratesCount = "" + selectedCrates;
		var data = SaveManager.LoadCompletedLevels(cratesCount);
		var completed = Lambda.count(data, function(b) return b);
		var number = core.levelsManager.allLevels.get(cratesCount).length;
		levelInfoLabel.applyMarkup("$" + completed + "$/" + number, [completedLevelColor]);
	}
}
