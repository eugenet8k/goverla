package org.goverla.collections
{
	import org.flex2unit.framework.TestCase;

	public class LinearQueueTest extends TestCase
	{
		
		public function testEnqueueDequeue() : void {
			
			var queue : LinearQueue = new LinearQueue();
			var obj1 : Object = new Object();
			var obj2 : Object = new Object();
			
			queue.enqueue(obj1);
			queue.enqueue(obj2);
			
			assertEquals(obj1, queue.dequeue());
			assertEquals(obj2, queue.dequeue());
		}
	}
}