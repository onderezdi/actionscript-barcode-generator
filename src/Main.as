package 
{
	import com.onderezdi.utils.barcodes.Barcode;
	import com.onderezdi.utils.barcodes.BarcodeType;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Sentinel
	$(CBI)*/
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
			barcode.barcodeText = "http://www.google.com";
			barcode.type = BarcodeType.DATAMATRIX;
			barcode.barThickness = 1;
			barcode.draw();
			addChild(barcode);
		}
		
	}
	
}