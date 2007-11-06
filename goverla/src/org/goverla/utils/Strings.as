package org.goverla.utils {
	
	/**
	 * @author Maxym Hryniv
	 */
	public class Strings {
	
		public static const DELIMITER : String = " `~!@#$%^&*()-_=+[]{};:\'\",<.>/?\\|";
		
		protected static const RETURN_EXPRESSION : RegExp = /\r\n/g;
		
		protected static const SPACE_EXPRESSION : RegExp = /[ ]/g;
		
		public static function escapeSpecialCharacters(source : String) : String {
			return replaceCharacters(source, ["<", ">", "\"", "\'", "&"], ["&lt;", "&gt;", "&quot;", "&apos;", "&amp;"]);
		}
		
		public static function replaceCharacters(source : String, characters : Array, matches : Array) : String {
			var result : String = "";
			for (var i : int = 0; i < source.length; i++) {
				var matchIndex : int = characters.indexOf(source.charAt(i));
				if (matchIndex != -1) {
					result += matches[matchIndex];
				} else {
					result += source.charAt(i);
				}
			}
			return result;
		}
		
		public static function replacePatterns(source : String, patterns : Array, matches : Array) : String {
			var result : String = source;
			for (var i : int = 0; i < patterns.length; i++) {
				result = result.replace(patterns[i], matches[i]);
			}
			return result;
		}
	
		public static function reverse(source : String) : String {
			var result : String = "";
			for(var index : Number = source.length - 1 ; index >= 0 ; index-- ) {
				result += source[index]; 
			}
			return result;
		}
	
		public static function contains(source : String, sought : String) : Boolean {
			return (source.indexOf(sought) != -1);
		}
		
		public static function removeReturns(source : String) : String {
			return (source != null ? source.replace(RETURN_EXPRESSION, "\n") : null);
		}
	
		public static function removeWhiteSpaces(source : String) : String {
			return (source != null ? source.replace(SPACE_EXPRESSION, "") : null);
		}
		
		public static function isBlank(source : String) : Boolean {
			return (source == null || source.length == 0);
		}
	
		public static function insertStringAt(sourse : String, subString : String, index : Number) : String {
			var startString : String = sourse.substring(0, index);
			var endString : String = sourse.substring(index, sourse.length);
			return (startString + subString + endString);	
		}
	
		public static function removeStringAt(source : String, startIndex : Number, endIndex : Number) : String {
			var startString : String = source.substring(0, startIndex);
			var endString : String = source.substr(endIndex, source.length);
			return (startString + endString);
		}
	
		public static function isDelimiter(character : String) : Boolean {
			var result : Boolean = false;
			if (character.length == 1) {
				result = contains(DELIMITER, character);
			} else {
				throw new Error("You can input only one character");
			}
			return result ;
		}
	
	}

}