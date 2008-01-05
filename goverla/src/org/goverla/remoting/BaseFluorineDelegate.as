package org.goverla.remoting
{
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.utils.StringUtil;
	
	import org.goverla.collections.ArrayList;
	import org.goverla.utils.Objects;
	import org.goverla.utils.ReflectUtil;
	
	public class BaseFluorineDelegate
	{
		private static const URL_PATTERN : String = "{0}//{1}/{2}/Gateway.aspx";

		private static var _contextUrl : String;
		
		private var _resultHandler : Function;
		private var _faultHandler : Function;
		
		public function BaseFluorineDelegate(resultHandler : Function, faultHandler : Function, getFromCache : Boolean, refreshCash : Boolean) {
			_resultHandler = resultHandler;
			_faultHandler = faultHandler == null ? defaultFaultHandler : faultHandler;
		}
		
		public function get contextUrl() : String
		{
			if(_contextUrl == null) {
				var parts : Array = Objects.castToString(Application.application.url).split("/");
				_contextUrl = StringUtil.substitute(URL_PATTERN, parts[0], parts[2], parts[3]);
			}
			return _contextUrl;
		}

		public function set contextUrl(value : String) : void
		{
			_contextUrl = value;
		}

		public function doCall(method : String, args : Array) : void {
			
			var connection : NetConnection = new NetConnection();
			connection.objectEncoding = ObjectEncoding.AMF3; 
			connection.connect(contextUrl);
			
			var className : String = ReflectUtil.getFullTypeName(this);
			className = ReflectUtil.normalizeTypeName(className);
			var flashResponder : Responder = new Responder(_resultHandler, _faultHandler);
			var newArguments : ArrayList = new ArrayList([StringUtil.substitute("{0}.{1}", className, method), flashResponder]);
			newArguments.addItems(new ArrayList(args));
			
			connection.call.apply(connection, newArguments.toArray());
			
		}
		
		private function defaultFaultHandler(fault : Object) : void
		{
			Alert.show("Fault: " +  fault.description);
		}
	}
}