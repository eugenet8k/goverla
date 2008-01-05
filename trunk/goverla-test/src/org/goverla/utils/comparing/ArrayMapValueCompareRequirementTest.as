package org.goverla.utils.comparing
{
	import org.goverla.collections.HashMap;
	
	import mx.collections.ArrayCollection;
	
	import org.flex2unit.framework.TestCase;

	public class ArrayMapValueCompareRequirementTest extends TestCase
	{
		
		public function testMeet() : void {
			
			var arrCol1 : ArrayCollection = new ArrayCollection(["value1", "value"]);
			var arrCol2 : ArrayCollection = new ArrayCollection(["value2", "value3"]);
			var map : HashMap = new HashMap();
			map.addItem("key1", arrCol1);
			map.addItem("key2", arrCol2);
			var req : ArrayMapValueCompareRequirement = new ArrayMapValueCompareRequirement(map, "value"); 
			
			assertTrue("ArrayMapValueCompareRequirement.meet()", req.meet("key1"));
			assertFalse("ArrayMapValueCompareRequirement.meet()", req.meet("key2"));
		}
	}
}