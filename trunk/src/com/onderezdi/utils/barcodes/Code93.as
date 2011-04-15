package com.onderezdi.utils.barcodes 
{
	/**
	$(CBI)* ...
	$(CBI)* @author Sentinel
	$(CBI)*/
	public class Code93
	{
		
		private static var encoding:Array = ["100010100", "101001000", "101000100", "101000010",
			"100101000", "100100100", "100100010", "101010000",
			"100010010", "100001010", "110101000", "110100100",
			"110100010", "110010100", "110010010", "110001010",
			"101101000", "101100100", "101100010", "100110100",
			"100011010", "101011000", "101001100", "101000110",
			"100101100", "100010110", "110110100", "110110010",
			"110101100", "110100110", "110010110", "110011010",
			"101101100", "101100110", "100110110", "100111010",
			"100101110", "111010100", "111010010", "111001010",
			"101101110", "101110110", "110101110", "100100110",
			"111011010", "111010110", "100110010", "101011110"];
			
		public function Code93() 
		{
			
		}
		
		public static function getDigit(code:String, crc:Object):String{
			var table:String = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%____*"; // _ => ($), (%), (/) et (+)
			var c:String = "";
			var result:String = "";
			var i:int;
			var index:int;
			
			if (code.indexOf('*') >= 0) {
				return "";
			}

			code = code.toUpperCase();

			// start :  *
			result  += encoding[47];

			// digits
			for (i = 0; i < code.length; i++) {
				c = code.charAt(i);
				index = table.indexOf( c );
				if ( (c == '_') || (index < 0) ) {
					return("");
				}
				result += encoding[ index ];
			}

			// checksum
			if (crc){
				var weightC:int = 0;
				var weightSumC:int = 0;
				var weightK:int = 1; // start at 1 because the right-most character is "C" checksum
				var weightSumK:int = 0;
				for (i = code.length - 1; i >= 0; i--) {
					weightC = weightC == 20 ? 1 : weightC + 1;
					weightK = weightK == 15 ? 1 : weightK + 1;
					index = table.indexOf( code.charAt(i) );
					weightSumC += weightC * index;
					weightSumK += weightK * index;
				}
				var ci:int = weightSumC % 47;
				weightSumK += ci;
				var k:int = weightSumK % 47;
				result += encoding[ci];
				result += encoding[k];
			}
			result  += encoding[47]; // stop : *
			result  += '1'; // Terminaison bar
			return result;
		}
		
	}

}