({
	fireComponentEvent : function(component, event, helper) {
				let ce= component.getEvent("LeaseShowEvent")
				let	param= helper.helperMethod()
                console.log(param)
                ce.setParams({
                    "message": "Some Message"})
		//$A.enqueAction(getLease)
        ce.fire()
	}
	
})