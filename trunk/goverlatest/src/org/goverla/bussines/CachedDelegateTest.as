package org.goverla.bussines {
	import org.as2lib.test.mock.MockControl;
	import org.flex2unit.framework.mock.MockDelegate;
	import org.flex2unit.framework.TestCase;
	
	import org.goverla.business.caching.DelegateCallsCache;
	
	import common.delegates.MockBaseDelegate;
	
	/**
	 * @author Maxym Hryniv
	 */
	public class CachedDelegateTest extends TestCase {
		
		public function testGetFromCache() : void {
			DelegateCallsCache.getInstance().clear();
			var mockControl : MockControl = new MockDelegate(MockBaseDelegate);
			var mock : MockBaseDelegate = mockControl.getMock();
			mock.mockMethod(1);
			mockControl.setReturnValue(27, 1);
			
			mockControl.replay();
			new MockBaseDelegate(this, onResult, null, true, false).mockMethod(1);
			new MockBaseDelegate(this, onResult, null, true, false).mockMethod(1);
			mockControl.verify();
			
		}
	
		public function testRefreshFilledCache() : void {
			DelegateCallsCache.getInstance().clear();
			var mockControl : MockControl = new MockDelegate(MockBaseDelegate);
			var mock : MockBaseDelegate = mockControl.getMock();
			mock.mockMethod(1);
			mock.mockMethod(1);
			
			mockControl.replay();
			new MockBaseDelegate(this, null, null, true, false).mockMethod(1);
			new MockBaseDelegate(this, null, null, true, true).mockMethod(1);
			mockControl.verify();
			
		}
	
		public function testRefreshEmptyCache() : void {
			DelegateCallsCache.getInstance().clear();
			var mockControl : MockControl = new MockDelegate(MockBaseDelegate);
			var mock : MockBaseDelegate = mockControl.getMock();
			mock.mockMethod(1);
			
			mockControl.replay();
			new MockBaseDelegate(this, null, null, false, true).mockMethod(1);
			new MockBaseDelegate(this, null, null, true, false).mockMethod(1);
			mockControl.verify();
			
		}
		
		private function onResult(result : Object) : void {
			assertEquals(result, 27);
		}
		
	}
}