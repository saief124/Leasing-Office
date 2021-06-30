public class CaseController {
    @AuraEnabled
    public static List<MyCase> getCases(String orderBy, String sortDirection){
        System.debug('here');
 		orderBy = getNameToSortBy(orderBy);
        List<Case> dbCases = Database.query('SELECT Id, CaseNumber, Subject, CreatedDate, House__r.name, Priority, Status FROM Case ' 
                                                            + 'WHERE Status !=\'Closed\' '
                                                           + 'ORDER BY '+ orderBy + ' ' + sortDirection);
        List<MyCase>  localMyCases = new List<MyCase>();
        for (Case dbCase: dbCases){
            MyCase tmpCase = new MyCase();
            tmpCase.Id = dbCase.Id;
            tmpCase.Name = dbCase.CaseNumber;
            tmpCase.Subject = dbCase.Subject;
            tmpCase.Date_Opened = dbCase.CreatedDate;
            tmpCase.house_name = dbCase.House__r.name;
            tmpCase.priority = dbCase.Priority;
            tmpCase.status = dbCase.Status;
            localMyCases.add(tmpCase);
        }
        
        return localMyCases;
    }
        
    @AuraEnabled
    public static string getNameToSortBy(string repairOrdersName){
        switch on (repairOrdersName) {
            when 'Id'{
                return 'Id';
            }
            when 'Name'{
                return 'CaseNumber';
            }
            when 'Date_Opened'{
                return 'CreatedDate';
            }
            when 'House_Name' {
                return 'House__R.Name';
            }
            when 'Priority' {
                return 'Priority';
            }
            when 'Status' {
                return 'Status';
            }
            when else {
                return repairOrdersName;
            }
        }
    }
    public class MyCase{
        //SELECT Id, Name, CreatedDate, House__r.name, Priority, Status__c 
        @AuraEnabled
        public string Id {get; set;}
        @AuraEnabled
        public string Name {get; set;}
        @AuraEnabled
        public string Subject {get; set;}
        @AuraEnabled
        public datetime Date_Opened {get; set;}
        @AuraEnabled
        public string House_Name {get; set;}
        @AuraEnabled
        public string Priority {get; set;}
        @AuraEnabled
        public string Status {get; set;}
        
    }
 

}