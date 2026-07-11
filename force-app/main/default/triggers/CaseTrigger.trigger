trigger CaseTrigger on Case (after insert) {
	CaseTriggerHandler.populateCaseNumberOnAccount(Trigger.new);
}