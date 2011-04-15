package com.onderezdi.utils.barcodes 
{
	/**
	$(CBI)* ...
	$(CBI)* @author Sentinel
	$(CBI)*/
	public class EAN
	{
		
		private static var encoding:Array =  [ ["0001101", "0100111", "1110010"], ["0011001", "0110011", "1100110"], ["0010011", "0011011", "1101100"], ["0111101", "0100001", "1000010"], ["0100011", "0011101", "1011100"], ["0110001", "0111001", "1001110"], ["0101111", "0000101", "1010000"], ["0111011", "0010001", "1000100"], ["0110111", "0001001", "1001000"], ["0001011", "0010111", "1110100"] ];
		
		private static var first:Array = ["000000", "001011", "001101", "001110", "010011", "011001", "011100", "010101", "010110", "011010"];
				
		public function EAN() 
		{
			
		}
		
		public static function getDigit(code:String, type:String):String{
			// Check len (12 for ean13, 7 for ean8)
			var len:int = (type == BarcodeType.EAN8 ? 7 : 12);
			code = code.substring(0, len);
			if (code.length != len) {
				return "";
			}
			// Check each digit is numeric
			var c:String;
			var i:int;
			if ( code.match(/\D/) ) {
				return "";
			}
			
			// get checksum
			code = compute(code, type);

			// process analyse
			var result:String = "101"; // start
			if ( type == BarcodeType.EAN8 ){
				// process left part
				for (i = 0; i < 4; i++) {
					result += encoding[int(code.charAt(i))][0];
				}
				// center guard bars
				result += "01010";
				// process right part
				for (i = 4; i < 8; i++) {
					result += encoding[int(code.charAt(i))][2];
				}
			} else { // ean13
				// extract first digit and get sequence
				var seq:String = first[ int(code.charAt(0)) ];
				// process left part
				for (i = 1; i < 7; i++) {
					result += encoding[int(code.charAt(i))][ int(seq.charAt(i-1)) ];
				}
				// center guard bars
				result += "01010";
				// process right part
				for (i = 7; i < 13; i++) {
					result += encoding[int(code.charAt(i))][ 2 ];
				}
			} // ean13
			result += "101"; // stop
			return result;
		}
		
		public static function compute(code:String, type:String):String{
			var len:int = (type == BarcodeType.EAN13 ? 12 : 7);
			code = code.substring(0, len);
			var sum:int = 0;
			var odd:Boolean = true;
			for (var i:int = code.length - 1; i > -1; i--) {
				sum += (odd ? 3 : 1) * int(code.charAt(i));
				odd = ! odd;
			}
			return (code + ((10 - sum % 10) % 10).toString());
		}
		
	}

}