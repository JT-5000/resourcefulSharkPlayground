public with sharing class CreateNewAccounts {
    
    //method used to create our new accounts
    public static void CreateFiveAccounts() {

        //create a list to hold our new account records
        List<Account> acctList = new List<Account>();


        //open a for loop to create 5 account records with populated fields
        for (Integer i = 1; i <= 5; i++) {
            
            //Create a new account in memory
            Account newAccount = new Account();

            
            //Populate new account record fields
            newAccount.Name = '#' + i + 'VS Code Account';
            newAccount.YearStarted = '1985';
            newAccount.Rating = 'Hot';
            newAccount.Phone = '234-333-5656';
            newAccount.Site = 'Testing Site # ' + i;

            
            //output each looped account to the debug log
            System.debug(newAccount);


            //add each new account to our list created above
            acctList.add(newAccount);
        }

        
        //output the list collection to the debug log
        System.debug(acctList);


        //insert the new accounts 
        insert acctList;

    }
}