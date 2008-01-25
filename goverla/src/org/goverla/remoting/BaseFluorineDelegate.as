package org.goverla.remoting
{
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	import mx.core.Application;
	import mx.utils.StringUtil;
	
	import org.goverla.collections.ArrayList;
	import org.goverla.utils.Objects;
	import org.goverla.utils.ReflectUtil;
	
	public class BaseFluorineDelegate extends BaseDelegate
	{
		private static const URL_PATTERN : String = "{0}//{1}/{2}/Gateway.aspx";

		public static var defaultConnectionUrl : String;
		
		private static function initialize() : void
		{
			var parts : Array = Objects.castToString(Application.application.url).split("/");
			defaultConnectionUrl = StringUtil.substitute(URL_PATTERN, parts[0], parts[2], parts[3]);
		}
		//Static constructor
		initialize();
		
		public function BaseFluorineDelegate(resultHandler : Function, faultHandler : Function) 
		{
			super(resultHandler, faultHandler);
			connectionUrl = defaultConnectionUrl;
		}
	}
}