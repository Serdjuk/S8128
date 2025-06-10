package gameMode;

import haxe.Json;
import haxe.ds.StringMap;

class LevelModel {
    public var Layout:Array<String>;
    public var Author:String;
    public var Crates:Int;
    public var Height:Int;
    public var Width:Int;

    public function new() {
        Layout = [];
        Author = "";
        Crates = 0;
        Height = 0;
        Width = 0;
    }

    public static function fromJson(jsonString:String):StringMap<Array<LevelModel>> {
        var result = new StringMap<Array<LevelModel>>();
        
        if (jsonString == null || jsonString == "") {
            trace("Ошибка: JSON-строка пуста или null");
            return result;
        }

        try {
            // Парсим JSON как Dynamic объект
            var jsonData:Dynamic = Json.parse(jsonString);
            
            // Проверяем, что jsonData — объект
            if (!Reflect.isObject(jsonData)) {
                trace("Ошибка: JSON не является объектом, получено: " + Type.typeof(jsonData));
                return result;
            }

            // Выводим JSON для отладки
            // trace("JSON-данные: " + Json.stringify(jsonData, null, "  "));

            // Перебираем ключи объекта
            for (key in Reflect.fields(jsonData)) {
                var levelArray:Dynamic = Reflect.field(jsonData, key);
                
                // Проверяем, что levelArray — массив
                if (!Std.isOfType(levelArray, Array)) {
                    trace("Ошибка: Данные для ключа " + key + " не являются массивом, получено: " + Type.typeof(levelArray));
                    continue;
                }

                var levelModelList = new Array<LevelModel>();
                for (item in (levelArray : Array<Dynamic>)) {
                    // Проверяем наличие всех полей
                    if (!Reflect.hasField(item, "Layout") || !Reflect.hasField(item, "Author") ||
                        !Reflect.hasField(item, "Crates") || !Reflect.hasField(item, "Height") ||
                        !Reflect.hasField(item, "Width")) {
                        trace("Ошибка: В объекте для ключа " + key + " отсутствуют необходимые поля");
                        continue;
                    }

                    var lm = new LevelModel();
                    lm.Layout = item.Layout;
                    lm.Author = item.Author;
                    lm.Crates = Math.round(item.Crates); // Преобразуем в Int
                    lm.Height = Math.round(item.Height);
                    lm.Width = Math.round(item.Width);
                    levelModelList.push(lm);
                }
                
                result.set(key, levelModelList);
            }
        } catch (e:Dynamic) {
            trace("Ошибка парсинга JSON: " + e);
            trace("Стек вызовов: " + haxe.CallStack.toString(haxe.CallStack.exceptionStack()));
        }
        
        return result;
    }
}