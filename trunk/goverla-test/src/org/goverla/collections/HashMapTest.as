package org.goverla.collections
{
	import org.flex2unit.framework.TestCase;

	public class HashMapTest extends TestCase
	{
		
		public function testPutAndGet() : void {
			var map : HashMap = new HashMap();
			var firstKey : Object = new Object();
			var secondKey : Object = null;
			var firstValue : Object = new Object();
			var secondValue : Object = new Object();
			
			map.addItem(firstKey, firstValue);
			map.addItem(secondKey, secondValue);
			
			assertEquals(firstValue, map.getItem(firstKey));
			assertEquals(secondValue, map.getItem(secondKey));
		}
		
	}
}