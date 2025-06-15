package levelsMenu;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class LevelInfo extends FlxState
{
	var label:FlxText;
	var core:Core;
	var canUpdate:Bool;

	var showTween:FlxTween;
	var hideTween:FlxTween;

	var screenTimer = 0.0;

	override function create()
	{
		super.create();
		canUpdate = true;
		core = Core.getInstance();
		var cratesPerLevel = core.levelsManager.cratesPerLevel;
		var hundredPerLevel = core.levelsManager.hundredPerLevel;
		var numberPerHundred = core.levelsManager.numberPerHundred;
		var author = core.levelsManager.GetLevelAuthor();
		var text = 'Level: ${cratesPerLevel}.${hundredPerLevel + 1}.${numberPerHundred + 1}
        \nAuthor: ${author}';
		label = new FlxText(256, 100, text);
        label.pixelPerfectRender = true;
        label.pixelPerfectPosition = true;
        label.antialiasing = false;
		showTween = FlxTween.tween(label, {x: 0}, 0.5, {ease: FlxEase.quadOut, type: ONESHOT});
		add(label);
	}

	override function update(elapsed:Float)
	{
		if (!canUpdate)
			return;
		super.update(elapsed);

		screenTimer += elapsed;
		if (screenTimer >= 5.0)
		{
			canUpdate = false;
			PreStartAnimatino();
			return;
		}

		if (FlxG.mouse.justPressed || FlxG.keys.justPressed.ANY)
		{
			canUpdate = false;
			showTween.cancel();
			PreStartAnimatino();
		}
	}

	function PreStartAnimatino()
	{
		FlxTween.tween(label, {x: 256}, 0.4, {
			ease: FlxEase.quadIn,
			type: ONESHOT,
			onComplete: tween ->
			{
				StartGame();
			},
		});
	}

	function StartGame()
	{
        core.gamePause = false;
		var levelId = core.levelsManager.hundredPerLevel * 100 + core.levelsManager.numberPerHundred;
		FlxG.switchState(() -> new PlayState(core.levelsManager.cratesPerLevel, levelId));
	}
}
