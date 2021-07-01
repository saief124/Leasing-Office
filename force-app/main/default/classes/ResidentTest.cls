@isTest
public class ResidentTest {
    @TestSetup
    public static void makeData(){
        String userFN = Userinfo.getFirstName();
        String userLN = Userinfo.getLastName();
        date mydate = date.parse('05/11/2012');
        Resident__c resid= new Resident__c();
        resid.First_Name__c=userFN;
        resid.Phone__c= '0123456789';
        resid.Birthdate__c= mydate;
        resid.Last_Name__c=userLN;
        resid.Name= userFN +' '+ userLn;
        insert resid;
    }
    
      @isTest
     public static void testName(){
         String username = Userinfo.getFirstName();
         List<String> user= new List<String>();
         user.add(username);
         Test.startTest();
         List<ID> userB= Residents.getResidents();
         String myst= [SELECT First_NAME__c FROM Resident__c WHERE ID IN : userB LIMIT 1].First_Name__c;
         Test.stopTest();
         system.assertEquals(username, myst) ;}

}