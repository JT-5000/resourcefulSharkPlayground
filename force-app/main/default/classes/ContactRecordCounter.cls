public with sharing class ContactRecordCounter {
    
    @AuraEnabled(cacheable=true)
    public static Integer countContactRecordsRelatedToAccount(Id accountId){

        //SOQL statement to fetch all contacts related to the provided Id (bind variable)
        List<Contact> contactList = [SELECT FirstName, LastName, Phone FROM Contact WHERE AccountId = :accountId];

        //Creating a variable to capture the total count of our list.
        Integer totalContactRecordCount = contactList.size();

        //The size is equal to the count, so we're ready to return it.
        return totalContactRecordCount;
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContactRecords(Id accountId){

        //SOQL statement to fetch all contacts related to the provided Id (bind variable)
        List<Contact> contactList = [SELECT FirstName, LastName, Phone FROM Contact WHERE AccountId = :accountId];

        //The size is equal to the count, so we're ready to return it.
        return contactList;
    }


}