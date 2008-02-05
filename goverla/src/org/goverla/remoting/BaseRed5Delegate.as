package org.goverla.remoting
{
	import org.goverla.collections.ArrayList;
	import org.goverla.utils.ReflectUtil;
	
	public class BaseRed5Delegate extends BaseDelegate
	{
		private static const METHOD_NAME : String = "call";
		
		public static var defaultConnectionUrl : String;
		

		public function BaseRed5Delegate(resultHandler:Function, faultHandler:Function)
		{
			super(resultHandler, faultHandler);
			connectionUrl = defaultConnectionUrl;
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