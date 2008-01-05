package org.goverla.controls.validators {
	
	import org.goverla.controls.validators.common.ErrorMessages;
	import org.goverla.utils.Objects;
	import org.goverla.utils.Strings;
	
	import mx.utils.StringUtil;
	
	/**
	 * @author Tyutyunnyk Eugene
	 */
	public class RegularExpressionValidator extends BaseValidator {
		
		private var _validationExpression : String;
		
		/**
		 *  Gets the regular expression that determines the pattern used to validate a field. 
		 */
		public function get validationExpression() : String {
			return _validationExpression;
		}
	
		/**
		 *  Sets the regular expression that determines the pattern used to validate a field. 
		 */
		public function set validationExpression(validationExpression : String) : void {
			_validationExpression = validationExpression;
		}
		
		public function RegularExpressionValidator() {
			super();
		}
		
		protected override function setDefaultErrorMessage() : void {
			if (Strings.isBlank(errorMessage)) {
				errorMessage = ErrorMessages.FIELD_NOT_MATCHES_PATTERN;
			}
		}	
		
		protected override function evaluateIsValid() : Boolean {
			var result : Boolean;
			var validationValue : Object = getControlValidationValue(controlToValidate);
			
			if (!(validationValue is String)) {
				throw new Error("The validation value must have String type."); 
			}
			
			if (Strings.isBlank(String(validationValue))) {
				result = true;
			} else {
				var match : Array = StringUtil.trim(String(validationValue)).match(_validationExpression); 
				result = match != null;
			}
	
			return result;
		}
	
	}
}