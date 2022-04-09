public with sharing class GetNumberOfBooks
{
	@AuraEnabled(Cacheable=true)
	public static List<AggregateResult> getNumberOfBooksByGenre(Id publishingHouseId)
	{
		try
		{
			return
			[
					SELECT
							COUNT(Id) bookCount,
							Genre__C genre
					FROM Book__C
					WHERE Publishing_House__C = :publishingHouseId
					GROUP BY Genre__C
			];
		}
		catch (Exception error)
		{
			AuraHandledException auraException = new AuraHandledException(error.getMessage());
			auraException.setMessage(error.getStackTraceString());
			throw auraException;
		}
	}

	@AuraEnabled(Cacheable=true)
	public static List<AggregateResult> getNumberOfBooksByAuthor(Id publishingHouseId)
	{
		try
		{
			return
			[
					SELECT
							COUNT(ID) bookCount,
							author__r.Author_Name__c authorName
					FROM BookAuthor__c
					WHERE Book__C IN
					(
							SELECT
									Id
							FROM Book__C
							WHERE Publishing_House__C = :publishingHouseId
					)
					GROUP BY author__r.Author_Name__c
			];
		}
		catch (Exception error)
		{
			AuraHandledException auraException = new AuraHandledException(error.getMessage());
			auraException.setMessage(error.getStackTraceString());
			throw auraException;
		}
	}
}