public with sharing class BookAuthor_Trigger_Handler
{
	private final List<BookAuthor__c> records;
	private final List<BookAuthor__c> oldRecords;

	public BookAuthor_Trigger_Handler
			(List<BookAuthor__c> records, List<BookAuthor__c> oldRecords)
	{
		this.records = records;
		this.oldRecords = oldRecords;
	}

	public void beforeInsert()
	{
		setBookAuthorKeyFromBookAndAuthorIds();
	}

	public void beforeUpdate()
	{
		setBookAuthorKeyFromBookAndAuthorIds();
	}

	public void beforeDelete()
	{
		// To Do
		// Add required logic while Deleting Opportunity Line Item
	}

	private void setBookAuthorKeyFromBookAndAuthorIds()
	{
		for (BookAuthor__c record : records)
		{
			record.BookAuthorName__c = record.Book__c + '' + record.Author__c;
		}
	}
}