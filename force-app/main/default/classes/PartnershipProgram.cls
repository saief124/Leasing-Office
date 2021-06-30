public class PartnershipProgram {
    
    @Auraenabled
    public static List<String> retrivePickListValuesIntoList(){
        List<String> pickListValuesList= new List<String>();
        Schema.DescribeFieldResult fieldResult = Partnership_Request__c.Build_Status__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }     
        return pickListValuesList;
    }
    
    @Auraenabled
    public static OperationResult savePartnershipProgramData(String name, String email, String phone, String address, String city, 
                                                                    String stateSelected, String zipCode,String yearBuilt,String yearsOwn,
                                                                     String buildingStatusSelected){
                                                                                                                               
        try{
              final Partnership_Request__c request = new Partnership_Request__c();
        request.Name = name;
        request.Email__c  = email;
        request.Phone_Number__c = parsePhoneNumber(phone);
        request.Address__c = address;
        request.State__c = stateSelected;
        request.City__c = city;
        request.Build_Status__c = buildingStatusSelected;
        request.Zip_Code__c = zipCode;
        request.Year_Built__c = Decimal.valueOf(yearBuilt);
        request.Years_Owned__c = Decimal.valueOf(yearsOwn);    
     	 insert request;
		 return OperationResult.SUCCESS;
        }catch(Exception ex){
            return OperationResult.FAILURE;
       } 
    }
    
    
    public static String parsePhoneNumber(String phoneNumber){
        String regex = '[a-zA-Z]{1,}|\\-';
        String result = phoneNumber.replaceAll(regex, '');
        return result;
    }
    
    @TestVisible private enum OperationResult{
        SUCCESS, FAILURE
    }
}