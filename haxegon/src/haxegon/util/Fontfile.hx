package haxegon.util;

import openfl.Assets;
import openfl.text.Font;
import starling.text.*;
import starling.display.*;
import starling.textures.*;

class Fontfile {
	public function new(?_file:String) {
		if (_file == null) {
			type = "ttf";
			
			filename = "";
			typename = "Verdana";
			sizescale = 1;
		}else	if (Assets.exists("data/fonts/" + _file + "/" + _file + ".fnt")) {
			type = "bitmap";
			
			fontxml = Xml.parse(Assets.getText("data/fonts/" + _file + "/" + _file + ".fnt")).firstElement();
			typename = fontxml.elementsNamed("info").next().get("face");
			pngname = Xml.parse(Assets.getText("data/fonts/" + _file + "/" + _file + ".fnt")).firstElement()
			               .elementsNamed("pages").next().elementsNamed("page").next().get("file");
			if (pngname == null) {
				throw("ERROR: Bitmap font XML file \"" + _file + ".fnt\" does not reference a .png file.");
			}
			if (S.right(pngname, 4) == ".png") {
				pngname = S.left(pngname, pngname.length - 4);
			}
			sizescale = Std.parseInt(fontxml.elementsNamed("info").next().get("size"));
			
			fonttex = Texture.fromBitmapData(Assets.getBitmapData("data/fonts/" + _file + "/" + pngname + ".png"), false);
			bitmapfont = new BitmapFont(fonttex, fontxml);
			TextField.registerBitmapFont(bitmapfont);
		}else {
		  type = "ttf";
			
			filename = "data/fonts/" + _file + "/" + _file + ".ttf";
			try {
				font = Assets.getFont(filename);
				typename = font.fontName;
			}catch (e:Dynamic) {
				throw("ERROR: Cannot set font to \"" + _file + "\", no TTF or Bitmap Font found.");
			}
			sizescale = 1;
		}
	}
	
	public var typename:String;
	
	public var bitmapfont:BitmapFont;
	public var fontxml:Xml;
	public var fonttex:Texture;
	private var pngname:String;
	public var sizescale:Int;
	//public var fontimage:BitmapData;
	
	public var font:Font;
	public var filename:String;
	public var type:String;
}