
trigger contactUpdatedEmailAddressTrigger on Contact (after update) {

    //Create a task list for later use
    List<Task> taskCollection = new List<Task>();
    
    //Loop over all contacts contained in trigger.new 
    for (Contact updatedContact : Trigger.new) {

        //Get the previous version of the contact prior to the update
        Contact oldContact = Trigger.oldMap.get(updatedContact.Id);

        //Log old and new values to the debug log
  
        
        //Evaluate whether the contact's email address has been changed.
        if (oldContact.Email != updatedContact.Email){
            Task sendEmailTask = new Task(
                OwnerId = updatedContact.OwnerId,
                Description = 'Send an email to thank the contact for connecting with us electronically',
                WhoId = updatedContact.Id,
                Subject = 'Send Thank You Email'
            );
            
            //We next want to add this task to a collection 
            taskCollection.add(sendEmailTask);
        }
    }

    //Now that we've collected all task records, we can run an insert against them.
    insert taskCollection;

}