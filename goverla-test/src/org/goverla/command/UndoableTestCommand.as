package org.goverla.command
{
	import org.goverla.interfaces.IUndoableCommand;

	public class UndoableTestCommand implements IUndoableCommand
	{
		private var _executed : Boolean;
		private var _undone : Boolean;
		
		public function UndoableTestCommand() {
			
			_executed = false;
			_undone = false;
		}
		
		public function get isExecuted() : Boolean {
			return _executed;
		} 
		
		public function get isUndone() : Boolean {
			return _undone;
		} 
		
		public function undo():void
		{
			_executed = false;
			_undone = true;
		}
		
		public function execute():void
		{
			_executed = true;
			_undone = false;
		}

	}
}