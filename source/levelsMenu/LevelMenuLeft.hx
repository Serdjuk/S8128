package levelsMenu;

import data.SaveManager;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class LevelMenuLeft extends LevelMenuButtonsGroup
{
	public var selectedHundred = 0;

	var textGroup:FlxGroup;

	public function Init(action:(text:String) -> Void = null)
	{
		this.action = action;
		textGroup = new FlxGroup();
		this.action = action;
		var startX = 1;
		var startY = 1.4;
		var count = 1;
		for (y in 0...9)
		{
			for (x in 0...3)
			{
				var _x = (x + startX) * buttonSize + space * x;
				var _y = (y + startY) * buttonSize + space * y;
				var btn = new FlxSprite(_x, _y);
				btn.ID = count - 1;
				btn.loadGraphic(sharedGraphic);
				btn.updateHitbox();
				buttons.add(btn);
				var t = new FlxText(_x, _y, 0, "" + count);
				textGroup.add(t);
				count++;
			}
		}
		add(textGroup);
		// buttons.members[selectedHundred].alpha = 0.4;
	}

	public function Recalculate()
	{
		var selectedCrates:Int = cast SaveManager.get("selectedLevelCratesNumber", 2);
	
		var crates = "" + selectedCrates;
		var length = Math.floor(core.levelsManager.allLevels.get(crates).length / 100);

		var count = 0;
		trace("length: " + length);
		for (obj in buttons.members)
		{
			if (count <= length)
			{
				obj.visible = true;
				textGroup.members[count].visible = true;
				buttons.members[selectedHundred].alpha = 0.4;
			}
			else
			{
				obj.visible = false;
				textGroup.members[count].visible = false;
			}
			count++;
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
					selectedHundred = sprite.ID;
					SaveManager.set("selectedLevelHandred", selectedHundred);
					action("");
				}
			}
		}
	}
}
