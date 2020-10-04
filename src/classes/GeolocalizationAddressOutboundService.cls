/**
 * @author mateus-os
 */
public class GeolocalizationAddressOutboundService {
    public static final String ENDPOINT_URL = 'https://bisso-topirun-20-dev-ed.my.salesforce.com/services/apexrest/api/account/geolocation';

    GeolocalizationAddressTransformer transformer;

    public GeolocalizationAddressOutboundService(){
        transformer = new GeolocalizationAddressTransformer();
    }

    public Account sendToGeolocalizationSystem(Account account, SalesforceAuthToken token) {
        Http http = new Http();

        HttpResponse response = http.send( buildRequest(account, token));

        if(response.getStatusCode() != 200) {
            List<GeolocalizationAddressErrorResponse> errors = (List<GeolocalizationAddressErrorResponse>)
                                JSON.deserializeStrict(response.getBody(), List<GeolocalizationAddressErrorResponse>.class);
            account.GeolocationErrorMessage__c = errors[0].message;
            Account.GeolocationRequested__c = false;
            return account;
        }
        account.GeolocationErrorMessage__c = '';
        Account.GeolocationRequested__c = true;
        return account;
    }

    private HttpRequest buildRequest (Account account, SalesforceAuthToken token) {    
        HttpRequest request = new HttpRequest ();
        request.setEndpoint(ENDPOINT_URL);
        request.setMethod('PUT');
        request.setHeader('Authorization', token.token_type+' '+token.access_token);
        request.setHeader('Content-Type', 'application/json');

        GeolocalizationAddressRequest geolocalizationRequest = transformer.toGeolocalizationAddressRequest(account);

        String payload = JSON.serialize(geolocalizationRequest);

        request.setBody(payload);

        return request;
    }
}