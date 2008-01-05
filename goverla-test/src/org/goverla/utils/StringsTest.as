package org.goverla.utils
{
	import org.flex2unit.framework.TestCase;

	public class StringsTest extends TestCase
	{
		
   		public function testRemoveSymbols() : void {
   			var symbols : String = " -+";
   			var source : String = "Kovalyov, + lammer, - back=Off!";
   			
   			var result : String = Strings.removeSymbols(source, symbols); 
   			assertEquals("Kovalyov,lammer,back=Off!", result);
   		}
   		
   		public function testRemoveDuplications() : void {
   			var source : String = "aaabbbaaa";
   			assertEquals("aaabbb", Strings.removeDuplications(source, "aaa"));
   		}
   		
   		public function testTemp() : void {
   			var string : String = "<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"Verdana\" SIZE=\"2\" COLOR=\"#0B333C\" LETTERSPACING=\"0\" KERNING=\"0\"><IMG SRC=\"CG_Girls_021.jpg\" WIDTH=\"100\" HEIGHT=\"100\" ID=\"zoy_lVUGLw\" ALIGN=\"left\"> <FONT SIZE=\"10\">Here is text that follows the image. I&apos;m extending the text by lengthening this sentence until it&apos;s long enough to show wrapping around the bottom of the image.</FONT></FONT></P></TEXTFORMAT>";
   			var regexp : RegExp = /(<img[^<]*zoy_lVUGLw.*?>)/i;
   			trace(regexp.exec(string));

   		}
		
	}

}