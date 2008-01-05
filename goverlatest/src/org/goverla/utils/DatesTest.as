package org.goverla.utils {

	import mx.collections.ArrayCollection;
	
	import org.flex2unit.framework.TestCase;

	public class DatesTest extends TestCase {
		
		public function testGetMonthNumber() : void {
			assertEquals(Dates.getMonthNumber("October"), 9);
		}

		public function testGetMonthDayCount() : void {
			assertEquals(Dates.getMonthDayCount(9, 2000), 31);
			assertEquals(Dates.getMonthDayCount(1, 2000), 29);
			assertEquals(Dates.getMonthDayCount(1, 1900), 28);
		}

		public function testIsLeapYear() : void {
			assertTrue("Dates.isLeapYear", Dates.isLeapYear(2000));
			assertTrue("Dates.isLeapYear", Dates.isLeapYear(1604));
			assertFalse("Dates.isLeapYear", Dates.isLeapYear(1900));
			assertFalse("Dates.isLeapYear", Dates.isLeapYear(1703));
		}

		public function testDateObjectToDate() : void {
			var date : Date = new Date(1999, 12);
			var result : Date = Objects.castToDate(date);
			
			assertEquals(result.millisecondsUTC, date.millisecondsUTC);
		}

		public function testMax() : void {
			var date1 : Date = new Date(2000, 12);
			var date2 : Date = new Date(1306, 3);
			
			assertEquals(Dates.max(date1, date2), date1);
		}

		public function testMin() : void {
			var date1 : Date = new Date(2000, 12);
			var date2 : Date = new Date(1306, 3);
			
			assertEquals(Dates.min(date1, date2), date2);
		}

	}

}