package org.goverla.utils.comparing
{
	import org.flex2unit.framework.TestCase;

	public class NumberComparerTest extends TestCase
	{
		
		public function testCompare() : void {
			
			var number1 : Number = 10;
			var number2 : Number = -467536;
			var number3 : Number = 432.34;
			var number4 : Number = 10.0;
			
			var comp : NumberComparer = new NumberComparer();
			
			assertEquals(ComparingResult.GREATER, comp.compare(number1, number2));
			assertEquals(ComparingResult.EQUALS, comp.compare(number1, number4));
			assertEquals(ComparingResult.SMALLER, comp.compare(number2, number3));
		}
	}
}