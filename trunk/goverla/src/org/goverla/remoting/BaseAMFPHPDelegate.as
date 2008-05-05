package org.goverla.remoting {
	
	import org.goverla.managers.ApplicationManager;
	
	public class BaseAMFPHPDelegate extends BaseDelegate {
		
		public function BaseAMFPHPDelegate(resultHandler : Function, faultHandler : Function) {
			super(resultHandler, faultHandler);
			connectionUrl = ApplicationManager.instance.url + "amfphp/gateway.php";
		}
		
	}
	
}