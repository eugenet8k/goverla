package org.goverla.utils
{
	import org.flex2unit.framework.TestCase;
	import org.goverla.collections.Stack;

	public class StackTest extends TestCase
	{
		public function StackTest(name:String=null)
		{
			super(name);
		}
		
		public function testEnqueueDequeue() : void {
			var stack : Stack = new Stack();
			stack.enqueue(1);
			stack.enqueue(2);
			stack.enqueue(3);
			
			assertEquals(stack.dequeue(), 3);
			assertEquals(stack.dequeue(), 2);
			assertEquals(stack.dequeue(), 1);
		}
		
	}
}