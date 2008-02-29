package org.goverla.remoting
{
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	
	import org.goverla.collections.ArrayList;
	import org.goverla.utils.ReflectUtil;
	
	public class BaseRed5Delegate extends BaseDelegate
	{
		private static const METHOD_NAME : String = "call";
		
		public static var defaultConnectionUrl : String;
		
		private static var _netConnection : NetConnection;
		
		public static function get netConnection() : NetConnection
		{
			if(_netConnection == null)
			{
				
				_netConnection = new NetConnection();
				//TODO:Remove comments when red5 6.4 will be published.
				_netConnection.objectEncoding = ObjectEncoding.AMF0;		
			}
			return _netConnection;
		}

		
		public function BaseRed5Delegate(resultHandler:Function, faultHandler:Function)
		{
			super(resultHandler, faultHandler);
			connectionUrl = defaultConnectionUrl;
		}
		override protected function createConnection():NetConnection
		{
			return netConnection;
		}
		
		override protected function getServiceName(methodName : String) : String
		{
			return METHOD_NAME;
		}
		
		override protected function processArguments(methodName : String, args : ArrayList) : ArrayList
		{
			var newArgs : ArrayList = new ArrayList();
			var className : String = ReflectUtil.getFullTypeName(this);
			className = ReflectUtil.normalizeTypeName(className);
			newArgs.addItem(className);
			newArgs.addItem(methodName);
			newArgs.addItem(args.toArray());
			return newArgs;
		}
		
	}
}