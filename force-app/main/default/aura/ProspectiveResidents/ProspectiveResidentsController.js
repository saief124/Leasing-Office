({
    
    doInit : function(component, event, helper) {
    	let cListAction = component.get("c.getContacts");
        cListAction.setCallback(this, function(response){
           let state = response.getState();
           if(state == 'SUCCESS'){
                let result = response.getReturnValue();
                component.set("v.contactList", result)
            }
        });
        $A.enqueueAction(cListAction);
        let hListAction = component.get("c.getHouses");
        hListAction.setCallback(this, function(response){
           let state = response.getState();
           if(state == 'SUCCESS'){
                var result = response.getReturnValue();
                component.set("v.houseList", result);
           }
        });
        $A.enqueueAction(hListAction);
    },
    
    onContactChange : function(component, event, helper){
        let selectedContact = component.find("contact").get("v.value");
        component.set("v.newOffer.Contact__c", selectedContact);
    },
    
    onHouseChange : function(component, event, helper){
        let selectedHouse = component.find("house").get("v.value");
        component.set("v.newOffer.Property__c", selectedHouse);
    },
    
    handleCreateOffer: function(component, event, helper){
      let offerAction = component.get("c.createOffer");
        console.log(component.find("contact").get("v.value"));
        offerAction.setParams({
            "offer": component.get("v.newOffer")
        });
        offerAction.setCallback(this, function(response){
            let state = response.getState();
            if(state == 'SUCCESS'){
                component.set("v.offerMessage", "Offer submitted successfully!");
            }
        });
        $A.enqueueAction(offerAction);
    },
    
	handleCreateContact : function(component, event, helper) {
		let contactAction = component.get("c.createContact");
        contactAction.setParams({
            "contact": component.get("v.newContact")
        });
        contactAction.setCallback(this, function(response){
            let state = response.getState();                     
        	if(state == "SUCCESS"){
            	component.set("v.contactMessage", "Contact created successfully!");
        	}
        });
    	$A.enqueueAction(contactAction);
	}
})