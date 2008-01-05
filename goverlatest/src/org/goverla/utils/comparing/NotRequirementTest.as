package org.goverla.utils.comparing
{
	import org.flex2unit.framework.TestCase;

	public class NotRequirementTest extends TestCase
	{
		
		public function testMeet() : void {
			
			var baseReq : PropertyCompareRequirement = new PropertyCompareRequirement("property", "value");
			var req : NotRequirement = new NotRequirement(baseReq);
			var obj1 : Object = new Object();
			var obj2 : Object = new Object();
			
			obj1["property"] = "value";
			
			assertFalse("NotRequirement.meet()", req.meet(obj1));
			assertTrue("NotRequirement.meet()", req.meet(obj2));
		}
	}
}