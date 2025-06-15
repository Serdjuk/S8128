package mainMenu;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import levelsMenu.LevelMenuState;

class MainMenuState extends FlxState
{
	var playButton:FlxButton;
	var me:FlxText;

	override public function create()
	{
		super.create();
		var group = new FlxSpriteGroup(maxSize = 2);
		playButton = new FlxButton(0, 0, "Play Game", ClickPlay);
		group.add(playButton);
		#if !html5
		var exitButton = new FlxButton(0, 24, "Exit", Exit);
		group.add(exitButton);
		#end
		Title();
		group.screenCenter();
		add(group);
		me = new FlxText(100, 116, 0, "Serdjuk 2025");
		me.color = FlxColor.ORANGE;
		group.add(me);
	}

	private function ClickPlay()
	{
		FlxG.switchState(LevelMenuState.new);
	}

	#if !html5
	function Exit()
	{
		openfl.Lib.current.stage.application.window.close();
	}
	#end

	function Title()
	{
		var sprite = new FlxSprite();
		sprite.loadGraphic("assets/images/title2.png");
		add(sprite);
	}
}
