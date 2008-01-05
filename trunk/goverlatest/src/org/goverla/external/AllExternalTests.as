package org.goverla.external
{
	import org.flex2unit.framework.TestSuite;
	
	public class AllExternalTests
	{
		public static function get suite() : TestSuite {
			var suite : TestSuite = new TestSuite("external");
			suite.addTest(FilePathUtilsTest);
			return suite;
		}
		
	}
}