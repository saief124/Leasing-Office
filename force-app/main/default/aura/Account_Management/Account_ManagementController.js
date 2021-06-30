({
	doInit : function(component, event, helper) {
        console.log(component.get("v.action"))
		let getRes = component.get("c.getResidents")
        getRes.setCallback(this, function(response){
            
            if(response.getState()=='SUCCESS'){
                component.set("v.resi", response.getReturnValue());
            }
        })
        $A.enqueueAction(getRes)
	}
})