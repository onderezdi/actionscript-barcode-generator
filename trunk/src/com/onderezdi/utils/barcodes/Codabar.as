package com.onderezdi.utils.barcodes 
{
	/**
	$(CBI)* ...
	$(CBI)* @author Sentinel
	$(CBI)*/
	public class Codabar
	{
		
		private static var encoding:Array = ["101010011", "101011001", "101001011", "110010101",
			"101101001", "110101001", "100101011", "100101101",
			"100110101", "110100101", "101001101", "101100101",
			"1101011011", "1101101011", "1101101101", "1011011011",
			"1011001001", "1010010011", "1001001011", "1010011001"];
			
			
		public function Codabar() 
		{
			
		}
		
		public static function getDigit(code:String):String {
			var table:String = "0123456789-$:/.+";
			var i:int;
			var index:int;
			var result:String = "";
			var intercharacter:String = '0';
			
			// add start : A->D : arbitrary choose A
			result += encoding[16] + intercharacter;
			
			for (i = 0; i < code.length; i++) {
				index = table.indexOf( code.charAt(i) );
				if (index < 0) {
					return "";
				}
				result += encoding[index] + intercharacter;
			}
			
			// add stop : A->D : arbitrary choose A
			result += encoding[16];
			return(result);
		}
	}

}