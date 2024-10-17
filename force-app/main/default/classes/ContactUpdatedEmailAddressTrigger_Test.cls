
@isTest
private class ContactUpdatedEmailAddressTrigger_Test {

    @isTest
    static void updateContactEmailAddress() {
        
        //Create a new contact record without an email address
        Contact newContact = new Contact(
            FirstName = 'Joe',
            LastName = 'Brown'
        );
        insert newContact;

        //Retrieve our new contact 
        Contact retrievedContact = [SELECT Id, LastName, Email FROM Contact WHERE LastName = 'Brown' LIMIT 1];


        //Update the retrievedContact's email address
        retrievedContact.Email = 'test@updatedContact.com';

        //Update our retrievedContact given we've updated the email address
        update retrievedContact;

        
        //Attempt to fetch a new task created for the contact record
        Task newTask = [SELECT Id, Subject FROM Task WHERE WhoId = :retrievedContact.Id];

        //Make assertions about our contacts
        Assert.isNotNull(newTask, 'A new task has been returned for this contact record.');
        Assert.areEqual(newTask.Subject, 'Send Thank You Email');
        Assert.areEqual('test@updatedContact.com', retrievedContact.Email);
        Assert.isNotNull(retrievedContact);
    }
}