/**
 * @author mateus-os
 */
public class SendGeolocalizationAddress {

    @future (callout = true)
    public static void sendAddresses(List<String> accountIds ) {
        SalesforceAuthService serviceToken = new SalesforceAuthService();
        SalesforceAuthToken token = serviceToken.getToken();

        AccountRepository repository = new AccountRepository();
        
        List<Account> accounts = repository.findByIds(accountIds);
        
        GeolocalizationAddressOutboundService service;

        for (Account account : accounts) {
            service = new GeolocalizationAddressOutboundService();
            service.sendToGeolocalizationSystem(account, token);
        }

        repository.store(accounts);
    }    
}