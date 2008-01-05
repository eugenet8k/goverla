package org.goverla.utils
{
	import org.goverla.utils.timers.CallFunctionAction;
	
	public final class Timers
	{
		public static function callAfter(func : Function, interval : uint = 100, thisObject : Object = null, arguments : Array = null) : void
		{
			var command : CallFunctionAction = new CallFunctionAction(func, interval, thisObject, arguments);
			command.execute();
		}
	}
}