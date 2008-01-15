package org.goverla.command
{
	import org.goverla.command.interfaces.IAsynchronousCommand;
	import org.goverla.events.DefaultEvent;
	import org.goverla.events.EventSender;

	public class AsynchronousTestCommand extends UndoableTestCommand implements IAsynchronousCommand
	{
		private var _success : EventSender = new EventSender();
		private var _error : EventSender = new EventSender();
		private var _progress : EventSender = new EventSender();
		
		private var _successable : Boolean;
		
		public function AsynchronousTestCommand(successable : Boolean)
		{
			super();
			_successable = successable;
		}
		
		override public function execute():void
		{
			super.execute();
			if(_successable)
			{
				success.sendEvent(new DefaultEvent());
			}
			else
			{
				error.sendEvent(new DefaultEvent());
			}
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