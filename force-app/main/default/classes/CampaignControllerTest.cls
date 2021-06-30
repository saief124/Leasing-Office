@isTest
public class CampaignControllerTest {
	@testSetup
    public static void makeData(){
        List<Campaign> campaigns = new List<Campaign>();
            Campaign newCampain = new Campaign();
            newCampain.Name = 'This is test 1';
            newCampain.StartDate = System.today();
            newCampain.EndDate = System.today();
            newCampain.ExpectedRevenue = 100;
            newCampain.BudgetedCost = 10;
            newCampain.ActualRevenue__c = 0;
            newCampain.Type = 'Webinar';
            newCampain.Status = 'Planned';
        campaigns.add(newCampain);
        
        newCampain = new Campaign();
            newCampain.Name = 'This is test 2';
            newCampain.StartDate = System.today();
            newCampain.EndDate = System.today();
            newCampain.ExpectedRevenue = 100;
            newCampain.BudgetedCost = 10;
            newCampain.ActualRevenue__c = 0;
            newCampain.Type = 'Webinar';
            newCampain.Status = 'Planned';
        campaigns.add(newCampain);
        
        newCampain = new Campaign();
            newCampain.Name = 'This is test 3';
            newCampain.StartDate = System.today();
            newCampain.EndDate = System.today();
            newCampain.ExpectedRevenue = 200;
            newCampain.BudgetedCost = 20;
            newCampain.ActualRevenue__c = 0;
            newCampain.Type = 'Webinar';
            newCampain.Status = 'Aborted';
        campaigns.add(newCampain);
        insert campaigns;
    }
    
    @isTest
    public static void testGetCampaigns(){
        System.assertEquals(2, CampaignController.getCampaigns('Name', 'Asc').size());
    }
    
    @isTest
    public static void testUpdateCampaigns(){
        List<Campaign> campaigns = [SELECT Name, StartDate, EndDate, ExpectedRevenue, BudgetedCost, ActualRevenue__c, Type, Status FROM campaign];
        for (Campaign myCampaign : campaigns){
            myCampaign.ActualRevenue__c = 100;
        }
        
        //actual code to test
        CampaignController.updateCampaigns(campaigns);
        
        List<Campaign> updatedCampaigns = [SELECT Name, StartDate, EndDate, ExpectedRevenue, BudgetedCost, ActualRevenue__c, Type, Status FROM campaign];
        for (Campaign updatedCampaign : updatedCampaigns){
            System.assertEquals(100, updatedCampaign.ActualRevenue__c);
        }
        
    }
    
    
}