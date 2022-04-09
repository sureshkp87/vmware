/**
 * Created by Suresh on 08/04/2022.
 */

trigger authorTrigger on Author__c
		(before insert, before update, before delete, 
         after insert, after update, after delete, after undelete)
{
	Author_Trigger_Handler handler =
			new Author_Trigger_Handler(Trigger.new, Trigger.old);

	if (Trigger.isBefore)
	{
		if (Trigger.isInsert) handler.beforeInsert();
		if (Trigger.isUpdate) handler.beforeUpdate();
		if (Trigger.isDelete) handler.beforeDelete();
	}
}