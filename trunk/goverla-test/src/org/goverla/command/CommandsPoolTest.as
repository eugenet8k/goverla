package org.goverla.command
{
	import org.flex2unit.framework.TestCase;
	import org.goverla.collections.ArrayList;
	import org.goverla.command.events.ProgressEvent;
	
	public class CommandsPoolTest extends TestCase
	{
		private var _commands : ArrayList = new ArrayList();
		
		private var _errorDispatched : Boolean;
		private var _successDispatched : Boolean;
		private var _progress : Number;
		
		public function CommandsPoolTest()
		{
			super();
			_commands.addItem(new AsynchronousTestCommand(false));
			_commands.addItem(new AsynchronousTestCommand(true));
			_commands.addItem(new AsynchronousTestCommand(true));
		}
		
		public function testExecute() : void
		{
			var pool : CommandsPool = new CommandsPool();
			var command : AsynchronousTestCommand;
			for each(command in _commands)
			{
				pool.add(command);
			}
			pool.haltOnError = true;
			pool.error.addListener(function() : void {_errorDispatched = true;});
			pool.execute();
			assertTrue(_errorDispatched);
			assertFalse(pool.processing);
			
			
			pool.haltOnError = false;
			pool.success.addListener(function() : void {_successDispatched = true;});
			pool.progress.addListener(function(event : ProgressEvent) : void {_progress = event.progress;});
			pool.execute();
			assertEquals(_progress, 1);
			for each(command in _commands)
			{
				assertTrue(command.isExecuted);
			}
			assertTrue(_successDispatched);
		}

	}
}