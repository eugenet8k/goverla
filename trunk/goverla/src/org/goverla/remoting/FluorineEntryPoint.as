package org.goverla.remoting
{
	import org.goverla.utils.Objects;
	
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	import mx.core.Application;
	import mx.rpc.IResponder;
	import mx.utils.StringUtil;
	
	public class FluorineEntryPoint
	{
		private static const URL : String = "http://localhost:8080/FlexGateway/Gateway.aspx";
		private static const URL_PATTERN : String = "{0}//{1}/FlexGateway/Gateway.aspx";
		private static const REMOTE_METHOD : String = "PrismaStar.FlexFacade.AL.EntryPoint.DoCall";
		
		private static var _contextUrl : String;
		
		public function FluorineEntryPoint() {
		}
		
		public static function get contextUrl() : String {
			if(_contextUrl == null) {
				var parts : Array = Objects.castToString(Application.application.url).split("/");
				_contextUrl = StringUtil.substitute(URL_PATTERN, parts[0], parts[2]);
			}
			return _contextUrl;
		}
		
		public function doCall(call : RemoteCall, responder : IResponder) : void {
			
			var connection : NetConnection = new NetConnection();
			connection.objectEncoding = ObjectEncoding.AMF3; 
			connection.connect(contextUrl);
			
			var flashResponder : Responder = new Responder(responder.result, responder.fault);
			connection.call(REMOTE_METHOD, flashResponder, call.managerId, call.methodName, call.args);
			
		}
		
	}
}