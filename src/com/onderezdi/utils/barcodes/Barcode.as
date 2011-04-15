package com.onderezdi.utils.barcodes
{
	import flash.display.Sprite;
	/**
	$(CBI)* ...
	$(CBI)* @author Sentinel
	$(CBI)*/
	public class Barcode extends Sprite
	{
		
		private var _barcodeText:String;
		private var _type:String;
		private var _barcodeHeight:Number;
		private var currentBarcode:BarcodeBase;
		private var _barcodeColor:uint;
		private var _barThickness:Number;
		private var _addQuietZone:Boolean;
		
		
		public function Barcode(bText:String="1234567890", bType:String=BarcodeType.CODE39, h:Number=50) 
		{
			_barcodeText = barcodeText;
			type = bType;
			_barcodeHeight = h;
			_barcodeColor = 0x000000;
			_barThickness = 1;
		}
		
		public function get barcodeText():String { return _barcodeText; }
		
		public function set barcodeText(value:String):void 
		{
			_barcodeText = value;
		}
		
		public function get type():String { return _type; }
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get barcodeColor():uint { return _barcodeColor; }
		
		public function set barcodeColor(value:uint):void 
		{
			_barcodeColor = value;
		}
		
		public function get addQuietZone():Boolean { return _addQuietZone; }
		
		public function set addQuietZone(value:Boolean):void 
		{
			_addQuietZone = value;
		}
		
		public function get barThickness():Number { return _barThickness; }
		
		public function set barThickness(value:Number):void 
		{
			_barThickness = value;
		}
		
		public function draw():void {
			graphics.clear();
			
			var digit:String = "";
			var digit2d:Array;
			var hri:String = "";
			var code:String = barcodeText;
			var crc:Boolean = true;
			var rect:Boolean = false;
			var b2d:Boolean = false;
			
			switch( _type ) {
				case BarcodeType.STD25:
				case BarcodeType.INT25: 
					digit = BarcodeI25.getDigit(code, crc, type);
					hri = BarcodeI25.compute(code, crc, type);
					break;
					
				case BarcodeType.CODE11:
					digit = Code11.getDigit(code);
					hri = code;
					break;
					
				case BarcodeType.CODE39:
					digit = Code39.getDigit(code);
					hri = code;
					break;
					
				case BarcodeType.CODE93:
					digit = Code93.getDigit(code, crc);
					hri = code;
					break;
					
				case BarcodeType.CODE128:
					digit = Code128.getDigit(code);
					hri = code;
					break;
					
				case BarcodeType.CODABAR:
					digit = Codabar.getDigit(code);
					hri = code;
					break;
					
				case BarcodeType.DATAMATRIX:
					digit2d = Datamatrix.getDigit(code, rect);
					digit = digit2d.join("");
					b2d = true;
					hri = code;
					break;
					
				case BarcodeType.EAN8:
				case BarcodeType.EAN13:
					digit = EAN.getDigit(code, type);
					hri = EAN.compute(code, type);
					break;
					
				case BarcodeType.MSI:
					digit = MSI.getDigit(code, crc);
					hri = MSI.compute(code, crc);
					break;
			}
			
			//trace(digit);
			
			if (digit.length == 0) {
				trace("length is zero");
				return;
			}

			// Quiet Zone
			if ( !b2d && _addQuietZone) {
				digit = "0000000000" + digit + "0000000000";
			}
			
			var i:int;
			if(b2d){
				graphics.clear();
				for (i = 0; i < digit2d.length; i++) 
				{
					currentWidth = 0;
					for (var j:int = 0; j < digit2d[i].length; j++) 
					{
						if ( digit2d[i][j] == "1" ) {
							graphics.beginFill(_barcodeColor, 1);
							graphics.drawRect(currentWidth, _barThickness * i, _barThickness, _barThickness);
							graphics.endFill();
						}
						currentWidth += _barThickness;
					}
				}
			} else {
				graphics.clear();
				var currentWidth:Number = 0;
				for (i = 0; i < digit.length; i++) {
					if ( digit.charAt(i) == "1" ) {
						graphics.beginFill(_barcodeColor, 1);
						graphics.drawRect(currentWidth, 0, _barThickness, _barcodeHeight);
						graphics.endFill();
					}
					currentWidth += _barThickness;
				}
			}
				
		}
	}

}