public class CampaignController {
    @AuraEnabled
    public static List<Campaign> getCampaigns(String orderBy, String sortDirection){
        List<Campaign> dbCampaigns = Database.query('SELECT Id, Name, StartDate, EndDate, NumberOfResponses, ExpectedRevenue, BudgetedCost, ActualRevenue__c, ActualCost, Type, Status FROM Campaign' 
                                                            + ' WHERE Status !=\'Aborted\' '
                                                           + ' ORDER BY '+ orderBy + ' ' + sortDirection);
        return dbCampaigns;
    }
    @AuraEnabled
    public static void updateCampaigns(List<Campaign> custCampaigns) {
        update custCampaigns;
    }
}