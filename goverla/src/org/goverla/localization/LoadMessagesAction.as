package org.goverla.localization {
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.goverla.interfaces.ICommand;

	public class LoadMessagesAction implements ICommand {
		
		private var _url : String;
		private var _messagesObject : Object;
		private var _loader : URLLoader;
		
		public function LoadMessagesAction(url : String, messagesObject : Object)
		{
			_url = url;
			_messagesObject = messagesObject;
		}
		
		public function execute():void
		{
			_loader = new URLLoader(new URLRequest(_url));
			_loader.addEventListener(Event.COMPLETE, onLoadComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
		
		private function onLoadComplete(event : Event) : void
		{
			var xml : XML = new XML(_loader.data);
			for each(var child : XML in xml.children())
			{
				_messagesObject[child.name()] = String(child.text());
			}
		}
		
		private function onIOError(event : IOErrorEvent) : void
		{
			
		}
		
	}
}