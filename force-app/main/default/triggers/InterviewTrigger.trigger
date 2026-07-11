trigger InterviewTrigger on Interview__c (after update) {
	InterviewTriggerHandler.updateApplicationStatus(Trigger.new, Trigger.oldMap);
}