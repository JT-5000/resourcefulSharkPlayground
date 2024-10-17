import { LightningElement, wire, api } from 'lwc';
import countContactRecordsRelatedToAccount from '@salesforce/apex/ContactRecordCounter.countContactRecordsRelatedToAccount';
import getRelatedContactRecords from '@salesforce/apex/ContactRecordCounter.getRelatedContactRecords';


//Here we're building our columns to pass to our data table html component.
const COLUMNS = [
    { label: 'First Name', fieldName: 'FirstName', type:'text'},
    { label: 'Last Name', fieldName: 'LastName', type:'text'},
    { label: 'Phone Number', fieldName: 'Phone', type:'text'}
];

export default class ContactDisplayComponent_LWC extends LightningElement {

    //Exposing the record ID to collect a value from the account page.
    @api recordId;

    //Initializing our record count variable.
    totalContactRecordCount = 0;

    //This getter is used to conditionally render our html based on the number of contacts so our wording is correct. 
    //For example, we don't want to say "1 Contacts."
    get returnTruthyOrFalsy(){
        if (this.totalContactRecordCount === 1){
            return true;
        }else{
            return false;
        }
    }

    //Here we're initializing the columns for our data table html component as well as a list to hold the values returned from
    //our Apex method
    columns = COLUMNS;
    listOfContactRecords = [];

    
    //Taking advantage of the wire service to call our apex method that counts the number of contact records.
    @wire(countContactRecordsRelatedToAccount, {accountId: '$recordId'})
        wiredContactRecordCount({error,data}){
            if(data){
                this.totalContactRecordCount = data;
            }else if(error){
                this.error = error;
                this.totalContactRecordCount = -1;
            }
        }

    
    //Taking advantage of the wire service to call our apex method that returns a list of contact records.
    @wire(getRelatedContactRecords, {accountId: '$recordId'})
    wiredListOfContactRecords({error,data}){
        if(data){
            this.listOfContactRecords = data;
        }else if(error){
            this.error = error;
        }
    }
}