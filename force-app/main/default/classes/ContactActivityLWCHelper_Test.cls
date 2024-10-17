
@isTest
private class ContactActivityLWCHelper_Test {

    @isTest
    static void myUnitTest_1() {
        
        //Create two contact records for testing, one with activities and one without.
        Contact contactWithActivities = new Contact();
        Contact contactWithoutActivities = new Contact();

        //Create 2 activities to be used in testing.
        Task task1 = new Task(
            OwnerId = contactWithActivities.OwnerId,
            WhoId = contactWithActivities.Id,
            Subject = 'Task #1'
        );

        //Logging out task1 to the debug log
        System.debug(task1);

        Event event1 = new Event(
            OwnerId = contactWithActivities.OwnerId,
            WhoId = contactWithActivities.Id,
            Subject = 'Event #1'
        );
        //Logging out event1 to the debug log
        System.debug(event1);

        //Call our apex method using a contact record that has associated activities
        Integer activityCount2 = ContactActivityLWCHelper.returnContactActivityCount(contactWithActivities.Id);

        //Call our apex method using a contact record that has associated activities
        Integer activityCount0 = ContactActivityLWCHelper.returnContactActivityCount(contactWithoutActivities.Id);

        //Make our assertions about the number of returned activities for both.
        Assert.areEqual(2, activityCount2);
        Assert.areEqual(0, contactWithoutActivities);

    }
}