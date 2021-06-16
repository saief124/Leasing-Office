public class RepairOrderController {
    String orderBy = 'Status__c';
    Boolean sortAscending = true;
    String ascendingString = 'ASC';
    
    //main logic retrieves all repair orders from database that arent complete
    //the ascendingString is used with other functions to toggle the sort order
    public List<Repair_Order__c> getRepairOrders(){
        if(sortAscending){
            ascendingString = 'ASC';
        }else{
            ascendingString = 'DESC';
        }
        List<Repair_Order__c> repairOrders = Database.query('SELECT Name, Date_Opened__c, House__c, Cost__c, Status__c FROM Repair_Order__c ' 
                                                            + 'WHERE Status__c !=\'Completed\' '
                                                           + 'ORDER BY '+ orderBy + ' ' + ascendingString);
        return repairOrders;
    }
    //these methods change which field the columns sort by. If the field is already slected
    //as the sorting field, it instead flips between ascending and descending order
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
    
 
}