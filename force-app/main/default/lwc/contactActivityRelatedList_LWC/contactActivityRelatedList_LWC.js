import { LightningElement, api, wire } from 'lwc';
import returnAllActivitiesRelatedToContact from '@salesforce/apex/ContactActivityRequestHelper.returnAllActivitiesRelatedToContact';

const COLUMNS = [
    { label: 'Name', fieldName: 'WhoId', type:'text'},
    { label: 'Subject', fieldName: 'Subject'},
    { label: 'Activity Date', fieldName: 'ActivityDate'}
];


export default class ContactActivityRelatedList_LWC extends LightningElement {

    //Making our recordId public so it can be populated from the lightning record page.
    @api recordId;

    //Variable to be used to collect our list of activities
    listOfActivities = [];

    //Here we're setting our columns created above
    columns = COLUMNS;

    //Here we're creating a variable to hold our activity related list title. This will be configurable in the AppBuilder
    @api activityRelatedListTitle = 'Default Value';

    //Here we're creating a pair of booleans that an admin can use to display either future or past activities in the component.
    @api showPastActivities = false;
    @api showFutureActivities = false;



    //Using wire to fetch data from Salesforce.
    @wire(returnAllActivitiesRelatedToContact, {recordId: '$recordId', 
                                                includePastActivities: '$showPastActivities', 
                                                includeFutureActivities: '$showFutureActivities'})
    wiredActivities({ error, data }) {
        if (data) {
            this.listOfActivities = data;
            console.log(this.listOfActivities);
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.listOfActivities = undefined;
            console.log(this.listOfActivities);
        }
    }
}