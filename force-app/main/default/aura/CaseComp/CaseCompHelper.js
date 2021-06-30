({
	getCases : function(component) {
        //Name, Date_Opened__c, House__c, Cost__c, Status__c
        console.log('In getCases');
        component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text', sortable: "True"},
            {label: 'Subject', fieldName: 'Subject', type: 'text', sortable: "True"},
            {label: 'Date Opened', fieldName: 'Date_Opened', type: 'date', sortable: "True"},
            {label: 'House', fieldName: 'House_Name', type: 'text', sortable: "True"},
            {label: 'Priority', fieldName: 'Priority', type: 'text', sortable: "True"},
            {label: 'Status', fieldName: 'Status', type: 'text', sortable: "True"}
        ]);
		let action = component.get("c.getCases");
        action.setParams({orderBy:'Priority', sortDirection:'asc'});
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
        let action = component.get("c.getCases");
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

}
})