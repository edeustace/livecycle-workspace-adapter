package com.ee.lc.workspace.api.model
{

	[RemoteClass(alias="com.adobe.idp.taskmanager.dsc.client.query.AssignmentImpl")]
	public class Assignment
	{
		public static const TYPE_INITIAL:int=0;
		public static const TYPE_FORWARD:int=1;
		public static const TYPE_REJECT:int=2;
		public static const TYPE_CLAIM:int=3;
		public static const TYPE_ESCALATION:int=4;
		public static const TYPE_ADMINREASSIGNMENT:int=5;
		public static const TYPE_CONSULT:int=6;

		public var assignmentCreateTime:Date;

		public var userAcl:TaskACL;

		public var assignmentType:Number;

		public var queueId:Number;

		public var queueOwner:String;

		public var currentAssignmentId:Number;

		public var assignmentUpdateTime:Date;

		public var queueTitle:String;

		public var queueType:Number;

		public var queueOwnerId:String;
	}

}
