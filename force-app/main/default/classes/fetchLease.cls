public class fetchLease {
@Auraenabled
    public static List<Lease__c> getLease(){
        String userFN = Userinfo.getFirstName();
       List<Lease__c> lease= [Select Id FROM Lease__c WHERE Resident__r.First_Name__c =: userFN LIMIT 1];
        return lease;
    }
}