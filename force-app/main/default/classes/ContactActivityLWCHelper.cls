public with sharing class ContactActivityLWCHelper {
    
    @AuraEnabled(cacheable=true)

    public static Integer returnContactActivityCount(String recordId) {
        
        //Fetch a collection of tasks related to the contact record whos ID was passed to this method.
        List<Task> contactTaskList = [SELECT Id, WhoId FROM Task WHERE WhoId = :recordId];

        //Fetch a collection of events related to the contact record whos ID was passed to this method.
        List<Event> contactEventList = [SELECT Id, WhoId FROM Event WHERE WhoId = :recordId];


        //Create an sObject list to contain both lists to represent all activities
        List<SObject> completeActivityList = new List<SObject>();

        //Combine both lists into one.
        completeActivityList.addAll(contactTaskList);
        completeActivityList.addAll(contactEventList);

        //Create a variable to capture the list count so we can return it to the caller
        Integer activityCount = completeActivityList.size();

        //Return the count to the caller
        return activityCount;
    }
}