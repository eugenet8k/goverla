package org.goverla.css
{
	import org.flex2unit.framework.TestCase;
	import org.goverla.serialization.css.CSSParser;
	import org.goverla.collections.ArrayList;

	public class CSSParserTest extends TestCase
	{
		public function testParse() : void {
			var testCss : String = "Application {backgroundColor : #ff0000;} Button {cornerRadius : 2; fillColors : #ff0000, #00ff00;}";
			var result : CSSDeclaration = CSSParser.parse(testCss);
			assertEquals(CSSStylesGroup(result.getItemAt(0)).name, "Application");
			assertEquals(CSSStylesGroup(result.getItemAt(0)).getStyle("backgroundColor").value, "#ff0000");
			assertEquals(CSSStylesGroup(result.getItemAt(1)).name, "Button");
			assertEquals(CSSStylesGroup(result.getItemAt(1)).getStyle("cornerRadius").value, "2");
			
		}
	}
}