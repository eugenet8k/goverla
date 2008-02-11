package org.goverla.remoting {

	import flash.errors.IllegalOperationError;
	import flash.net.Responder;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.CursorManager;
	
	import org.goverla.managers.ApplicationManager;
	import org.goverla.utils.common.FramedListResult;
	
	public class RemoteClass {
		
		protected static function get gateway() : RemotingConnection {
			if (_gateway == null) {
				try {
					_gateway = new RemotingConnection(ApplicationManager.instance.url + "amfphp/gateway.php");
				} catch (ex : IllegalOperationError) {
					Alert.show(ex.message);
				}
			}
			return _gateway;
		}
		
		private static var _gateway : RemotingConnection;
		
		protected function get responder() : Responder {
			return _responder;
		}
		
		public function RemoteClass(onResult : Function, onFault : Function = null) {
			_onResult = onResult;
			_onFault = onFault;
			_responder = new Responder(onResultDefault, onFaultDefault);
			_remoteClassName = getRemoteClassName();
		}
		
		protected function call(method : String, ... rest) : void {
			if (gateway != null) {
				CursorManager.setBusyCursor();
				gateway.call(_remoteClassName + "." + method, 
					responder, rest[0], rest[1], rest[2], rest[3], rest[4]);
			}
		}
		
		private function onResultDefault(result : Object) : void {
			CursorManager.removeBusyCursor();
			if (result != null) {
				if (result is Array) {
					result = new ArrayCollection(result as Array);
				}
				
				if (result._typeName == "FramedResult") {
					var frame : FramedListResult = new FramedListResult();
					frame.totalCount = result.totalCount;
					frame.frame = new ArrayCollection(result.frame as Array);
					_onResult(frame);
				} else {
					_onResult(result);
				}
			} else {
				_onResult(result);
			}
		}
		
		private function onFaultDefault(result : Object) : void {
			CursorManager.removeBusyCursor();
			if (_onFault == null) {
				Alert.show(result.description, result.code);
			} else {
				_onFault(result);
			}
		}
		
		private function getRemoteClassName() : String {
			var result : String = getQualifiedClassName(this);
			var delimiter : int = result.indexOf(":");
			result = result.substr(delimiter + 2, result.length - delimiter);
			return result;
		}
		
		private var _responder : Responder;
		
		private var _onResult : Function;
		
		private var _onFault : Function;
		
		private var _remoteClassName : String;
		
		private var _resultItemsClass : Class;
		
	}
	
}