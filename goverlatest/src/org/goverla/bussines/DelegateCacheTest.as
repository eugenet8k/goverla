package org.goverla.bussines {
	
	import org.goverla.business.DelegateFacade;
	import org.goverla.business.caching.DelegateCallsCache;
	import org.goverla.business.common.MethodCallInfo;
	import org.goverla.business.common.ServiceCallInfo;
	import org.goverla.collections.LinearQueue;
	
	import mx.controls.Button;
	
	import org.flex2unit.framework.TestCase;
	import org.flex2unit.framework.TestSuite;
	
	/**
	 * @author Maxym Hryniv
	 */
	public class DelegateCacheTest extends TestCase {
		
		public function testPut() : void {
			var params : Array = ["cadcsa", DelegateCacheTest];
			var serviceInfo : ServiceCallInfo = 
				new ServiceCallInfo("first"
					, "sdvcss"
					, params);
	
			var secondServiceInfo : ServiceCallInfo = 
				new ServiceCallInfo("second"
					, "css"
					, ["svcsdv", serviceInfo]);
					
					
					
			var result : Object = new Object();
			var secondResult : ServiceCallInfo = serviceInfo;
	
			DelegateFacade.delegateCallsCache.put(serviceInfo, result);
			DelegateFacade.delegateCallsCache.put(secondServiceInfo, secondResult);
			
			var receivedResult : Object = DelegateFacade.delegateCallsCache.get(serviceInfo);
			var secondReceivedResult : Object = DelegateFacade.delegateCallsCache.get(secondServiceInfo);
			
			assertEquals(result, receivedResult); 
			assertEquals(secondResult, secondReceivedResult);
			 
		}
	
		public function testSameMethodWithoutParamsPut() : void {
			var iterations : Number = 100;
			
			for (var index : Number = 0; index < iterations; index++) {
				var result : Object = generateParams();
				var info : ServiceCallInfo = new ServiceCallInfo("service", "method", []); 
				DelegateFacade.delegateCallsCache.put(info, result);
				assertEquals(result, DelegateFacade.delegateCallsCache.get(info));
				
			}
		}
	
		public function testContains() : void {
			var iterations : Number = 100;
			var infos : LinearQueue = new LinearQueue();
			
			for (var index : Number = 0; index < iterations; index++) {
				var result : Object = generateParams();
				var info : ServiceCallInfo = new ServiceCallInfo("service", "method", generateParams()); 
				infos.enqueue(info);
				DelegateFacade.delegateCallsCache.put(info, result);
			}
			for (index = 0; index < iterations; index++) {
				info = ServiceCallInfo(infos.dequeue()); 
				
				assertTrue(DelegateFacade.delegateCallsCache.containsKey(info));
			}
			assertFalse(DelegateFacade.delegateCallsCache.containsKey(new ServiceCallInfo("anotherService", "cdcsds", generateParams())));
		}
		public function testSameMethodPut() : void {
			var iterations : Number = 100;
			var results : LinearQueue = new LinearQueue();
			var infos : LinearQueue = new LinearQueue();
			
			for (var index : Number = 0; index < iterations; index++) {
				var result : Object = generateParams();
				var info : ServiceCallInfo = new ServiceCallInfo("service", "method", generateParams()); 
				results.enqueue(result);
				infos.enqueue(info);
				DelegateFacade.delegateCallsCache.put(info, result);
			}
			for (index = 0; index < iterations; index++) {
				result = results.dequeue();
				info = ServiceCallInfo(infos.dequeue()); 
				assertEquals(result, DelegateFacade.delegateCallsCache.get(info));
			}
		}
	
		private function generateParams() : Array {
			var result : Array = new Array();
			for (var index : Number = 0; index < 1 + Math.random(); index++) {
				result.push([Math.random(), Math.random(), Math.random()]);
				result.push({type:"casas", value:Math.random()});
				result.push(Button);
			}
			return result;
		}
	
	}
}