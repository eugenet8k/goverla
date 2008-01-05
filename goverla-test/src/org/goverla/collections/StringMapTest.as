package org.goverla.collections
{
	import org.flex2unit.framework.TestCase;

	public class StringMapTest extends TestCase
	{
		
		public function testPutAndGet() : void {
			
			var map : StringMap = new StringMap();
			var firstKey : String = "first";
			var secondKey : String = "";
			var firstValue : Object = new Object();
			var secondValue : Object = new Object();
			
			map.put(firstKey, firstValue);
			map.put(secondKey, secondValue);
			
			assertEquals(firstValue, map.get(firstKey));
			assertEquals(secondValue, map.get(secondKey));
		}
	}
}