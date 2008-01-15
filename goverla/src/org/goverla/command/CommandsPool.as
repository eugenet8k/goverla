package org.goverla.command
{
	import flash.events.Event;
	
	import org.goverla.collections.ArrayList;
	import org.goverla.collections.ListCollectionViewIterator;
	import org.goverla.command.events.ProgressEvent;
	import org.goverla.command.interfaces.IAsynchronousCommand;
	import org.goverla.errors.IllegalStateError;
	import org.goverla.events.DefaultEvent;

	public class CommandsPool extends AsynchronousCommandBase
	{
		public var haltOnError : Boolean = false;
		
		private var _currentCommand : IAsynchronousCommand;
		private var _progress : Number = 0;
		private var _processing : Boolean = false;
		private var _commands : ArrayList = new ArrayList();
		private var _iterator : ListCollectionViewIterator;
		
		public function CommandsPool()
		{
			super();
		}
		
		[Bindable(event="progress")]
		public function get progressValue() : Number
		{
			return _progress;
		}
		
		public function get processing() : Boolean
		{
			return _processing;
		}
		
		public function get currentCommand() : IAsynchronousCommand
		{
			return _currentCommand;
		}
		
		public function clear() : void
		{
			if(_processing)
			{
				throw new IllegalStateError("Cannot clear while processing");
			}
			else
			{
				_commands.removeAll();
			}
		}

		public function add(command : IAsynchronousCommand) : void
		{
			if(_processing)
			{
				throw new IllegalStateError("Cannot add command while processing");
			}
			else
			{
				_commands.addItem(command);
			}
		}
		

		override public function execute():void
		{
			_progress = 0;
			dispatchProgress();
			if(processing)
			{
				throw new IllegalStateError("Pool is executing");
			}
			else
			{
				_iterator = new ListCollectionViewIterator(_commands);
				processNext();
			}
		}
		
		private function processNext() : void
		{
			if(_iterator.hasNext())
			{
				_currentCommand = IAsynchronousCommand(_iterator.next());
				
				
				_currentCommand.success.addListener(onCommandSuccess);
				_currentCommand.error.addListener(onCommandError);
				_currentCommand.progress.addListener(onCommandProgress);
				_currentCommand.execute();
			}
			else
			{
				_processing = false;
				_currentCommand = null;
				success.sendEvent(new DefaultEvent());
			}
		}
		
		private function onCommandSuccess(event : Event) : void
		{
			updateProgress();
			removeCommandListeners();
			processNext();
		}

		private function onCommandError(event : Event) : void
		{
			updateProgress();
			removeCommandListeners();
			if(haltOnError)
			{
				_processing = false;
				_currentCommand = null;
				error.sendEvent(new DefaultEvent());
			}
			else
			{
				processNext();
			}
		}
		
		private function updateProgress() : void
		{
			_progress = (_commands.getItemIndex(_currentCommand) + 1) / _commands.length;
			dispatchProgress();
		}
		
		private function dispatchProgress() : void
		{
			progress.sendEvent(new ProgressEvent(progressValue));
			dispatchEvent(new ProgressEvent(progressValue));
		}
		

		private function onCommandProgress(event : ProgressEvent) : void
		{
			_progress = (_commands.getItemIndex(_currentCommand) + event.progress) / _commands.length;
			dispatchProgress();
		}
		
		private function removeCommandListeners() : void
		{
			_currentCommand.success.removeListener(onCommandSuccess);
			_currentCommand.error.removeListener(onCommandError);
			_currentCommand.progress.removeListener(onCommandProgress);
		}
		
	}
}