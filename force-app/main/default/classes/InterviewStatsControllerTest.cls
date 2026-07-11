@isTest
public class InterviewStatsControllerTest {

    @TestSetup
    static void setupTestData() {
        Company__c comp = TestDataFactory.createCompany(true);
        Job__c job = TestDataFactory.createJob(comp.Id, true);
        Application__c app = TestDataFactory.createApplication(
            job.Id, comp.Id, true
        );
        TestDataFactory.createInterview(app.Id, 'Passed', true);
    }

    @isTest
    static void testGetApplicationStats() {
        Test.startTest();
        List<InterviewStatsController.AppStats> stats =
            InterviewStatsController.getApplicationStats();
        Test.stopTest();

        System.assertNotEquals(
            0,
            stats.size(),
            'Should return at least 1 stat'
        );
        System.assertEquals(
            'Applied',
            stats[0].status,
            'First stat should be Applied status'
        );
        System.assertEquals(
            1,
            stats[0].appCount,
            'Should have 1 application'
        );
    }

    @isTest
    static void testGetSummaryStats() {
        Test.startTest();
        Map<String, Integer> summary =
            InterviewStatsController.getSummaryStats();
        Test.stopTest();

        System.assertEquals(
            1,
            summary.get('totalApplications'),
            'Should have 1 total application'
        );
        System.assertEquals(
            1,
            summary.get('totalInterviews'),
            'Should have 1 total interview'
        );
        System.assertEquals(
            1,
            summary.get('passed'),
            'Should have 1 passed interview'
        );
        System.assertEquals(
            0,
            summary.get('failed'),
            'Should have 0 failed interviews'
        );
    }
}