package org.goverla.utils.comparing
{
	import org.flex2unit.framework.TestCase;
	import org.goverla.collections.ArrayList;
	import org.goverla.utils.Arrays;

	public class UniqueFieldRequirementTest extends TestCase
	{
		public function UniqueFieldRequirementTest(name:String=null)
		{
			super(name);
		}
		
		
		public function meetTest() : void
		{
			var sourceItems : Array = [{test:"a", test:"b", test:"c"
				, test:"a", test:"a", test:"c", test:"a", test:"c", test:"a"
				, test:"a", test:"b", test:"a", test:"b", test:"a"}];
			var req : UniqueFieldRequirement = new UniqueFieldRequirement("test");
			var result : ArrayList = Arrays.getByRequirement(sourceItems, req);
			assertEquals(result.length, 3);
			assertEquals(result.getItemAt(0).test, "a");
			assertEquals(result.getItemAt(1).test, "b");
			assertEquals(result.getItemAt(2).test, "c");
		}
		
	}
}