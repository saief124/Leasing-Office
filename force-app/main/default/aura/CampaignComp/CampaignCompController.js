({
	doInit : function(component, event, helper) {
        helper.getCampaigns(component);
        helper.getUpdatedSorting(component, event, helper);
    },
    updateSorting : function(component, event, helper) {
        helper.getUpdatedSorting(component, event, helper);
    },
    handleSave : function(component, event, helper) {
        helper.saveData(component, event, helper);
    }
    

})