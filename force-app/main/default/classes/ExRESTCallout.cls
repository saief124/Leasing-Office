public class ExRESTCallout
{ 
    public static String makeCallout()
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/pikachu');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200)
        {
            Map<String,Object> respMap = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            String name = String.valueOf(respMap.get('name'));
            system.debug(name);
            List<Object> abilities = (List<Object>) respMap.get('abilities');
            List<Object> stats = (List<Object>) respMap.get('stats');
            Map<String,Object> baseHPstats = (Map<String,Object>)stats.get(0);
            Integer baseHP = (Integer) baseHPstats.get('0');
            System.debug(baseHP);
        }
        return null;
    }
}