package;

import flixel.FlxG;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIList;
import flixel.addons.ui.FlxUIText;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import haxe.ds.StringMap;
import levelsMenu.LevelInfo;
import levelsMenu.LevelMenuState;
import mainMenu.MainMenuState;

class GameMenu extends FlxGroup
{
	var handlers = new StringMap<() -> Void>();

	public function new()
	{
		super();
		handlers.set("Main Menu", MainMenu);
		handlers.set("Select Level", SelectLevel);
		handlers.set("Restart Level", RestartLevel);
		var startPos = 32;
		var step = 20;
		var id = 0;

		for (key => value in handlers.keyValueIterator())
		{
			var x = startPos;
			var y = id * step + startPos;

			var button = new FlxButton(x, y, key, value);
			button.makeGraphic(128, 16);
			button.color = FlxColor.WHITE;
			add(button);
			id++;
		}
	}



	function RestartLevel()
	{
		FlxG.switchState(() -> new LevelInfo());
	}

	function MainMenu()
	{
		FlxG.switchState(() -> new MainMenuState());
	}

	function SelectLevel()
	{
		FlxG.switchState(() -> new LevelMenuState());
	}
}
