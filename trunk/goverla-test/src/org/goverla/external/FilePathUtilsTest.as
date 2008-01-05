package org.goverla.external
{
	import org.goverla.external.utils.FilePathUtils;
	
	import org.flex2unit.framework.TestCase;

	public class FilePathUtilsTest extends TestCase
	{
		public function FilePathUtilsTest(name:String=null)
		{
			super(name);
		}
		
		public function testGetFileName() : void {
			var path : String = "c:\\sdfs\\fsdsdfds\\sfdfdssd\\d.jpg";
			var fileName : String = FilePathUtils.getFileName(path);
			assertEquals(fileName, "d.jpg");
		}
		
	}
}