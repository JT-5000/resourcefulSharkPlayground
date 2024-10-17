public with sharing class ContactAccountHelper {
    
    
    public static void CreateRelatedAccountAndContactRecords() {

        //Call our GetAccountId method in order to create a new account and receive the ID.
        String newAccountID = GetAccountId();


        //Output our accountID string to the debug log
        System.debug(newAccountID);


        //Create a new contact record
        Contact newContact = new Contact();


        //Populate contact record field values
        newContact.FirstName = 'Bill';
        newContact.LastName = 'Harris';
        
        //This line relates our newly created acccount to our contact record
        newContact.AccountId = newAccountID;


        //Output our new contact to the debug log
        System.debug(newContact);


        //Insert our new contact record
        insert newContact;
       
    }

    private static String GetAccountId (){
        
        //Create a new account record in memory
        Account newAccount = new Account();

        
        //Populate field values
        newAccount.Name = 'Jimmy Dev Account';
        newAccount.Fax = '212-345-5555';

        
        //Inserting the new account
        insert newAccount;


        //Output our new account to the debug log
        System.debug(newAccount);


        //Returning the new account's ID to the caller
        return newAccount.Id;

    }

}