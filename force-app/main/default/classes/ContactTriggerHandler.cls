public class ContactTriggerHandler {
    //Whenever contact is inserted or updated populate same email in the backup email custom field
    public static void copyEmail(List<Contact> conList){
        for(Contact con : conList){
            if(con.Email != null){
                con.Backup_Email__c = con.Email;
            }
        }
    }
}