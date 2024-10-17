public with sharing class AccountCreationLWC {
    
    @AuraEnabled
    public static void createNewAccount(String businessName, String webAddress){
        Account account = new Account(Name = businessName, Website = webAddress);
        
        try {
            insert account;
        } catch (Exception e) {
            throw new AuraHandledException('Error creating an account' + e.getMessage());
        }
    }
}