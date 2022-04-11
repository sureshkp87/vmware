import { LightningElement,api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getNumberOfBooksByAuthor from '@salesforce/apex/GetNumberOfBooks.getNumberOfBooksByAuthor';

export default class totalBooksByAuthor extends LightningElement {
    @api recordId;
    error;
    totalBooksByAuthor;
    visibleBooksByAuthor;
    length;

    @wire(getNumberOfBooksByAuthor, {publishingHouseId: '$recordId'}) getNumberOfBooksByGenre({error,data})
    {
        if(error){
            this.error = error;
        }
        else if(data){
            console.log(JSON.parse(JSON.stringify(data)));
            let tempRecords = JSON.parse( JSON.stringify( data ) );
            tempRecords = tempRecords.map( row => {
                return { ...row, Name: row.authorName, Count: row.bookCount };
            })
            this.totalBooksByAuthor = tempRecords;
            this.length = tempRecords.length;
        }
    }
    updateAuthorsHandler(event){
        this.visibleBooksByAuthor=[...event.detail.records]
        console.log(event.detail.records)
    }
}