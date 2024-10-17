import { LightningElement } from 'lwc';
import createNewAccount from '@salesforce/apex/AccountCreationLWC.createNewAccount';

export default class AccountCreationSuperFast extends LightningElement {
    businessName = '';
    webAddress = '';

    handleInputChange(event){
        this.businessName = event.target.value;
    }

    handleWebAddressChange(event){
        this.webAddress = event.target.value;
        console.log(event.target.value);
    }
    
    handleAccountCreation(event){
        createNewAccount({businessName: this.businessName, webAddress: this.webAddress});
        console.log(event);
    }
}