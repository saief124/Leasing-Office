@isTest
public class PartnershipProgramTest {
    
    
    @isTest static void retrivePickListValuesIntoList() {
        final List<String> result = PartnershipProgram.retrivePickListValuesIntoList();
        system.assertNotEquals(result.size(), 0);
    }
    
    
    @isTest
    static void savePartnershipProgramDataPass() {
        String name = 'test';
        String email= 'test@email.com';
        String phone = '123-123-1234'; 
        String address= '123 Main Street';
        String city= 'New City'; 
        String stateSelected= 'NY'; 
        String zipCode = '12345';
        String yearBuilt= '1900';
        String yearsOwn= '11';
        String buildingStatusSelected = 'New Construction';
        final PartnershipProgram.OperationResult result = PartnershipProgram.savePartnershipProgramData(name, email, phone, address, city, 
                                                                            stateSelected, zipCode, yearBuilt, yearsOwn,
                                                                   buildingStatusSelected);
        system.assertEquals(PartnershipProgram.OperationResult.SUCCESS, result);
    }
    
    @isTest
    static void savePartnershipProgramDataFailed() {
        String name = 'test';
        String email= 'test@email.com';
        String phone = '123-123-1234'; 
        String address= '123 Main Street';
        String city= 'New City'; 
        String stateSelected= 'NY'; 
        String zipCode = '12345';
        String yearBuilt= '1900';
        String yearsOwn= '';
        String buildingStatusSelected = 'New Construction';
        final PartnershipProgram.OperationResult result = PartnershipProgram.savePartnershipProgramData(name, email, phone, address, city, 
                                                                            stateSelected, zipCode, yearBuilt, yearsOwn,
                                                                   buildingStatusSelected);
        system.assertEquals(PartnershipProgram.OperationResult.FAILURE, result);
    }
    
    
}