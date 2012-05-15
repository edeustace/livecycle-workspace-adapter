package com.rma.lc.workspace.api.model
{

	[RemoteClass(alias="com.adobe.idp.taskmanager.dsc.client.task.TaskACLImpl")]
	public class TaskACL
	{
		public var canAddAttachments:Boolean;
		public var canAddNotes:Boolean;
		public var canClaim:Boolean;
		public var canConsult:Boolean;
		public var canModifyDeadline:Boolean;
		public var canShare:Boolean;
		public var canForward:Boolean;
		public var principalId:String;
		public var taskId:String;
		public var canModifyPermissions:Boolean;
		//These are coming from the server but they aren't used.
		[Transient]
		public var commonName : String;
		[Transient]
		public var commonname : String;
		[Transient]
		public var commoNname : String;
		[Transient]
		public var dynamicPrincipal : String;
	}
}
