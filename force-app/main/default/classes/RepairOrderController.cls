public class RepairOrderController {
    String orderBy = 'Status__c';
    Boolean sortAscending = true;
    String ascendingString = 'ASC';
    
    //main logic retrieves all repair orders from database that arent complete
    //the ascendingString is used with other functions to toggle the sort order
    @AuraEnabled
    public List<Repair_Order__c> getRepairOrders(){
        system.debug('In controller');
        if(sortAscending){
            ascendingString = 'ASC';
        }else{
            ascendingString = 'DESC';
        }
        List<Repair_Order__c> repairOrders = Database.query('SELECT Name, Date_Opened__c, House__R.Name, Cost__c, Status__c FROM Repair_Order__c ' 
                                                            + 'WHERE Status__c !=\'Completed\' '
                                                           + 'ORDER BY '+ orderBy + ' ' + ascendingString);
        return repairOrders;
    }
    @AuraEnabled
    public static List<RepairOrders> getRepairOrdersWithPassing(String orderBy, String sortDirection){
 		orderBy = getNameToSortBy(orderBy);
        List<Repair_Order__c> dbRepairOrders = Database.query('SELECT Id, Name, Date_Opened__c, House__r.name, Cost__c, Status__c FROM Repair_Order__c ' 
                                                            + 'WHERE Status__c !=\'Completed\' '
                                                           + 'ORDER BY '+ orderBy + ' ' + sortDirection);
        List<RepairOrders>  localRepair_order = new List<RepairOrders>();
        for (Repair_Order__c dbRepair_order: dbRepairOrders){
            RepairOrders tmpOrder = new RepairOrders();
            tmpOrder.Id = dbRepair_order.Id;
            tmpOrder.Name = dbRepair_order.name;
            tmpOrder.Date_Opened = dbRepair_order.Date_Opened__c;
            tmpOrder.house_name = dbRepair_order.House__r.name;
            tmpOrder.Cost = dbRepair_order.Cost__c;
            tmpOrder.status = dbRepair_order.Status__c;
            localRepair_order.add(tmpOrder);
        }
        
        return localRepair_order;
    }
    
    public void sortByStatus(){
        if(this.orderBy == 'Status__c'){
            this.sortAscending = !this.sortAscending;
        }else{
        	this.orderBy = 'Status__c';
            this.sortAscending = true;
        }
    }
   public void sortByDate(){
        if(this.orderBy == 'Date_Opened__c'){
            this.sortAscending = !this.sortAscending;
        }else{
        	this.orderBy = 'Date_Opened__c';
            this.sortAscending = true;
        }
    }
    public void sortByHouse(){
        if(this.orderBy == 'House__c'){
            this.sortAscending = !this.sortAscending;
        }else{
        	this.orderBy = 'House__c';
            this.sortAscending = true;
        }
    }
    
    @AuraEnabled
    public static string getNameToSortBy(string repairOrdersName){
        switch on (repairOrdersName) {
            when 'Id'{
                return 'Id';
            }
            when 'Name'{
                return 'Name';
            }
            when 'Date_Opened'{
                return 'Date_Opened__c';
            }
            when 'House_Name' {
                return 'House__R.Name';
            }
            when 'Cost' {
                return 'Cost__c';
            }
            when 'Status' {
                return 'Status__c';
            }
            when else {
                System.debug(repairOrdersName);
                // should not be run, but just in case
                return repairOrdersName;
            }
        }
    }
    public class RepairOrders{
        //SELECT Name, Date_Opened__c, House__R.Name, Cost__c, Status__c
        @AuraEnabled
        public string Id {get; set;}
        @AuraEnabled
        public string Name {get; set;}
        @AuraEnabled
        public datetime Date_Opened {get; set;}
        @AuraEnabled
        public string House_Name {get; set;}
        @AuraEnabled
        public decimal Cost {get; set;}
        @AuraEnabled
        public string Status {get; set;}
        
    }
 
}