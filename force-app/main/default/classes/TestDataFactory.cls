@isTest
public class TestDataFactory {

    public static Company__c createCompany(Boolean doInsert){
        Company__c comp = new Company__c(
            Name = 'Test Company'
        );
        if(doInsert) insert comp;
        return comp;
    }

    public static Job__c createJob(Id companyId, Boolean doInsert){
        Job__c job = new Job__c(
            Name = 'Test Job',       // 
            Company__c = companyId
        );
        if(doInsert) insert job;
        return job;
    }

    public static Application__c createApplication(
        Id jobId, Id companyId, Boolean doInsert
    ){
        Application__c app = new Application__c(
            Job__c = jobId,
            Company__c = companyId,
            Status__c = 'Applied',
            Applied_Date__c = Date.today()
        );
        if(doInsert) insert app;
        return app;
    }

    public static Interview__c createInterview(
        Id appId, String outcome, Boolean doInsert
    ){
        Interview__c intv = new Interview__c(
            Application__c = appId,
            Interview_Type__c = 'Video',
            Interview_Date__c = DateTime.now().addDays(1),
            Interviewer__c = 'John Smith',
            Outcome__c = outcome
        );
        if(doInsert) insert intv;
        return intv;
    }
}