package org.goverla.command {

	import org.goverla.command.interfaces.IUndoableCommand;
	import org.goverla.errors.IllegalStateError;

	public class AbstractUndoableCommand implements IUndoableCommand {

		protected var executed : Boolean;
		protected var undone : Boolean;

		public function undo():void {
			if(!executed) {
				throw new IllegalStateError("Can't undo cause command wasn't executed");
			}
			executed = false;
			undone = true
		}

		public function execute():void {
			if(executed) {
				throw new IllegalStateError("Command was executed allready");
			}
			executed = true;
			undone = false;
		}

	}

}