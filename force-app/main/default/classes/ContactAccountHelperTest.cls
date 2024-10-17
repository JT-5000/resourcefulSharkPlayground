
@isTest
private class ContactAccountHelperTest {

    @isTest
    public static void contactAccountHelperUnitTest() {
         //Call our class method
         ContactAccountHelper.CreateRelatedAccountAndContactRecords();

         //Create a new list to hold the results of our account query
         List<Account> testAccount = new List<Account>();
 
         //SOQL query to return our newly created account
         testAccount = [SELECT Id, Name, Fax FROM Account WHERE Name = 'Jimmy Dev Account' AND Fax = '212-345-5555'];
 
         //Run assertion statements
         Assert.isFalse(testAccount.isEmpty());


         //Create a new list to hold the results of our contact query
         List<Contact> testContact = new List<Contact>();

         //SOQL query to return our newly created contact record
         testContact = [SELECT Id, FirstName, LastName, AccountId FROM Contact WHERE FirstName = 'Bill' AND LastName = 'Harris'];

         //Run contact assertion statements
         Assert.isFalse(testContact.isEmpty());

         //Assert that our contact record contains a populated accountId
         String contactRecord;
         
         //For loop to get access to the accountid field so we can make sure it has a value
         for (Contact contact : testContact) {
            contactRecord = contact.AccountId;
         }
         
         Assert.isNotNull(contactRecord);

    }
}