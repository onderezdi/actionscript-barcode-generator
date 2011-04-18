/*
	actionscript barcode generator
	ported from jQuery barcode plug-in (http://barcode-coder.com/en/barcode-jquery-plugin-201.html)

    Copyright (C) <2011>  <Önder Ezdi>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

package 
{
	import com.onderezdi.utils.barcodes.Barcode;
	import com.onderezdi.utils.barcodes.BarcodeType;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var barcode:Barcode = new Barcode();
			barcode.x = 50;
			barcode.y = 50;
			barcode.barcodeText = "1234567890123";
			barcode.type = BarcodeType.INT25;
			barcode.barThickness = 1;
			addChild(barcode);
			
		}
		
	}
	
}