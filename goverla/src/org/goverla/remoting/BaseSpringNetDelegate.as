package org.goverla.remoting
{
	import org.goverla.remoting.common.Responder;
	

	public class BaseSpringNetDelegate
	{
		private var _entryPoint : FluorineEntryPoint = new FluorineEntryPoint();
		private var _call : RemoteCall;
		private var _resultHandler : Function;
		private var _faultHandler : Function;
		
		public function BaseSpringNetDelegate(serviceName : String, resultHandler : Function, faultHandler : Function, getFromCache : Boolean, refreshCash : Boolean) {
			_call = new RemoteCall(serviceName, null, null);
			_resultHandler = resultHandler;
			_faultHandler = faultHandler;
		}
		
		protected function doCall(method : String, args : Array) : void {
			_call.methodName = method;
			_call.args = args;
			_entryPoint.doCall(_call, new Responder(_resultHandler, _faultHandler));
		}
		
	}
}