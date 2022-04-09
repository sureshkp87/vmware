public with sharing class Author_Trigger_Handler
{
	private final List<Author__c> records;
	private final List<Author__c> oldRecords;

	public Author_Trigger_Handler
			(List<Author__c> records, List<Author__c> oldRecords)
	{
		this.records = records;
		this.oldRecords = oldRecords;
	}

	public void beforeInsert()
	{
		setAuthorFullNameFromFirstAndLastNames();
	}

	public void beforeUpdate()
	{
		setAuthorFullNameFromFirstAndLastNames();
	}

	public void beforeDelete()
	{
		// To Do
		// Add required logic while Deleting Opportunity Line Item
	}

	private void setAuthorFullNameFromFirstAndLastNames()
	{
		for (Author__c record : records)
		{
			record.Author_Name__c = record.First_Name__c + ' ' + record.Last_Name__c ;
		}
	}
}