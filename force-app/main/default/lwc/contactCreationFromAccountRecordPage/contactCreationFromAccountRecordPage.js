import { LightningElement, api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import ACCOUNT_ID_FIELD from '@salesforce/schema/Contact.AccountId';


export default class ContactCreationFromAccountRecordPage extends LightningElement {

    //Exposing this property to grab the account ID. 
    @api recordId;
    
    //Initializing our fields
    firstName = '';
    lastName = '';
    phoneNumber = '';
    contactId = '';

    //Here we're updating our firstName property
    updateFirstName(event){
        this.firstName = event.target.value;
    }

    //Here we're updating our lastName property
    updateLastName(event){
        this.lastName = event.target.value;
    }
    
    //Here we're updating our phoneNumber property
    updatePhoneNumber(event){
        this.phoneNumber = event.target.value;
    }
    
    //This method is called from the 'onclick' within our button element
    createContactRecord(){
        
        //This object builds our fields and populates them with the current instance values.
        //The square brackets allow the field api name to be set as the key. This is known as "computed property names."
        const fields = {
            [FIRSTNAME_FIELD.fieldApiName]: this.firstName,
            [LASTNAME_FIELD.fieldApiName]: this.lastName,
            [PHONE_FIELD.fieldApiName]: this.phoneNumber,
            [ACCOUNT_ID_FIELD.fieldApiName]: this.recordId
        };

        //This const builds an object that tells Salesforce which type of record to create and which fields to populate
        const recordInput = {
            apiName: CONTACT_OBJECT.objectApiName, fields
        };

        //Next, we call the out of the box method for creating a record in Salesforce without additonal Apex
        createRecord(recordInput)
            .then(contact => {
                this.contactId = contact.id;
                console.log(`Your contact record was created successfully with an id of ${contact.id}`);
                window.location.reload();
            })
            .catch(error => {
                console.error(`There was an error with the following message ${error.body.message}`);
            })
    }
}