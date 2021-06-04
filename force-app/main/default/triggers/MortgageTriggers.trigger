trigger MortgageTriggers on Mortgage__c (before delete) {
    for(Mortgage__c mortgage : [SELECT Id, Remaining_Balance__c FROM Mortgage__c WHERE Id IN :Trigger.old]){
        if(mortgage.Remaining_Balance__c > 0){
            Trigger.oldMap.get(mortgage.Id).addError('Cannot delete mortgage with remaining balance');
        }
    }

}