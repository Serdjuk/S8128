package mainMenu;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import levelsMenu.LevelMenuState;

class MainMenuState extends FlxState
{
	var playButton:FlxButton;
	var levelCountLabel:FlxText;

	override public function create()
	{
		super.create();
		var group = new FlxSpriteGroup(maxSize = 2);
		playButton = new FlxButton(0, 0, "Play Game", ClickPlay);
		var playButton2 = new FlxButton(0, 24, "Options", ClickPlay);
		var playButton3 = new FlxButton(0, 48, "Options", ClickPlay);
		group.add(playButton);
		group.add(playButton2);
		group.add(playButton3);

		group.screenCenter();
		add(group);

		levelCountLabel = new FlxText(0, 0);
		levelCountLabel.text = "levels: " + LevelsCount();
		add(levelCountLabel);
	}

	private function ClickPlay()
	{
		FlxG.switchState(LevelMenuState.new);
	}

	function LevelsCount():Int
	{
		return Core.getInstance().levelsManager.LevelsCount();
	}
}
