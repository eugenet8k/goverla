package org.goverla.utils.comparing
{
	import org.flex2unit.framework.TestCase;

	public class PropertyCompareRequirementTest extends TestCase
	{
		
		public function testMeet() : void {
			
			var req : PropertyCompareRequirement = new PropertyCompareRequirement("property", "value");
			var obj1 : Object = new Object();
			var obj2 : Object = new Object();
			
			obj1["property"] = "value";
			
			assertTrue(req.meet(obj1));
			assertFalse(req.meet(obj2));
		}
	}
}