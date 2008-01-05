package org.goverla.utils.comparing
{
	import org.flex2unit.framework.TestCase;

	public class StringComparerTest extends TestCase
	{
		
		public function testCompare() : void {
			
			var string1 : String = "10";
			var string2 : String = "-467536";
			var string3 : String = "432.34";
			var string4 : String = "10.0";
			var string5 : String = "abc";
			var string6 : String = "abcd";
			
			
			var comp : StringComparer = new StringComparer();
			
			assertEquals(ComparingResult.GREATER, comp.compare(string1, string2));
			assertEquals(ComparingResult.SMALLER, comp.compare(string1, string4));
			assertEquals(ComparingResult.SMALLER, comp.compare(string2, string3));
			assertEquals(ComparingResult.GREATER, comp.compare(string6, string5));
			assertEquals(ComparingResult.EQUALS, comp.compare(string6, string6));
		}
	}
}