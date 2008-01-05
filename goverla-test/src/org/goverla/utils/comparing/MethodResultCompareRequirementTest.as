package org.goverla.utils.comparing
{
	import org.flex2unit.framework.TestCase;

	public class MethodResultCompareRequirementTest extends TestCase
	{
		
		public function testMeet() : void {
			
			var obj : Object = new Object();
			var req : MethodResultCompareRequirement = new MethodResultCompareRequirement("toString", "[object Object]");
			
			assertTrue(req.meet(obj));
		}
	}
}