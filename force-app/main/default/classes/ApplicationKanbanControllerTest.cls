@isTest
public class ApplicationKanbanControllerTest {

    @TestSetup
    static void setupTestData() {
        Company__c comp = TestDataFactory.createCompany(true);
        Job__c job = TestDataFactory.createJob(comp.Id, true);
        TestDataFactory.createApplication(job.Id, comp.Id, true);
    }

    @isTest
    static void testGetApplications() {
        Test.startTest();
        List<Application__c> apps =
            ApplicationKanbanController.getApplications();
        Test.stopTest();

        System.assertNotEquals(
            0,
            apps.size(),
            'Should return at least 1 application'
        );
        System.assertEquals(
            'Applied',
            apps[0].Status__c,
            'Default status should be Applied'
        );
    }

    @isTest
    static void testGetApplicationsFields() {
        Test.startTest();
        List<Application__c> apps =
            ApplicationKanbanController.getApplications();
        Test.stopTest();

        // Verify related fields are returned
        System.assertNotEquals(
            null,
            apps[0].Company__r.Name,
            'Company name should be returned'
        );
        System.assertNotEquals(
            null,
            apps[0].Job__r.Name,
            'Job name should be returned'
        );
    }
}