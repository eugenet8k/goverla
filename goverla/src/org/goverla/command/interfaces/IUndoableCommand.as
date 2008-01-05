package org.goverla.command.interfaces {

	import org.goverla.command.interfaces.ICommand;

	/**
	 * @author Sergey Kovalyov
	 */
	public interface IUndoableCommand extends ICommand {
		
		function undo() : void;
	
	}

}