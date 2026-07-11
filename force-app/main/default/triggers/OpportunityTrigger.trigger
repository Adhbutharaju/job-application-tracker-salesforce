trigger OpportunityTrigger on Opportunity (before insert, before update) {
    
    if(Trigger.isInsert){
        if(Trigger.isBefore){
			//OpportunityTriggerHandler.updateDesBasedOnStage(Trigger.new,null);
        }
    }
    
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
           // OpportunityTriggerHandler.updateDesBasedOnStage(Trigger.new,Trigger.oldMap);
        }
    }
}