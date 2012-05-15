package com.rma.lc.workspace.restricted.responder
{
	import mx.rpc.IResponder;

	public class DefaultResponder implements IResponder
	{
		public var resultHandler:Function;
		public var faultHandler:Function;

		public function DefaultResponder(resultHandler:Function, faultHandler:Function)
		{
			this.resultHandler=resultHandler;
			this.faultHandler=faultHandler;
		}

		public function result(data:Object):void
		{
			if (resultHandler != null)
				resultHandler(data);
		}

		public function fault(info:Object):void
		{
			if (faultHandler != null)
				faultHandler(info);
		}
	}
}
