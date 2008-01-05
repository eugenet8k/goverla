package org.goverla.utils {

	import org.flex2unit.framework.TestCase;

	public class LevenshteinTest extends TestCase {
		
		public function testGetDistance() : void {
			var distance1 : int = Levenshtein.getDistance("abc", "abcd");
			var distance2 : int = Levenshtein.getDistance("abc", "abd");
			assertEquals(distance1, distance2);
		}
		
	}

}