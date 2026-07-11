public with sharing class InterviewStatsController {

    // Wrapper class to hold stats data
    public class AppStats {
        @AuraEnabled public String status;
        @AuraEnabled public Integer appCount;

        public AppStats(String status, Integer appCount){
            this.status = status;
            this.appCount = appCount;
        }
    }

    // Returns application count grouped by status
    @AuraEnabled(cacheable=true)
    public static List<AppStats> getApplicationStats(){
        List<AppStats> statsList = new List<AppStats>();

        List<AggregateResult> results = [
            SELECT Status__c, COUNT(Id) total
            FROM Application__c
            GROUP BY Status__c
        ];

        for(AggregateResult ar : results){
            statsList.add(new AppStats(
                (String)ar.get('Status__c'),
                (Integer)ar.get('total')
            ));
        }
        return statsList;
    }

    // Returns total counts summary
    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getSummaryStats(){
        Map<String, Integer> summary = new Map<String, Integer>();

        summary.put('totalApplications', [SELECT COUNT() FROM Application__c]);
        summary.put('totalInterviews', [SELECT COUNT() FROM Interview__c]);
        summary.put('passed', [SELECT COUNT() FROM Interview__c WHERE Outcome__c = 'Passed']);
        summary.put('failed', [SELECT COUNT() FROM Interview__c WHERE Outcome__c = 'Failed']);

        return summary;
    }
}