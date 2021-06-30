({
	handleError : function(component, event, helper) {
		component.find('notifLib').showToast({
            "title": "Something has gone wrong!",
            "message": event.getParam("message"),
            "variant": "error"
        });
	},
    refresh : function(component, event, helper) {
       location.reload();
    }
})