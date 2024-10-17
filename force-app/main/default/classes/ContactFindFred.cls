public with sharing class ContactFindFred {
    
    
    public static void LocateContactNamedFred() {
        
        //Create a new list to collect contact records
        List<Contact> contactList = new List<Contact>();


        
        //Use SOQL to locate a single contact with a first name = 'Fred'
        contactList = [SELECT Id, FirstName, LastName
                        FROM Contact
                        WHERE FirstName = 'Fred'
                        LIMIT 1];

        
        
        //Output our contactList to the debug console
        System.debug(contactList);

        
       
        //Create a variable to reflect the number of contact records in our list
        Integer contactListCount = contactList.size();
        
        
        //Use control flow to make sure our SOQL statement returned records and our list is not empty
        if (contactListCount == 1) {

            //Loop over all returned records and set the first names to 'Freddy'
            for (Contact fetchedContact : contactList){
                fetchedContact.FirstName = 'Freddy';
            }

            //Update our list of contact records to reflect their updated first name.
            update contactList;


            //Output our contactList to the debug console
            System.debug(contactList);

        }

    }
}