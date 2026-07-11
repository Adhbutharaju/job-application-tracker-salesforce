@isTest
public class InterviewTriggerHandlerTest {

    @TestSetup
    static void setupTestData() {
        Company__c comp = TestDataFactory.createCompany(true);
        Job__c job = TestDataFactory.createJob(comp.Id, true);
        Application__c app = TestDataFactory.createApplication(job.Id, comp.Id, true);
        TestDataFactory.createInterview(app.Id, 'Scheduled', true);
    }

    @isTest
    static void testPassedOutcome() {
        Interview__c intv = [SELECT Id, Outcome__c FROM Interview__c LIMIT 1];

        Test.startTest();
        intv.Outcome__c = 'Passed';
        update intv;
        Test.stopTest();

        Application__c app = [SELECT Id, Status__c FROM Application__c LIMIT 1];
        System.assertEquals(
            'Next Round',
            app.Status__c,
            'Status should be Next Round when Passed'
        );
    }

    @isTest
    static void testFailedOutcome() {
        Interview__c intv = [SELECT Id, Outcome__c FROM Interview__c LIMIT 1];

        Test.startTest();
        intv.Outcome__c = 'Failed';
        update intv;
        Test.stopTest();

        Application__c app = [SELECT Id, Status__c FROM Application__c LIMIT 1];
        System.assertEquals(
            'Rejected',
            app.Status__c,
            'Status should be Rejected when Failed'
        );
    }

    @isTest
    static void testNoShowOutcome() {
        Interview__c intv = [SELECT Id, Outcome__c FROM Interview__c LIMIT 1];

        Test.startTest();
        intv.Outcome__c = 'No Show';
        update intv;
        Test.stopTest();

        Application__c app = [SELECT Id, Status__c FROM Application__c LIMIT 1];
        System.assertEquals(
            'Withdrawn',
            app.Status__c,
            'Status should be Withdrawn when No Show'
        );
    }

    @isTest
    static void testPendingOutcome() {
        Application__c appBefore = [SELECT Id, Status__c FROM Application__c LIMIT 1];
        String originalStatus = appBefore.Status__c;

        Interview__c intv = [SELECT Id, Outcome__c FROM Interview__c LIMIT 1];

        Test.startTest();
        intv.Outcome__c = 'Pending';
        update intv;
        Test.stopTest();

        Application__c appAfter = [SELECT Id, Status__c FROM Application__c LIMIT 1];
        System.assertEquals(
            originalStatus,
            appAfter.Status__c,
            'Status should NOT change when Pending'
        );
    }

    @isTest
    static void testScheduledOutcome() {
        Application__c appBefore = [SELECT Id, Status__c FROM Application__c LIMIT 1];
        String originalStatus = appBefore.Status__c;

        Interview__c intv = [SELECT Id, Outcome__c FROM Interview__c LIMIT 1];

        Test.startTest();
        intv.Outcome__c = 'Scheduled';
        update intv;
        Test.stopTest();

        Application__c appAfter = [SELECT Id, Status__c FROM Application__c LIMIT 1];
        System.assertEquals(
            originalStatus,
            appAfter.Status__c,
            'Status should NOT change when Scheduled'
        );
    }

    @isTest
    static void testBulkUpdate() {
        Company__c comp = [SELECT Id FROM Company__c LIMIT 1];
        Job__c job = [SELECT Id FROM Job__c LIMIT 1];

        List<Application__c> apps = new List<Application__c>();
        for(Integer i = 0; i < 200; i++){
            apps.add(TestDataFactory.createApplication(job.Id, comp.Id, false));
        }
        insert apps;

        List<Interview__c> interviews = new List<Interview__c>();
        for(Application__c app : apps){
            interviews.add(TestDataFactory.createInterview(app.Id, 'Scheduled', false));
        }
        insert interviews;

        Test.startTest();
        for(Interview__c intv : interviews){
            intv.Outcome__c = 'Passed';
        }
        update interviews;
        Test.stopTest();

        List<Application__c> updatedApps = [
            SELECT Id, Status__c FROM Application__c
            WHERE Id IN :apps
        ];
        for(Application__c app : updatedApps){
            System.assertEquals(
                'Next Round',
                app.Status__c,
                'All 200 apps should be Next Round'
            );
        }
    }
}