import { LightningElement,api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getBooksByGenre from '@salesforce/apex/GetNumberOfBooks.getNumberOfBooksByGenre';

export default class countByGenre extends LightningElement {
    @api recordId;
    error;
    totalBooksByGenre;
    visibleBooksByGenre;
    length;

    @wire(getBooksByGenre, {publishingHouseId: '$recordId'}) getNumberOfBooksByGenre({error,data})
    {
        if(error){
            this.error = error;
        }
        else if(data){
            console.log(JSON.parse(JSON.stringify(data)));
            let tempRecords = JSON.parse( JSON.stringify( data ) );
            tempRecords = tempRecords.map( row => {
                return { ...row, Genre: row.genre, Count: row.bookCount };
            })
            this.totalBooksByGenre = tempRecords;
            this.length = tempRecords.length;
        }
    }
    updateGenresHandler(event){
        this.visibleBooksByGenre=[...event.detail.records]
        console.log(event.detail.records)
    }
}