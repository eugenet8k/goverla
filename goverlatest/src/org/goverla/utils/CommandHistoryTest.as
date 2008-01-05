package org.goverla.utils
{
	import mx.controls.Alert;
	
	import org.flex2unit.framework.TestCase;
	import org.goverla.command.CommandHistory;
	import org.goverla.command.UndoableTestCommand;

	public class CommandHistoryTest extends TestCase
	{
		
		public function testCanUndo() : void {
			
			var commHist : CommandHistory = new CommandHistory();
			var comm : UndoableTestCommand = new UndoableTestCommand();
			
			assertFalse("CommandHistory.canUndo", commHist.canUndo);
			
			commHist.execute(comm);
			
			assertTrue("CommandHistory.canUndo", commHist.canUndo);
		} 
		
		public function testCanRedo() : void {
			
			var commHist : CommandHistory = new CommandHistory();
			var comm : UndoableTestCommand = new UndoableTestCommand();
			
			assertFalse("CommandHistory.canRedo", commHist.canRedo);
			
			commHist.execute(comm);
			commHist.undo();
			
			assertTrue("CommandHistory.canRedo", commHist.canRedo);
		} 
		
		public function testExecute() : void {
			
			var commHist : CommandHistory = new CommandHistory();
			var comm : UndoableTestCommand = new UndoableTestCommand();
			
			commHist.execute(comm);
			
			assertTrue("CommandHistory.execute()", commHist.canUndo);
			assertTrue("CommandHistory.execute()", comm.isExecuted);
			assertFalse("CommandHistory.execute()", comm.isUndone);
		} 
		
		public function testUndo() : void {
			
			var commHist : CommandHistory = new CommandHistory();
			var comm : UndoableTestCommand = new UndoableTestCommand();
			
			commHist.execute(comm);
			commHist.undo();
			
			assertFalse("CommandHistory.undo()", commHist.canUndo);
			assertFalse("CommandHistory.undo()", comm.isExecuted);
			assertTrue("CommandHistory.undo()", comm.isUndone);
		} 
		
		public function testRedo() : void {
			
			var commHist : CommandHistory = new CommandHistory();
			var comm : UndoableTestCommand = new UndoableTestCommand();
			
			commHist.execute(comm);
			commHist.undo();
			commHist.redo();
			
			assertFalse("CommandHistory.redo()", commHist.canRedo);
			assertTrue("CommandHistory.redo()", comm.isExecuted);
			assertFalse("CommandHistory.redo()", comm.isUndone);
		} 
	}
}