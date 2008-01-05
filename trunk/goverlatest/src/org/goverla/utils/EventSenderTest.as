package org.goverla.utils
{
	import flash.events.Event;
	
	import org.flex2unit.framework.TestCase;
	import org.goverla.events.EventSender;
	import org.goverla.utils.common.TestEvent;

	public class EventSenderTest extends TestCase
	{
		
		public function testSendTypedEvent() : void {
			var eventSender : EventSender = new EventSender(TestEvent);
			
			try {
				eventSender.sendEvent(new Event("Test"));
				fail("Error must be thrown")
			} catch(error : TypeError) {
				
			}
		}		
		
		public function testSendEvent() : void {
			
			var event : Event = new Event("TestEvent");
			
			var eventSender : EventSender = new EventSender();
			
			eventSender.addListener(listener1);
			eventSender.addListener(listener2);
			
			eventSender.sendEvent(event);
		}
		
		private function listener1(e:Event) : void {
			
			assertEquals(e.type, "TestEvent");
		}
		
		private function listener2(e:Event) : void {
			
			assertEquals(e.type, "TestEvent");
		}
	}
}