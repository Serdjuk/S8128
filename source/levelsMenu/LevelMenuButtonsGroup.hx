package levelsMenu;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import openfl.display.BitmapData;

abstract class LevelMenuButtonsGroup extends FlxGroup
{
	var buttons:FlxSpriteGroup;
	var sharedGraphic:FlxGraphic;

	public var action:(text:String) -> Void;
	public var core:Core;
	public var buttonSize = 16;
	public var space = 1;

	public function new()
	{
		super();
		core = Core.getInstance();
		var bmd = new BitmapData(buttonSize, buttonSize, false, FlxColor.GRAY);
		sharedGraphic = FlxGraphic.fromBitmapData(bmd);
		buttons = new FlxSpriteGroup();
		add(buttons);
	}

	public abstract function Init(action:(text:String) -> Void = null):Void;

	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.mouse.justPressed)
		{
			var selected:FlxSprite = null;
			for (sprite in buttons.members)
			{
				if (sprite.visible && FlxG.mouse.overlaps(sprite))
				{
					sprite.alpha = 0.4;
					selected = sprite;
				}
			}

			for (sprite in buttons.members)
			{
				if (sprite.visible && selected != null && selected != sprite)
				{
					sprite.alpha = 1.0;
				}
			}
		}
	}
}
