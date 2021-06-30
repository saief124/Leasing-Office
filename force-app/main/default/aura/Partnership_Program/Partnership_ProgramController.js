({
    
    doInit : function(component, event, helper) {
        helper.loadBuildingStatus(component);
    },
    
    goToPrevious : function(component, event, helper){
        helper.getPrevious();
        helper.setViewIteratorValue(component);
    },
    
    goToNext : function(component, event, helper){
        helper.validateUserInputAndNext(component);
    },
    
    submit: function(component, event, helper){
        helper.submitNewPartnershipRequest(component);
    },
    submitNewRequest: function(component, event, helper){
        helper.resetAllValues(component);
    },
    
    valiateName: function(component, event, helper){
        helper.validateName(component);
    },
    
    valiateEmail: function(component, event, helper){
        helper.validateEmail(component);
    },
    
    validatePhoneNumber: function(component, event, helper){
        helper.validatePhoneNumber(component);
    },
    
    validateAddress: function(component, event, helper){
        helper.validateAddress(component);
    },
    
     validateCity: function(component, event, helper){
        helper.validateCity(component);
    },
    
     validateState: function(component, event, helper){
        helper.validateState(component);
    },
    
     validateZipCode: function(component, event, helper){
        helper.validateZipCode(component);
    },
    
    validateYearBuilt: function(component, event, helper){
        helper.validateYearBuilt(component);
    },
    
      validateYearsOwn: function(component, event, helper){
        helper.validateYearsOwn(component);
    },
    
     validateBuildingStatus: function(component, event, helper){
        helper.validateBuildingStatus(component);
    },
})