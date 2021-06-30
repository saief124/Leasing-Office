public class Residents {
    

    
    @AuraEnabled
    public static List<ID> getResidents(){
            String userFN = Userinfo.getFirstName();
    		String userLN = Userinfo.getLastName();
        if(!Schema.SObjectType.Resident__c.isAccessible()){
            throw new AuraHandledException('You need to be a resident to access this page');
        }
        List<Resident__c> residents= [SELECT ID FROM Resident__c WHERE First_Name__c = :userFn LIMIT 1];
        List<ID> ids = new List<ID>();
          for (Resident__c res : residents) {
      		ids.add(res.ID);
    }
        return ids;
    }
    
    
    public Resident__c res {get{
        	String userFN = Userinfo.getFirstName();
    		String userLN = Userinfo.getLastName();
        return [SELECT First_Name__c, Last_Name__c, Lease__r.Name, Lease__r.Start_Date__c,
                                        Lease__r.End_Date__c, Lease__r.Rent__c FROM Resident__c WHERE First_Name__c = :userFN 
                                       AND Last_Name__c = :userLN LIMIT 1];}}
	
}