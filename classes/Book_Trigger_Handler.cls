public with sharing class Book_Trigger_Handler
{
	private final List<Book__c> records;
	private final List<Book__c> oldRecords;

	public Book_Trigger_Handler
			(List<Book__c> records, List<Book__c> oldRecords)
	{
		this.records = records;
		this.oldRecords = oldRecords;
	}

	public void afterInsert()
	{
		updateLastPublishedDateOnPublisherFromRecentPublishedBook();
	}

	public void afterUpdate()
	{
		updateLastPublishedDateOnPublisherFromRecentPublishedBook();
	}

	public void afterDelete()
	{
		updateLastPublishedDateOnPublisherFromRecentPublishedBook();
	}
    
    public void afterUnDelete()
	{
		updateLastPublishedDateOnPublisherFromRecentPublishedBook();
	}

	private void updateLastPublishedDateOnPublisherFromRecentPublishedBook()
	{
		
		Map<Id, Publishing_House__c> publisherMap = new Map<Id, Publishing_House__c> ();

		List<AggregateResult> publishedDates = selectMaxPublishedDates(getPublisherIds());

		if (publishedDates.isEmpty())
		{
			return;
		}
		else
		{
			getMaxPublishDateByPublisher(publishedDates, publisherMap);
		}

		if (!publisherMap.values().isEmpty())
		{
			update(publisherMap.values());
		}
	}

	private void getMaxPublishDateByPublisher
			(List<AggregateResult> publishedDates, Map<Id, Publishing_House__c> publisherMap)
	{
		for (AggregateResult result : publishedDates)
		{
			publisherMap.put((Id) result.get('Publishing_House__C'),
					new Publishing_House__C(Id = (Id) result.get('Publishing_House__C'),
							Last_Published_Date__c = (Date) result.get('expr0')
					)
			);
		}
	}

	private List<AggregateResult> selectMaxPublishedDates(Set<Id> publisherId)
	{
		List<AggregateResult> publishedDates =
		[
				SELECT
						MAX(Publishing_Date__c),
						Publishing_House__C
				FROM Book__C
				WHERE Publishing_House__C IN :publisherId
				GROUP BY Publishing_House__C
		];
		return publishedDates;
	}

	private Set<Id> getPublisherIds()
	{
		Set<Id> publisherId = new Set<Id> ();

		if (Trigger.isDelete)
		{
			getPublisherIdSet(oldRecords, publisherId);
		}
		else
		{
			getPublisherIdSet(records, publisherId);
		}
		return publisherId;
	}

	private void getPublisherIdSet(List<Book__c> bookRecords, Set<Id> publisherIdSet)
	{
		for (Book__c record : bookRecords)
		{
			publisherIdSet.add(record.Publishing_House__c) ;
		}
	}
}