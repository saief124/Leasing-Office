trigger ResidentTriggers on Resident__c (before delete) {
    for(Resident__c resident : [SELECT Id, Lease__c FROM Resident__c WHERE Id IN :Trigger.old]){
        if(resident.Lease__c != null){
            Trigger.oldMap.get(resident.Id).addError('Cannot delete user with an active lease');
        }
    }
}