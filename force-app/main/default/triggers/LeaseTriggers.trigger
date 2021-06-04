trigger LeaseTriggers on Lease__c (after insert) {
    for(Lease__c lease : [SELECT Id, Resident__c, House__c FROM Lease__c WHERE Id IN :Trigger.New]){
        
    }
}