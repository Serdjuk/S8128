package;

import haxe.io.Bytes;
import haxe.io.Path;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

#if disable_preloader_assets
@:dox(hide) class ManifestResources {
	public static var preloadLibraries:Array<Dynamic>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;

	public static function init (config:Dynamic):Void {
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
	}
}
#else
@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

			if(!StringTools.endsWith (rootPath, "/")) {

				rootPath += "/";

			}

		}

		if (rootPath == null) {

			#if (ios || tvos || webassembly)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif (console || sys)
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_zx_spectrum_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		data = '{"name":null,"assets":"aoy4:pathy34:assets%2Fdata%2Fdata-goes-here.txty4:sizezy4:typey4:TEXTy2:idR1y7:preloadtgoR0y36:assets%2Fdata%2Flevels%2Flevels.jsonR2i2761968R3R4R5R7R6tgoR0y35:assets%2Ffonts%2Frunnable-hiero.jarR2i22656311R3y6:BINARYR5R8R6tgoR0y39:assets%2Ffonts%2Fzx-spectrum-bitmap.pngR2i1243R3y5:IMAGER5R10R6tgoR2i14772R3y4:FONTy9:classNamey37:__ASSET__assets_fonts_zx_spectrum_ttfR5y32:assets%2Ffonts%2Fzx-spectrum.ttfR6tgoR0y23:assets%2Ffonts%2Fzx.fntR2i10901R3R4R5R16R6tgoR0y23:assets%2Ffonts%2Fzx.pngR2i2591R3R11R5R17R6tgoR0y37:assets%2Fimages%2Fatlas%2Fatlas.atlasR2i39604R3R4R5R18R6tgoR0y35:assets%2Fimages%2Fatlas%2Fatlas.pngR2i61847R3R11R5R19R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R20R6tgoR0y52:assets%2Fimages%2FPuzzlePack_1.0%2Finteractables.pngR2i2155R3R11R5R21R6tgoR0y44:assets%2Fimages%2FPuzzlePack_1.0%2Fitems.pngR2i1021R3R11R5R22R6tgoR0y56:assets%2Fimages%2FPuzzlePack_1.0%2FMockup%2Fmockup_1.pngR2i521R3R11R5R23R6tgoR0y56:assets%2Fimages%2FPuzzlePack_1.0%2FMockup%2Fmockup_2.pngR2i936R3R11R5R24R6tgoR0y56:assets%2Fimages%2FPuzzlePack_1.0%2FMockup%2Fmockup_3.pngR2i1455R3R11R5R25R6tgoR0y56:assets%2Fimages%2FPuzzlePack_1.0%2FMockup%2Fmockup_4.pngR2i1469R3R11R5R26R6tgoR0y56:assets%2Fimages%2FPuzzlePack_1.0%2FMockup%2Fmockup_5.pngR2i753R3R11R5R27R6tgoR0y59:assets%2Fimages%2FPuzzlePack_1.0%2FMockup%2Fmockup_full.pngR2i3552R3R11R5R28R6tgoR0y44:assets%2Fimages%2FPuzzlePack_1.0%2Fprops.pngR2i955R3R11R5R29R6tgoR0y45:assets%2Fimages%2FPuzzlePack_1.0%2FREADME.txtR2i745R3R4R5R30R6tgoR0y50:assets%2Fimages%2FPuzzlePack_1.0%2FwallsFloors.pngR2i523R3R11R5R31R6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R32R6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R33R6tgoR0y14:fonts%2Fzx.fntR2i10901R3R4R5R34R6tgoR0y30:fonts%2Fzx-spectrum-bitmap.pngR2i1243R3R11R5R35R6tgoR0y14:fonts%2Fzx.pngR2i2591R3R11R5R36R6tgoR2i8220R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3y9:pathGroupaR38y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R37R5y28:flixel%2Fsounds%2Fflixel.mp3R39aR41y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i6840R3y5:SOUNDR5R40R39aR38R40hgoR2i33629R3R43R5R42R39aR41R42hgoR2i15744R3R12R13y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R12R13y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i222R3R11R5R48R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i484R3R11R5R49R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

	}


}

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_levels_levels_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_runnable_hiero_jar extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_zx_spectrum_bitmap_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_zx_spectrum_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_zx_fnt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_zx_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_atlas_atlas_atlas extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_atlas_atlas_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_interactables_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_items_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_mockup_mockup_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_mockup_mockup_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_mockup_mockup_3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_mockup_mockup_4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_mockup_mockup_5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_mockup_mockup_full_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_props_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_readme_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_wallsfloors_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__fonts_zx_fnt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__fonts_zx_spectrum_bitmap_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__fonts_zx_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/levels.json") @:noCompletion #if display private #end class __ASSET__assets_data_levels_levels_json extends haxe.io.Bytes {}
@:keep @:file("assets/fonts/runnable-hiero.jar") @:noCompletion #if display private #end class __ASSET__assets_fonts_runnable_hiero_jar extends haxe.io.Bytes {}
@:keep @:image("assets/fonts/zx-spectrum-bitmap.png") @:noCompletion #if display private #end class __ASSET__assets_fonts_zx_spectrum_bitmap_png extends lime.graphics.Image {}
@:keep @:font("export/html5/obj/webfont/zx-spectrum.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_zx_spectrum_ttf extends lime.text.Font {}
@:keep @:file("assets/fonts/zx.fnt") @:noCompletion #if display private #end class __ASSET__assets_fonts_zx_fnt extends haxe.io.Bytes {}
@:keep @:image("assets/fonts/zx.png") @:noCompletion #if display private #end class __ASSET__assets_fonts_zx_png extends lime.graphics.Image {}
@:keep @:file("assets/images/atlas/atlas.atlas") @:noCompletion #if display private #end class __ASSET__assets_images_atlas_atlas_atlas extends haxe.io.Bytes {}
@:keep @:image("assets/images/atlas/atlas.png") @:noCompletion #if display private #end class __ASSET__assets_images_atlas_atlas_png extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/PuzzlePack_1.0/interactables.png") @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_interactables_png extends lime.graphics.Image {}
@:keep @:image("assets/images/PuzzlePack_1.0/items.png") @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_items_png extends lime.graphics.Image {}
@:keep @:image("assets/images/PuzzlePack_1.0/Mockup/mockup_1.png") @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_mockup_mockup_1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/PuzzlePack_1.0/Mockup/mockup_2.png") @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_mockup_mockup_2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/PuzzlePack_1.0/Mockup/mockup_3.png") @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_mockup_mockup_3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/PuzzlePack_1.0/Mockup/mockup_4.png") @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_mockup_mockup_4_png extends lime.graphics.Image {}
@:keep @:image("assets/images/PuzzlePack_1.0/Mockup/mockup_5.png") @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_mockup_mockup_5_png extends lime.graphics.Image {}
@:keep @:image("assets/images/PuzzlePack_1.0/Mockup/mockup_full.png") @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_mockup_mockup_full_png extends lime.graphics.Image {}
@:keep @:image("assets/images/PuzzlePack_1.0/props.png") @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_props_png extends lime.graphics.Image {}
@:keep @:file("assets/images/PuzzlePack_1.0/README.txt") @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_readme_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/PuzzlePack_1.0/wallsFloors.png") @:noCompletion #if display private #end class __ASSET__assets_images_puzzlepack_1_0_wallsfloors_png extends lime.graphics.Image {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/fonts/zx.fnt") @:noCompletion #if display private #end class __ASSET__fonts_zx_fnt extends haxe.io.Bytes {}
@:keep @:image("assets/fonts/zx-spectrum-bitmap.png") @:noCompletion #if display private #end class __ASSET__fonts_zx_spectrum_bitmap_png extends lime.graphics.Image {}
@:keep @:image("assets/fonts/zx.png") @:noCompletion #if display private #end class __ASSET__fonts_zx_png extends lime.graphics.Image {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/6,1,0/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/6,1,0/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/6,1,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/6,1,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/6,1,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/6,1,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_fonts_zx_spectrum_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_zx_spectrum_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/zx-spectrum"; #else ascender = 4096; descender = -585; height = 4681; numGlyphs = 115; underlinePosition = 307; underlineThickness = 204; unitsPerEM = 4096; #end name = "ZX Spectrum Regular"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_fonts_zx_spectrum_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_zx_spectrum_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_zx_spectrum_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_fonts_zx_spectrum_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_zx_spectrum_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_zx_spectrum_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end