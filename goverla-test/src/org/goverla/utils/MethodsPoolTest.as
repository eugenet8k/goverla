package org.goverla.utils
{
	import org.goverla.utils.common.MethodCallInfo;
	
	import org.flex2unit.framework.TestCase;

	public class MethodsPoolTest extends TestCase
	{
		
		private var _executed : Boolean = false;

		public function testExecute() : void {
			var pool : MethodsPool = new MethodsPool();
			pool.insert(new MethodCallInfo(MethodsPoolTest, method2, [5, "blablabla"]));
			pool.insert(new MethodCallInfo(MethodsPoolTest, method1, []));
			
			pool.execute();
			
			assertTrue("MethodsPool.execute()", _executed);
		}
		
		private function method1() : void {
			_executed = true;
		}

		private function method2(a : int, b : String) : void {
			assertEquals(a, 5);
			assertEquals(b, "blablabla");
		}
	}
}