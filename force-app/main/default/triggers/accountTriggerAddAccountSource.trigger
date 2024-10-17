trigger accountTriggerAddAccountSource on Account (before insert) {
    
    //Here we're looping through all records contained in Trigger.new.
    for (Account acct : Trigger.new) {
        
        //For each record, we need to update the source field to 'Trade Show'
        acct.AccountSource = 'Trade Show';

        //Because this is a before insert trigger we don't need to use an update dml statement.

    }
}