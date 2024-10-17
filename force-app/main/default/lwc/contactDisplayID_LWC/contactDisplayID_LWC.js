import { LightningElement, api, wire } from 'lwc';
import returnContactActivityCount from '@salesforce/apex/ContactActivityLWCHelper.returnContactActivityCount';

export default class ContactDisplayID_LWC extends LightningElement {
    
    //'@api' makes this variable public so the record page load can populate it
    @api recordId;
    
    //This variable will be used later for our total activity count
    activityCount = 0;

    
    //This wire invokes our apex method and passes in the record ID of the contact. 
    //Once a value is returned it's stored in the 'activityCount' variable
    @wire(returnContactActivityCount, {recordId: '$recordId'}) 
    wiredActivityCount({ error, data }) {
        if (data) {
            console.log(data);
            this.activityCount = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.activityCount = 0;  // Reset to 0 or handle appropriately in case of error
        }
    }

}