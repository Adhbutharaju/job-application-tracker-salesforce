trigger AccountTrigger on Account (before insert, before update) {
    
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            //AccountTriggerHandler.populateRating(Trigger.new);
    		//AccountTriggerHandler.populateDescription(Trigger.new);
    		//AccountTriggerHandler.copyBillingToShipping(Trigger.new);
        }
        else if(Trigger.isAfter){
            //AccountTriggerHandler.createRelatedContact(Trigger.new);
             //AccountTriggerHandler.createRelatedOpp(Trigger.new);
        }
    }
    
    if(Trigger.isUpdate){
        System.debug('===== Account Trigger Fired =====');
        if(Trigger.isBefore){
             System.debug('===== Before Update =====');
           // AccountTriggerHandler.updateAccDes(Trigger.new, Trigger.oldMap);
        }
    }
}