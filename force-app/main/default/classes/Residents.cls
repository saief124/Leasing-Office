public class Residents {
    
    private String userFN = Userinfo.getFirstName();
    private String userLN = Userinfo.getLastName();
    
    public Resident__c res {get{return [SELECT First_Name__c, Last_Name__c, Lease__r.Name FROM Resident__c WHERE First_Name__c = :userFN 
                                       AND Last_Name__c = :userLN LIMIT 1];}}

}