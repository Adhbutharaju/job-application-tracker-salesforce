public class AccountTriggerHandler {
    //whenever account is created if industry is energy or media, then we need to populate rating as hot
    public static void populateRating(List<Account> newAccList){
        for(Account acc : newAccList){
            if(acc.Industry == 'Energy' || acc.Industry == 'Media'){
                acc.Rating = 'Hot';
            }
        }
    }
    //whenever account is created if rating is hot, then we need to populate description as high priority customer
    public static void populateDescription(List<Account> accList){
        for(Account acc : accList){
            if(acc.Rating == 'Hot'){
                acc.Description = 'High Priority Customer';
            }  
        }
    }
    // whenver account created with billing address then populate shipping address as well
    public static void copyBillingToShipping(List<Account> accList){
        for(Account acc : accList){
            if(acc.Copy_Billing_To_Shipping__c == true){
                acc.ShippingCountry = acc.BillingCountry;
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingStreet = acc.BillingStreet;
            }
        }
    }
    //when account is created then create related contact as well
    public static void createRelatedContact(List<Account> accList){
        List<Contact> conList = new List<Contact>();
        for(Account acc : accList){
            Contact con = new Contact();
            con.FirstName = 'Fname';
            con.LastName = 'Lname';
            con.AccountId = acc.Id;
            conList.add(con);
        }
        if(!conList.isEmpty()){
            insert conList;
        }
    }
    //whenver account is created, create related opportunity record as well
    public static void createRelatedOpp(List<Account> accList){
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(Account acc : accList){
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name;
            opp.CloseDate = System.today();
            opp.StageName = 'Prospecting';
            opp.AccountId = acc.Id;
            oppList.add(opp);
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }
    }
    
    public static void updateAccDes(List<Account> newAccList, Map<Id,Account> accOldMap){
        System.debug('hii hello');
        for(Account acc : newAccList){
            System.debug('Old Phone = ' + accOldMap.get(acc.Id).Phone);
            System.debug('New Phone = ' + acc.Phone);
            if(acc.Phone != accOldMap.get(acc.Id).Phone){
                //System.debug(acc.Phone + 'is new value' + oldAcc.Phone +'is old value');
                System.debug('Phone Changed');

           		 acc.Description = 'Phone Updated';

           		 System.debug('Description = ' + acc.Description);
                acc.Description = 'Phone is Updated! old value : ' + accOldMap.get(acc.Id).Phone + 'new value :' + acc.Phone;
            }
        }
        
    }
}