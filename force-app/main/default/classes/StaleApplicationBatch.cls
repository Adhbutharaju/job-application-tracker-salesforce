global class StaleApplicationBatch 
    implements Database.Batchable<sObject>, Schedulable {
    
    // Status values to EXCLUDE from stale check
    private static final Set<String> CLOSED_STATUSES = new Set<String>{
        'Rejected', 'Withdrawn', 'Next Round'
    };

    // Schedulable method — runs the batch
    global void execute(SchedulableContext sc){
        Database.executeBatch(new StaleApplicationBatch(), 200);
    }

    // start() — fetches all stale applications
    global Database.QueryLocator start(Database.BatchableContext bc){
        Date thirtyDaysAgo = Date.today().addDays(-30);
        return Database.getQueryLocator([
            SELECT Id, Status__c, Notes__c 
            FROM Application__c 
            WHERE LastModifiedDate <= :thirtyDaysAgo
            AND Status__c NOT IN :CLOSED_STATUSES
        ]);
    }

    // execute() — processes each chunk of 200
    global void execute(Database.BatchableContext bc, List<Application__c> appList){
        List<Application__c> toUpdate = new List<Application__c>();
        
        for(Application__c app : appList){
            app.Status__c = 'Withdrawn';
            app.Notes__c = 'Auto-closed due to 30 days inactivity';
            toUpdate.add(app);
        }
        
        if(!toUpdate.isEmpty()){
            update toUpdate;
        }
    }

    // finish() — runs once after all chunks done
    global void finish(Database.BatchableContext bc){
        System.debug('StaleApplicationBatch completed successfully');
    }
}