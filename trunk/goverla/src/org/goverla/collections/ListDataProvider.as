package org.goverla.collections {
	
	import mx.collections.ArrayCollection;
	
	import org.goverla.interfaces.IConverter;
	import org.goverla.utils.Arrays;
	import org.goverla.utils.common.FramedListResult;
	
	public class ListDataProvider extends AbstractListDataProvider {
		
   		protected function get converter() : IConverter {
			return _converter;
		}

    	protected function set converter(value : IConverter) : void {
			_converter = value;
		}
		
    	protected function get unconverter() : IConverter {
			return _unconverter;
		}

    	protected function set unconverter(value : IConverter) : void {
			_unconverter = value;
		}
		
		public function ListDataProvider(itemsPerPage : Number) {
			super(itemsPerPage);
		}
 
		protected override function onRefreshItems(result : Object) : void {
			var frame : FramedListResult = new FramedListResult();
			
			if (result is FramedListResult) {
				frame = FramedListResult(result);
				
				if (converter != null) {
					frame.frame = Arrays.getConverted(frame.frame, converter);	
				}
			} else if (result is ArrayCollection) {
				if (converter != null) {
					frame.frame = Arrays.getConverted(ArrayCollection(result), converter);
				} else {
					frame.frame = ArrayCollection(result);
				}
				
				frame.totalCount = frame.frame.length;
			} else {
				throw new Error("Method onRefreshItems needs in FramedResult, FramedListResult or ArrayCollection types!"); 
			}

			super.onRefreshItems(frame);
		}
		
		private var _converter : IConverter;
		
		private var _unconverter : IConverter;
		
	}
	
}