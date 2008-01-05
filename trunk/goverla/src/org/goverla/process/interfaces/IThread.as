package org.goverla.process.interfaces
{
	public interface IThread
	{
		function start() : void;
		function process() : void;
		function finish() : void;
		function hasToFinish() : Boolean;
		
		
	}
}