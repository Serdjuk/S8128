package levelsMenu;

import data.SaveManager;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class LevelMenuHundred extends LevelMenuButtonsGroup
{
	// public var selectedNumber = 0;

	var textGroup:FlxGroup;

	public function Init(action:(text:String) -> Void = null)
	{
		this.action = action;
		textGroup = new FlxGroup();
		Fill();
	}

	public function Fill()
	{
		// selectedNumber = SaveManager.get("selectedLevelNumber", 0);
		var startX = 5.4;
		var startY = 1.4;
		var count = 0;

		for (y in 0...10)
		{
			for (x in 0...10)
			{
				var _x = (x + startX) * buttonSize + space * x;
				var _y = (y + startY) * buttonSize + space * y;
				var btn = new FlxSprite(_x, _y);
				btn.ID = count;
				btn.loadGraphic(sharedGraphic);
				btn.updateHitbox();
				buttons.add(btn);
				if (count == core.levelsManager.numberPerHundred)
					btn.alpha = 0.4;
				var t = new FlxText(_x, _y, 0, "" + (count + 1));
				textGroup.add(t);
				count++;
			}
		}
		add(textGroup);
	}

	public function Recalculate()
	{
		var selectedCrates:Int = cast SaveManager.get("selectedLevelCratesNumber", 2);
		var selectedHundred:Int = (cast SaveManager.get("selectedLevelHandred", 0) * 100);
		var shCopy = selectedHundred;
		var crates = "" + selectedCrates;
		var length = core.levelsManager.allLevels.get(crates).length;
		var data = SaveManager.LoadCompletedLevels(crates);

		var textCount = 0;
		for (obj in buttons.members)
		{
			if (selectedHundred < length)
			{
				if (data[selectedHundred])
				{
					obj.color = FlxColor.GREEN;
				}
				else
				{
					obj.color = FlxColor.WHITE;
				}
				obj.visible = true;
				textGroup.members[textCount].visible = true;
			}
			else
			{
				obj.visible = false;
				textGroup.members[textCount].visible = false;
			}
			selectedHundred++;
			textCount++;
		}

		// trace("recalc: " + selectedCrates + " | " + selectedNumber + " | " + length + " | " + buttons.members.length);
		if (core.levelsManager.numberPerHundred + shCopy < length)
		{
			buttons.members[core.levelsManager.numberPerHundred].alpha = 0.4;
		}
	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.mouse.justPressed)
		{
			for (sprite in buttons.members)
			{
				if (sprite.visible && FlxG.mouse.overlaps(sprite))
				{
					core.levelsManager.numberPerHundred = sprite.ID;
					buttons.members[core.levelsManager.numberPerHundred].alpha = 0.4;
					SaveManager.set("selectedLevelNumber", core.levelsManager.numberPerHundred);
				}
			}
			Recalculate();
			for (obj in buttons.members)
			{
				obj.alpha = 1.0;
			}
			buttons.members[core.levelsManager.numberPerHundred].alpha = 0.4;
		}
	}
}
