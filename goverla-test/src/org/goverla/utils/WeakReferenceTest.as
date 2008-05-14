package org.goverla.utils
{
	import org.flex2unit.framework.TestCase;

	public class WeakReferenceTest extends TestCase
	{
		private var _reference : WeakReference;
		public function WeakReferenceTest()
		{
			super();
		}
		
		public function testWeakReference() : void
		{
			var obj : Object = new Object();
			_reference = new WeakReference(obj);
			assertEquals(obj, _reference.value);
			assertTrue(_reference.alive);
			Timers.callAfter(assertDestroyed, 2000);
		}
		
		private function assertDestroyed() : void
		{
			assertFalse(_reference.alive);
		}
	}
}