package org.goverla.net {
	
	import flash.errors.IllegalOperationError;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	
	public class RemotingConnection extends NetConnection {
		
		public function RemotingConnection(url : String) {
			objectEncoding = ObjectEncoding.AMF0;
			if (url != null) {
				connect(url);
			} else {
				throw new IllegalOperationError("Can't connect to '" + url +  "' - gateway!");
			}
		}
		
	}
	
}