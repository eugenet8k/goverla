package org.goverla.command
{
	import flash.events.EventDispatcher;
	
	import org.goverla.command.events.ProgressEvent;
	import org.goverla.command.interfaces.IAsynchronousCommand;
	import org.goverla.events.EventSender;

	public class AsynchronousCommandBase extends EventDispatcher implements IAsynchronousCommand 
	{

		private var _success : EventSender = new EventSender();
		private var _error : EventSender = new EventSender();
		private var _progress : EventSender = new EventSender(ProgressEvent);


		public function AsynchronousCommandBase()
		{
			super();
		}

		public function execute():void
		{
		}
		
		public function get success():EventSender
		{
			return _success;
		}
		
		public function get error():EventSender
		{
			return _error;
		}
		
		public function get progress():EventSender
		{
			return _progress;
		}
		
	}
}