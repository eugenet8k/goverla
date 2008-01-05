package org.goverla.utils
{
	import org.flex2unit.framework.TestCase;
	import org.goverla.reflection.OverloadHandler;

	public class OverloadHandlerTest extends TestCase
	{
		
		public function testMatch() : void {
			
			var handler : OverloadHandler = new OverloadHandler([int, String], handleIt);
			
			assertTrue("OverloadHandler.match()", handler.match([1, "1"])); 
			assertFalse("OverloadHandler.match()", handler.match(["1", 1])); 
		}
		
		private function handleIt(i : int, s : String) : String {
			return s + i;
		}
	}
}