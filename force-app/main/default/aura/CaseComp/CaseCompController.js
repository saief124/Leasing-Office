({
    doInit : function(component, event, helper) {
        console.log('In controller');
        helper.getCases(component);
        helper.getUpdatedSorting(component, event, helper);
    },
    updateSorting : function(component, event, helper) {
        console.log('In updateSorting');
        helper.getUpdatedSorting(component, event, helper);
    }
})