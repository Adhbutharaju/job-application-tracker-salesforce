trigger ContactTrigger on Contact (before insert, before update) {
    
    if(Trigger.isBefore){
        //ContactTriggerHandler.copyEmail(Trigger.new);
    }
}