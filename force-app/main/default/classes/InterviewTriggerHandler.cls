public class InterviewTriggerHandler {
    public static void updateApplicationStatus(
        List<Interview__c> intList, 
        Map<Id, Interview__c> oldIntMap
    ){
        // Step 1 — collect all Application Ids
        Set<Id> appIds = new Set<Id>();
        for(Interview__c i : intList){
            if(i.Application__c != null){
                appIds.add(i.Application__c);
            }
        }
        
        // Step 2 — fetch real Application records in ONE SOQL
        Map<Id, Application__c> appMap = new Map<Id, Application__c>(
            [SELECT Id, Status__c FROM Application__c WHERE Id IN :appIds]
        );
        
        // Step 3 — loop and update in memory
        List<Application__c> appList = new List<Application__c>();
        
        for(Interview__c i : intList){
            // check if Outcome actually changed
            if(i.Outcome__c != oldIntMap.get(i.Id).Outcome__c){
                // get the REAL Application record
                Application__c app = appMap.get(i.Application__c);
                
                if(app != null){
                    if(i.Outcome__c == 'Passed'){
                        app.Status__c = 'Next Round';
                        appList.add(app); // ← inside
                    }
                    else if(i.Outcome__c == 'Failed'){
                        app.Status__c = 'Rejected';
                        appList.add(app); // ← inside
                    }
                    else if(i.Outcome__c == 'No Show'){
                        app.Status__c = 'Withdrawn';
                        appList.add(app); // ← inside
                    }
                }
            }
        }
        
        // Step 4 — ONE DML outside loop
        if(!appList.isEmpty()){
            update appList;
        }
    }
}