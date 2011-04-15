package com.onderezdi.utils.barcodes 
{
	/**
	$(CBI)* ...
	$(CBI)* @author Sentinel
	$(CBI)*/
	public class Code11
	{
		
		private static var encoding:Array = ["101011", "1101011", "1001011", "1100101", "1011011", "1101101", "1001101", "1010011", "1101001", "110101", "101101"];
		
		
		public function Code11() 
		{
			
		}
		
		public static function getDigit(code:String):String {
			var table:String = "0123456789-";
			var i:int;
			var index:int;
			var result:String = ""
			var intercharacter:String = '0';
			// start
			result = "1011001" + intercharacter;
			// digits
			for (i = 0; i < code.length; i++) {
				index = table.indexOf( code.charAt(i) );
				if (index < 0) {
					return "";
				}
				result += encoding[index] + intercharacter;
			}
			// checksum
			var weightC:int = 0;
			var weightSumC:int = 0;
			var weightK:int = 1; // start at 1 because the right-most character is "C" checksum
			var weightSumK:int = 0;
			for (i = code.length - 1; i >= 0; i--) {
				weightC = weightC == 10 ? 1 : weightC + 1;
				weightK = weightK == 10 ? 1 : weightK + 1;
				index = table.indexOf( code.charAt(i) );
				weightSumC += weightC * index;
				weightSumK += weightK * index;
			}
			var c:int = weightSumC % 11;
			weightSumK += c;
			var k:int = weightSumK % 11;
			result += encoding[c] + intercharacter;
			if (code.length >= 10){
				result += encoding[k] + intercharacter;
			}
			// stop
			result  += "1011001";
			return(result);
		}
	}
}