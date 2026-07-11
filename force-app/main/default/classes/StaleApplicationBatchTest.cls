@isTest
public class StaleApplicationBatchTest {

    @TestSetup
    static void setupTestData() {
        Company__c comp = TestDataFactory.createCompany(true);
        Job__c job = TestDataFactory.createJob(comp.Id, true);
        TestDataFactory.createApplication(job.Id, comp.Id, true);
    }

    @isTest
    static void testBatchExecution() {
        Test.startTest();
        StaleApplicationBatch batch = new StaleApplicationBatch();
        Database.executeBatch(batch, 200);
        Test.stopTest();

        // Verify batch ran without errors
        List<Application__c> apps = [
            SELECT Id, Status__c FROM Application__c
        ];
        System.assertNotEquals(
            0,
            apps.size(),
            'Applications should exist after batch'
        );
    }

    @isTest
    static void testScheduler() {
        Test.startTest();
        String cronExp = '0 0 0 * * ?';
        System.schedule(
            'Test Stale Batch',
            cronExp,
            new StaleApplicationBatch()
        );
        Test.stopTest();

        List<CronTrigger> jobs = [
            SELECT Id FROM CronTrigger
            WHERE CronJobDetail.Name = 'Test Stale Batch'
        ];
        System.assertEquals(
            1,
            jobs.size(),
            'Batch job should be scheduled'
        );
    }
}