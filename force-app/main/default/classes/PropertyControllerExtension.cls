public with sharing class PropertyControllerExtension {
    public String propIdChosen{get;set;}
        
    public PropertyControllerExtension(ApexPages.StandardSetController stdController) {
		
    }
    
    public PageReference makeOffer() {
        Property__c propToMakeOfferOn = [SELECT Id FROM Property__c WHERE Id=:propIdChosen LIMIT 1];
        
        PageReference makeOfferPage = Page.MakeOffer;
        makeOfferPage.setRedirect(true);
        makeOfferPage.getParameters().put('propId',propIdChosen);
        
        return makeOfferPage;
    }
    
    
}