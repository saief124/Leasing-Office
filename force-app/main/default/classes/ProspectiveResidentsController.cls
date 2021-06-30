public class ProspectiveResidentsController {
	
    @AuraEnabled
    public static Contact createContact(Contact contact){
        insert contact;
        return contact;
    }
    
    @AuraEnabled
    public static Offer__c createOffer(Offer__c offer){
        insert offer;
        return offer;
    }
    
    @AuraEnabled
    public static List<Contact> getContacts(){
        List<Contact> conList = [SELECT Name FROM Contact];
        return conList;
    }
    
    @AuraEnabled
    public static List<Property__c> getHouses(){
        List<Property__c> propList = [SELECT Name FROM Property__c];
        return propList;
    }
}