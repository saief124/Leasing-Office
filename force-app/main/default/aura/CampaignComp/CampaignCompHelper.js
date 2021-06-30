({
	getCampaigns : function(component) {
        //Name, Date_Opened__c, House__c, Cost__c, Status__c
        console.log('In getCampaigns');
        component.set('v.columns', [
            //Id, Name, StartDate, EndDate, NumberOfResponses, ExpectedRevenue, BudgetedCost, ActualRevenue__c, ActualCost, Type, Status
            {label: 'Name', fieldName: 'Name', type: 'text', sortable: "True"},
            {label: 'Start Date', fieldName: 'StartDate', type: 'date', sortable: "True", editable: "True"},
            {label: 'Start Date', fieldName: 'StartDate', type: 'date', sortable: "True", editable: "True"},
            {label: 'Expected Revenue', fieldName: 'ExpectedRevenue', type: 'currency', sortable: "True", editable: "True"},
            {label: 'Budgeted Cost', fieldName: 'BudgetedCost', type: 'currency', sortable: "True", editable: "True"},
            {label: 'Actual Revenue', fieldName: 'ActualRevenue__c', type: 'currency', sortable: "True", editable: "True"},
            {label: 'Actual Cost', fieldName: 'ActualCost', type: 'currency', sortable: "True", editable: "True"},
            {label: 'Type', fieldName: 'Type', type: 'text', sortable: "True", editable: "True"},
            {label: 'Status', fieldName: 'Status', type: 'text', sortable: "True", editable: "True"}
        ]);
		let action = component.get("c.getCampaigns");
        action.setParams({orderBy:'Status', sortDirection:'asc'});
        action.setCallback(this,function(response){
            let state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
               let result = response.getReturnValue();
                console.log(result);
                component.set("v.repairs", result);
            }
        });
       $A.enqueueAction(action);
        
        
    },
    getUpdatedSorting : function(component, event, helper){
 	    console.log('In getupdated sorting');
        let action = component.get("c.getCampaigns");
    	let fieldName = event.getParam('fieldName');
        let sortDirection = event.getParam('sortDirection');
        component.set("v.sortedBy", fieldName);
		component.set("v.sortedDirection", sortDirection)
    	action.setParams({orderBy:fieldName, sortDirection:sortDirection});
		
        
        //Actually returns sorted content
        action.setCallback(this,function(response){
            let state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
               let result = response.getReturnValue();
                console.log(result);
                console.log(fieldName);
                console.log(sortDirection);
                component.set("v.repairs", result);
            }
        });
       $A.enqueueAction(action);   

	},
    saveData : function(component, event, helper) {
        let draftValues = event.getParam('draftValues');
        let action = component.get('c.updateCampaigns');
        action.setParams({'custCampaigns' : draftValues});
        action.setCallback(this, function(response){
            let state = response.getState();
            location.reload();
        });
        $A.enqueueAction(action);
    }
})