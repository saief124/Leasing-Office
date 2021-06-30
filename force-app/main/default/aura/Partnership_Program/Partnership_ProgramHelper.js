({
    iterator:0,
    PartnershipRequest :{
        name:'',
        email:'',
        phone:'',
        address:'',
        city:'',
        states:[
            'AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA',
            'GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA',
            'MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND',
            'MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT',
            'VT','VI','VA','WA','WV','WI','WY'
        ],
        stateSelected:'',
        zipCode:'',
        yearBuilt:'',
        yearsOwn:'',
        buildStatuses: [],
        buildingStatusSelected:''
    },
    
    getIterator: function() {
        return this.iterator;
    },
    
    resetIterator: function(){
        this.iterator = 1;
    },
    
    getNext: function(){
        if(this.iterator < 4){
            this.iterator += 1;
        }
        return this.iterator;
    },
    
    getPrevious: function(){
        if(this.iterator > 0){
            this.iterator -= 1;
        }
        return this.iterator;
    },
    
    getPartnershipRequest: function(){
        return this.PartnershipRequest        
    },
    
    loadBuildingStatus: function(component){
        let retrivePickListValuesFromApexController = "c.retrivePickListValuesIntoList";
        let action = component.get(retrivePickListValuesFromApexController);
        action.setCallback(this,function(response){
            let state = response.getState();
            if(state == "SUCCESS"){
                let result = response.getReturnValue();
                this.PartnershipRequest['buildStatuses'] = result;
                this.setViewIteratorValue(component);
            }else if(state == "ERROR"){
                throw Exception("An unexpected error has occured");
            }
            
        });
        $A.enqueueAction(action);
    },
    
    loadPartnershipRequest: function(component){
        component.set("v.PartnershipRequest", this.PartnershipRequest)
    },
    
    resetAllValues: function(component){
        this.resetIterator();
        let iterator = this.getIterator();
        component.set("v.iterator", iterator);
        this.loadPartnershipRequest(component);
    },
    
    setViewIteratorValue: function(component){
        let iterator = this.getIterator();
        component.set("v.iterator", iterator);
        this.loadPartnershipRequest(component);
    },
    
    submitNewPartnershipRequest: function(component){
        let isValid = this.validateBuildingInfoBeforeProceeding(component);
        if(isValid){
            let entity = this.PartnershipRequest;
            let action = component.get('c.savePartnershipProgramData');
            action.setParams({
                name: entity.name,
                email: entity.email,
                phone: entity.phone,
                address: entity.address,
                city: entity.city,
                stateSelected: entity.stateSelected,
                zipCode: entity.zipCode,
                yearBuilt: entity.yearBuilt,
                yearsOwn: entity.yearsOwn,
                buildingStatusSelected: entity.buildingStatusSelected
            })
            action.setCallback(this, function(response){
                let responseState = response.getState();
                console.log(responseState);
                if(responseState == 'SUCCESS'){
                    component.set("v.errors", "")
                    this.PartnershipRequest = this.resetDataModel();
                    this.loadBuildingStatus(component);
                    this.getNext();
                    this.setViewIteratorValue(component);
                }else if(responseState == 'ERROR'){
                    component.set("v.errors", "Please make sure you provided valid information")
                }
            });
            $A.enqueueAction(action);  
        }
    },
    
    validateUserInputAndNext: function(component){
        let iterator = this.getIterator();
        switch(iterator){
            case 1:
                this.validatePersonalInfoBeforeProceeding(component);
                break;
            case 2:
                this.validateAddressInfoBeforeProceeding(component);
                break;
            default:
                this.setViewIteratorValue(component);
                this.getNext();
        }
        this.setViewIteratorValue(component);
    },
    
    // validate personal information
    validatePersonalInfoBeforeProceeding:function(component){
        
        let nameIsValid = this.validateName(component);
        
        let emailIsInvalid = this.validateEmail(component);
        
        let phoneIsInvalid = this.validatePhoneNumber(component);
        
        if(nameIsValid && !emailIsInvalid && !phoneIsInvalid){
            this.getNext();
            this.setViewIteratorValue(component);
        }
    },
    
    // validate address information
    validateAddressInfoBeforeProceeding:function(component){
        let addressIsInValid = this.validateAddress(component);
        
        let cityIsInValid = this.validateCity(component);
        
        let stateIsInValid =  this.validateState(component);
        
        let zipCodeIsValid= this.validateZipCode(component);
        
        if(!addressIsInValid && !cityIsInValid && !stateIsInValid && zipCodeIsValid){
            this.getNext();
            this.setViewIteratorValue(component);
        }
        
    },
    // validate building information
    validateBuildingInfoBeforeProceeding:function(component){
        let yearBuiltIsValid = this.validateYearBuilt(component);
        
        let yearsOwnIsInValid = this.validateYearsOwn(component);
        
        let statusIsInValid = this.validateBuildingStatus(component);
        
        let validDates = this.validateBuildYearAndYearOwned(component);
        
        return validDates &&  yearBuiltIsValid && !yearsOwnIsInValid && !statusIsInValid;
        
    },
    
    validateName: function(component){
        let nameCmp = component.find("name");
        let nameValue = nameCmp.get("v.value");
        let nameIsValid = nameValue.length >= 2
        if (nameIsValid) { nameCmp.setCustomValidity("");} else {nameCmp.setCustomValidity("Name field cannot be empty.");}
        nameCmp.reportValidity();
        return nameIsValid;
    },
    
    validateEmail: function(component){
        // email
        let emailComp = component.find("email");
        let emailValue = emailComp.get("v.value");
        let regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;           
        let emailIsInvalid = !emailValue.match(regExpEmailformat)
        if(emailIsInvalid){ emailComp.setCustomValidity("Email must be valid.");}else{emailComp.setCustomValidity("");}
        emailComp.reportValidity();
        return emailIsInvalid;
    },
    
    validatePhoneNumber: function(component){
        let phoneCmp = component.find("phone");
        let phoneValue = phoneCmp.get("v.value");
        let regExpPhoneformat = /^[(]{0,1}[0-9]{3}[)]{0,1}[-\s\.]{0,1}[0-9]{3}[-\s\.]{0,1}[0-9]{4}$/
        let phoneIsInValid = !regExpPhoneformat.test(phoneValue)
        if (phoneIsInValid) { phoneCmp.setCustomValidity("Please provide a valid phone number.");} else {phoneCmp.setCustomValidity("");}
        phoneCmp.reportValidity();
        return phoneIsInValid;
    },
    
    validateAddress: function(component){
        let addressCmp = component.find("address");
        let addressValue = addressCmp.get("v.value");
        let regExAddressFormat = /^\s*\S+(?:\s+\S+){2}/
        let addressIsInValid = !regExAddressFormat.test(addressValue)
        if (addressIsInValid) { addressCmp.setCustomValidity("Please enter a valid street address.");} else {addressCmp.setCustomValidity("");}
        addressCmp.reportValidity();
        return addressIsInValid;
    },
    
    validateCity: function(component){
        let cityCmp = component.find("city");
        let cityValue = cityCmp.get("v.value");
        let regExCityFormat = '^[a-zA-Z]+(?:(?:\\s+|-)[a-zA-Z]+)*$'
        let cityIsInValid = !cityValue.match(regExCityFormat)
        if (cityIsInValid) { cityCmp.setCustomValidity("Please enter a valid city name.");} else {cityCmp.setCustomValidity("");}
        cityCmp.reportValidity();
        return cityIsInValid;
    },
    
    validateState: function(component){
        let stateValue = component.find("stateId").get("v.value");
        let stateIsInValid = stateValue === '';
        if (stateIsInValid) { 
            component.set('v.stateError','Please select a state');
        } else { component.set('v.stateError','');}
        return stateIsInValid;
    },
    
    validateZipCode: function(component){
        let zipCodeCmp = component.find("zipCode");
        let zipCodeValue = zipCodeCmp.get("v.value").trim();
        let regExZipCodeFormat =  /(^\d{5}$)|(^\d{5}-\d{4}$)/
        let zipCodeIsValid = regExZipCodeFormat.test(zipCodeValue)
        if (zipCodeIsValid) { zipCodeCmp.setCustomValidity("");} else {zipCodeCmp.setCustomValidity("Please enter a valid zip code.");}
        zipCodeCmp.reportValidity();
        return zipCodeIsValid;
    },
    
    validateYearBuilt: function(component){
        let yearBuiltCmp = component.find("yearBuilt");
        let yearBuiltValue = yearBuiltCmp.get("v.value");
        let year = new Date().getFullYear() - 1;
        let yearFromStringToInteger = parseInt(yearBuiltValue)
        let regExYearBuiltFormat = /^\d+$/ 
        let yearBuiltIsValid = !(!yearBuiltValue.match(regExYearBuiltFormat)) && yearFromStringToInteger >= 1800 && yearFromStringToInteger <= year;
        if (!yearBuiltIsValid) { yearBuiltCmp.setCustomValidity(`Please enter a valid year (1800 - ${year})`);} else {yearBuiltCmp.setCustomValidity("");}
        yearBuiltCmp.reportValidity();
        return yearBuiltIsValid;
    },
    
    validateYearsOwn: function(component){
        let yearsOwnCmp = component.find("yearsOwn");
        let yearsOwnValue = yearsOwnCmp.get("v.value");
        let regExYearsOwnFormat = '^0*(?:[0-9][0-9]?|99)$'
        let yearsOwnIsInValid = !yearsOwnValue.match(regExYearsOwnFormat)
        if (yearsOwnIsInValid) { yearsOwnCmp.setCustomValidity("Please enter a valid number (1 - 99)");} else {yearsOwnCmp.setCustomValidity("");}
        yearsOwnCmp.reportValidity();
        return yearsOwnIsInValid;
    },
    
    validateBuildingStatus: function(component){
        let statusValue = component.find("status").get("v.value");
        let statusIsInValid = statusValue === '';
        if (statusIsInValid) { 
            component.set('v.buildingStatusError','Please select building status');
        } else { component.set('v.buildingStatusError','');}
        return statusIsInValid;
    },
    
    validateBuildYearAndYearOwned: function(component){
        let yearBuiltValue = component.find("yearBuilt").get("v.value");
        let yearsOwnValue = component.find("yearsOwn").get("v.value");
        if(yearBuiltValue !== '' && yearsOwnValue !== ''){
            let result = parseInt(yearBuiltValue) + parseInt(yearsOwnValue);
           let year = new Date().getFullYear();
            if(result > year){
                component.set('v.errors', 'There\'s no way you owned this property before it was built.')
                return false;
            }else{
                component.set('v.errors', '');
            }
        }
        return true;
    },
    
    resetDataModel: function(){
        return {
            name:'',
            email:'',
            phone:'',
            address:'',
            city:'',
            states:[
                'AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA',
                'GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA',
                'MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND',
                'MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT',
                'VT','VI','VA','WA','WV','WI','WY'
            ],
            stateSelected:'',
            zipCode:'',
            yearBuilt:'',
            yearsOwn:'',
            buildStatuses: [],
            buildingStatusSelected:''
            
        }
    }
})