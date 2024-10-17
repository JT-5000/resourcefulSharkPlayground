trigger contactTriggerTaskCreation on Contact (after insert) {
    
    //Here we're fetching our metadata reocords we plan to use for turning on or turning off the trigger
    List<Task_Trigger_Controller__mdt> metaDataRecords = [SELECT Id, DeveloperName, Activate_Contact_Task_Trigger__c 
                                                            FROM Task_Trigger_Controller__mdt];


    //Loop through our metadata records
    for (Task_Trigger_Controller__mdt metaDataRecord : metaDataRecords) {
        
        
        //Here we're checking to see if our boolean is set to true. If so, then the trigger runs else it doesn't run.
        if (metaDataRecord.Activate_Contact_Task_Trigger__c == true){
                    
            
            //Create a task list for later use
            List<Task> taskList = new List<Task>();

            //Loop through all contacts in Trigger.new
            for (Contact contact : Trigger.new) {
                
                //Create a new task
                Task newContactTask = new Task(

                //Name the subject of the task 'Welcome Call'
                Subject = 'Welcome Call',

                //Assign the task to the contact record owner
                OwnerId = contact.OwnerId,

                //Relate the task to the newly created contact record
                WhoId = contact.Id,

                //Set the task due date to be + 7 days from when the contact was created
                ActivityDate = contact.CreatedDate.date() + 7,

                //Set the task description as 'Onboarding call with <contact.firstname><contact.lastname>'
                Description = 'Onboarding call with ' + contact.FirstName + ' ' + contact.LastName
                
                );

                //Add each new task to our collection
                taskList.add(newContactTask);
            }

            //Insert tasks into the database
            insert taskList;
        }
    }
}