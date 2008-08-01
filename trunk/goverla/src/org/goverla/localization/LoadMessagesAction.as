package org.goverla.localization {
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.goverla.events.EventSender;
	import org.goverla.interfaces.ICommand;

	public class LoadMessagesAction implements ICommand {
		
		private var _url : String;
		private var _messagesObject : Object;
		private var _loader : URLLoader;
		
	
		private var _loaded:EventSender = new EventSender();
		private var _status:String;

		public function LoadMessagesAction(url : String, messagesObject : Object)
		{
			_url = url;
			_messagesObject = messagesObject;
		}
		
		public function get loaded():EventSender
		{
			return _loaded;
		}

		public function execute():void
		{
			_loader = new URLLoader(new URLRequest(_url));
			_loader.addEventListener(Event.COMPLETE, onLoadComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
		}
		
		private function onLoadComplete(event : Event) : void
		{
			var xml : XML = new XML(_loader.data);
			for each(var child : XML in xml.children())
			{
				_messagesObject[child.name()] = String(child.text());
			}
			_loaded.sendEvent();
		}
		
		private function onHttpStatus(event : HTTPStatusEvent) : void
		{
			_status = event.toString();
		}
		private function onIOError(event : IOErrorEvent) : void
		{
			trace(event.text + " " + _status);
			//throw new Error("Error loading localization from " + _url);
		}
		
	}
}