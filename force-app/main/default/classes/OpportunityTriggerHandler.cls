public class OpportunityTriggerHandler {
    //when opportunity created, if amount is between 100000 to 500000 then populate description as Hot Opportunity
    public static void populateDescription(List<Opportunity> oppList){
        for(Opportunity opp : oppList){
            if(opp.Amount != null && opp.Amount >= 100000 && opp.Amount <= 500000){
                opp.Description = 'Hot Opportunity';
            }
        }
    }
    
    public static void updateDesBasedOnStage(List<Opportunity> oppList, Map<Id,Opportunity> oldOpp){
        
        for(Opportunity opp : oppList){
            if(oldOpp == null || opp.StageName != oldOpp.get(opp.Id).StageName){
                if(opp.StageName == 'Closed Won'){
                    opp.Description = 'Opportunity is closed won';
                }
                else if(opp.StageName == 'Closed Lost'){
                    opp.Description = 'Opportunity is closed lost';
                }
                else{
                    opp.Description = 'Opportunity is open';
                }
            }
        }
    }
    
}