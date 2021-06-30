@isTest
public class CaseControllerTest {
	@testSetup
    public static void makeData(){
        House__c myHouse = new House__c();
        myHouse.Name = 'My test house1';
        insert myHouse;
        
        myHouse = new House__c();
        myHouse.Name = 'My test house2';
        insert myHouse;
        
        List<House__c> added_house = [SELECT id FROM House__c];
        List<Case> cases = new List<Case>();
            Case newCase = new Case();
            newCase.Subject = 'This is test 1';
            newCase.House__c = added_house[0].Id;
            newCase.Priority = 'Low';
            newCase.Status = 'Planned';
        cases.add(newCase);
        
       newCase = new Case();
            newCase.Subject = 'This is test 2';
            newCase.House__c = added_house[1].Id;
            newCase.Priority = 'Medium';
            newCase.Status = 'Completed';
        cases.add(newCase);
        
        newCase = new Case();
            newCase.Subject = 'This is test 3';
            newCase.House__c = added_house[1].Id;
            newCase.Priority = 'High';
            newCase.Status = 'Closed';
        cases.add(newCase);
        insert cases;
    }
    
    @isTest
    public static void testGetCases(){
        System.assertEquals(2, CaseController.getCases('Name', 'Asc').size());
    }
    
    @isTest
    public static void testGetCasesSoted(){
        System.assertEquals('This is test 1', CaseController.getCases('Name', 'Asc')[0].Subject);
        System.assertEquals([SELECT Id FROM Case WHERE Status != 'Closed' Order By Id Asc LIMIT 1].Id, CaseController.getCases('Id', 'Asc')[0].Id);
        System.assertEquals([SELECT CreatedDate FROM Case WHERE Status != 'Closed' Order By CreatedDate asc LIMIT 1].Id, CaseController.getCases('Date_Opened', 'Asc')[0].Id);
        System.assertEquals('Medium', CaseController.getCases('Priority', 'Asc')[0].Priority);  // high isn't part of the because it was closed
        System.assertEquals('Completed', CaseController.getCases('Status', 'Asc')[0].Status);
        System.assertEquals('My test house1', CaseController.getCases('House_Name', 'Asc')[0].House_Name);
    }
    
}