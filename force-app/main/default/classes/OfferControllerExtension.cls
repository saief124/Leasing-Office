public with sharing class OfferControllerExtension {
    
    public Offer__c offer{get;set;}
    public String fname{get;set;}
    public String lname{get;set;}
    public String email{get;set;}
    
    public OfferControllerExtension(ApexPages.StandardController stdController) {
		this.offer = new Offer__c();
    }
    
    public PageReference saveOffer() {
        // find or create contact
        String fullName = this.fname + ' ' + this.lname;
        List<Contact> cons = [SELECT Id FROM Contact WHERE Name=:fullName LIMIT 1];
        if (cons.size() > 0) {
            // contact exists
            this.offer.Contact__c = cons[0].Id;
        }
        else {
            // no contact, create one
            if (this.email.length() == 0) {
                Contact c = new Contact(FirstName=this.fname, LastName=this.lname);
                insert c;
                this.offer.Contact__c = c.Id;
            } else {
                Contact c = new Contact(FirstName=this.fname, LastName=this.lname, Email=this.email);
                insert c;
                this.offer.Contact__c = c.Id;
            }
        }
        // Get id of property, set it to the offer's property id
        String propId = ApexPages.currentPage().getParameters().get('propId');
        this.offer.Property__c = propId;
        insert this.offer;
        system.debug('success in offer submittal');
        
        PageReference listings = Page.AvailablePropertiesPage;
        listings.setRedirect(true);
        
        return listings;
    }
    
    public PageReference viewListings() {
        PageReference listings = Page.AvailablePropertiesPage;
        listings.setRedirect(true);
        
        return listings;
    }
    
}