package org.goverla.utils.comparing
{
	import org.flex2unit.framework.TestCase;

	public class DateComparerTest extends TestCase
	{
		
		public function testCompare() : void {
			
			var date1 : Date = new Date(2000, 12);
			var date2 : Date = new Date(1780, 5);
			var date3 : Date = new Date(2000, 12);
			
			var comp : DateComparer = new DateComparer();
			
			assertEquals(ComparingResult.GREATER, comp.compare(date1, date2));
			assertEquals(ComparingResult.EQUALS, comp.compare(date1, date3));
			assertEquals(ComparingResult.SMALLER, comp.compare(date2, date3));
		}
	}
}