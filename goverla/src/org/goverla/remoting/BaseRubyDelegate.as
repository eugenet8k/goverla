package org.goverla.remoting
{
	public class BaseRubyDelegate extends BaseDelegate
	{
		
		public function BaseRubyDelegate(resultHandler : Function, faultHandler : Function)
		{
			super(resultHandler, faultHandler);
			connectionUrl = "http://localhost:3000/weborb";
		}
		
		
	}
}