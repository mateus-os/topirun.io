/**
 * @author mateus-os
 */
public class GetAccountGeolocationAddressOutbound {
    public static final String ENDPOINT_URL = 'https://bisso-topirun-20-dev-ed.my.salesforce.com/services/apexrest/api/account/geolocation';

    GeolocalizationAddressTransformer transformer;

    public GetAccountGeolocationAddressOutbound(){
        transformer = new GeolocalizationAddressTransformer();
    }

    public List<Account> getAccountGeolocation(List<Account> accounts) {
        Http http = new Http();
        
        SalesforceAuthService serviceToken = new SalesforceAuthService();
        SalesforceAuthToken token = serviceToken.getToken();

        HttpResponse response = http.send( buildRequest(accounts, token));

        if(response.getStatusCode() != 200) {
            return accounts;
        }
        List<GeolocalizationAddressResponse> payload = (List<GeolocalizationAddressResponse>)
                                JSON.deserializeStrict(response.getBody(), List<GeolocalizationAddressResponse>.class);
        return transformer.toAccounts(payload);
    }

    private HttpRequest buildRequest (List<Account> accounts, SalesforceAuthToken token) {    
        HttpRequest request = new HttpRequest ();
        request.setEndpoint(ENDPOINT_URL);
        request.setMethod('PATCH');
        request.setHeader('Authorization', token.token_type+' '+token.access_token);
        request.setHeader('Content-Type', 'application/json');

        ExternalAccountIds geolocalizationRequestIds = transformer.toExternalAccountIds(accounts);
        String payload = JSON.serialize(geolocalizationRequestIds);

        request.setBody(payload);

        return request;
    }
}