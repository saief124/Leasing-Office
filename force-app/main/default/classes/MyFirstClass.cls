public with sharing class MyFirstClass {
    public MyFirstClass() {

                //Apex is salesforce's proprietary prgroamminglanguage created in 2007.
                //it is case-insensitive, cloud hosted, Java-like
                // multi-tenant aware, object oriented, strongly typed
                //tightly-integrated, versioned
        
                //why apex? declarative isnt alwats enough
        
                //it is case-insenstive, but code like it isnt for good habits
        
                integer a = 3;
                integer b = 4;
                integer c = A+B;
                //string literals "one" and "One" are of course consdiered different
                //when evaluating equality, but variable one can be called as One.
                List<Account> accList = [SELECT Name FROM Account];
                System.debug(accList);
                for(Account ac : accList){
                    System.debug(ac.Name);
                }
                //Stongly typed: cant convert between unrelated data types
                /*multiline comments like this
                end it the same way
                */
            
    }
}