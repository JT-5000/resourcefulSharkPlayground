@isTest
private class AccountTriggerAddAccountSourceTest {

    @isTest
    static void createNewAccount() {
        //Creating a new account 
        Account testAccount = new Account();
        testAccount.Name = 'CoAccess Account';

        //Insert account record
        insert testAccount;

        //Retrieve our new account so we can check the value of Account Source
        Account newAccount = [SELECT Name, AccountSource FROM Account WHERE Name = 'CoAccess Account'];

        //Write an assertion to check the value of the Account Source field
        Assert.areEqual('Trade Show', newAccount.AccountSource);
    }
}