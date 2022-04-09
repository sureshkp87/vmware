/**
 * Created by Suresh on 08/04/2022.
 */

trigger bookTrigger on Book__c
		(before insert, before update, before delete,
				after insert, after update, after delete, after undelete)
{
	Book_Trigger_Handler handler =
			new Book_Trigger_Handler(Trigger.new, Trigger.old);
    
	if (Trigger.isAfter)
	{
		if (Trigger.isInsert) handler.afterInsert();
		if (Trigger.isUpdate) handler.afterUpdate();
        if (Trigger.isDelete) handler.afterDelete();
        if (Trigger.isUnDelete) handler.afterUnDelete();
	}
}