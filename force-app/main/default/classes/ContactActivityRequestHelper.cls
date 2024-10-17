public with sharing class ContactActivityRequestHelper {
    
    @auraEnabled(cacheable=true)
    public static List<SObject> returnAllActivitiesRelatedToContact(Id recordId, 
                                                                    Boolean includePastActivities, 
                                                                    Boolean includeFutureActivities) {

        List<Task> contactTaskList = new List<Task>();
        List<Event> contactEventList = new List<Event>();
        List<SObject> completeActivityList = new List<SObject>();
        
        //This statement says to only include historical activities
        if (includePastActivities == true && includeFutureActivities == false) {
            
            //Fetch past tasks based on due date.
            contactTaskList = [SELECT Id, Subject, ActivityDate, WhoId FROM Task WHERE WhoId = :recordId AND ActivityDate < :Date.today()];

            //Fetch future events based on due
            contactEventList = [SELECT Id, Subject, ActivityDate, WhoId FROM Event WHERE WhoId = :recordId AND ActivityDate < :Date.today()];

            //Combine both lists into one.
            completeActivityList.addAll(contactTaskList);
            completeActivityList.addAll(contactEventList);
            
            //Return the list of records          
            return completeActivityList;
        
            //This statement says to only include future activities
        }else if (includeFutureActivities == true && includePastActivities == false) {
            
            //Fetch future tasks based on due date.
            contactTaskList = [SELECT Id, Subject, ActivityDate, WhoId FROM Task WHERE WhoId = :recordId AND ActivityDate >= :Date.today()];

            //Fetch future events based on due date.
            contactEventList = [SELECT Id, Subject, ActivityDate, WhoId FROM Event WHERE WhoId = :recordId AND ActivityDate >= :Date.today()];

            //Combine both lists into one.
            completeActivityList.addAll(contactTaskList);
            completeActivityList.addAll(contactEventList);
            System.debug(completeActivityList);
            
            //Return the list of records          
            return completeActivityList;
        
            //For the else condition, we need to include both historical and future activities
        } else if (includeFutureActivities == true && includePastActivities == true) {
            //Fetch all tasks, both historical and future.
            contactTaskList = [SELECT Id, Subject, ActivityDate, WhoId FROM Task WHERE WhoId = :recordId];

            //Fetch all events, both historical and future.
            contactEventList = [SELECT Id, Subject, ActivityDate, WhoId FROM Event WHERE WhoId = :recordId];


            //Combine both lists into one.
            completeActivityList.addAll(contactTaskList);
            completeActivityList.addAll(contactEventList);


            System.debug(completeActivityList);
            System.debug(completeActivityList.size());
        
        
            //Return the list of records
            return completeActivityList;
        }else {
            //Return an empty list.
            return completeActivityList;
        }
       
    }
}