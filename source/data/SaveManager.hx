package data;

import flixel.util.FlxSave;
import haxe.crypto.Base64;
import haxe.ds.StringMap;
import haxe.io.Bytes;
import haxe.io.BytesBuffer;

class SaveManager
{
	public static var save:FlxSave;
	public static var data:Dynamic;
	public static var completedeLevels:StringMap<Array<Bool>> = new StringMap<Array<Bool>>();

	public static function init():Void
	{
		save = new FlxSave();
		if (save.bind("sogress"))
		{
			// save.erase();
			if (save.data == null || Reflect.fields(save.data).length == 0)
			{
				save.mergeData({
					volume: 1.0,
					selectedLevelCratesNumber: 2,
					selectedLevelHandred: 0,
					selectedLevelNumber: 0,
				});
				save.flush();
			}

			data = save.data;
		}
		else
		{
			trace("Не удалось привязать сохранение.");
		}
	}

	public static function set(key:String, value:Dynamic):Void
	{
		Reflect.setField(data, key, value);
		save.flush();
	}

	public static function get(key:String, def:Dynamic = null):Dynamic
	{
		return Reflect.hasField(data, key) ? Reflect.field(data, key) : def;
	}

	// key = количество коробок на уровя
	public static function SaveCompletedLevel(key:String, completedLevelId:Int):Void
	{
		var values:Array<Bool> = [];
		if (completedeLevels.exists(key))
		{
			values = completedeLevels.get(key);
		}
		else
		{
			values = new Array<Bool>();
			completedeLevels.set(key, values);
		}

		values[completedLevelId] = true;

		var buffer = new BytesBuffer();
		var byte = 0;
		var count = 0;

		for (i in 0...values.length)
		{
			if (values[i])
				byte |= (1 << (i % 8));
			count++;

			if (count == 8 || i == values.length - 1)
			{
				buffer.addByte(byte);
				byte = 0;
				count = 0;
			}
		}

		var encoded = Base64.encode(buffer.getBytes());
		trace("saved: " + encoded);
		set(key, encoded); // сохранить строку по заданному ключу
	}

	public static function LoadCompletedLevels(key:String):Array<Bool>
	{
		if (completedeLevels.exists(key))
		{
			return completedeLevels.get(key);
		}

		var result:Array<Bool> = [];
		var allLevels = Core.getInstance().levelsManager.allLevels;
		var expectedLength = allLevels.get(key).length;

		if (!Reflect.hasField(data, key))
		{
			// Вернуть массив нужной длины с false, если ключа нет
			for (i in 0...expectedLength)
				result.push(false);
            completedeLevels.set(key, result);
			return result;
		}

		var encoded:String = Reflect.field(data, key);
		// trace("loaded: " + encoded);
		var bytes = Base64.decode(encoded);

		for (i in 0...expectedLength)
		{
			var byte = bytes.get(i >> 3); // i / 8
			var bit = (byte >> (i % 8)) & 1;
			result.push(bit == 1);
		}
		completedeLevels.set(key, result);
		return result;
	}
}
