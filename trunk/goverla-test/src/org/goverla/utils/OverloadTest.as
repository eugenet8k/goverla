package org.goverla.utils
{
	import org.flex2unit.framework.TestCase;
	import org.goverla.reflection.Overload;

	public class OverloadTest extends TestCase
	{
		
		public function testForward() : void {
			
			var o : Overload = new Overload(OverloadTest);
			
			o.addHandler([int], handleInt);
			o.addHandler([String], handleString);
			
			var i : int = 1;
			var s : String = "1";
			
			assertEquals(o.forward([i]), i);
			assertEquals(o.forward([s]), s);
		}

		public function testForwardNull() : void {
			var o : Overload = new Overload(OverloadTest);
			
			o.addHandler([Object], handleNull);
			assertTrue(o.forward([null]));
		}
		
		private function handleNull(object : Object) : Boolean {
			return true;
		}		
		
		private function handleInt(i : int) : int {
			return i;
		}
		
		private function handleString(s : String) : String {
			return s;
		}
	}
}