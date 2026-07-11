public with sharing class ApplicationKanbanController {
	@AuraEnabled(cacheable=true)
    public static List<Application__c> getApplications(){
        return [
            SELECT Id, Name, Status__c, 
                   Job__r.Name,
                   Company__r.Name,
                   Applied_Date__c,
                   Interview_Count__c
            FROM Application__c
            ORDER BY Applied_Date__c DESC
        ];
    }
}