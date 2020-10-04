/**
 * @author mateus-os
 */
public class SalesforceAuthService {
    public static final String ENDPOINT_URL = 'https://login.salesforce.com/services/oauth2/token';

    public SalesforceAuthToken getToken() {
        Http http = new Http();

        HttpResponse response = http.send(buildRequest(getOauthParams()));

        if(response.getStatusCode() != 200) {
            return null;
        }

        SalesforceAuthToken token = (SalesforceAuthToken)
        JSON.deserialize(response.getBody(), SalesforceAuthToken.class);
        
        return token;
    }

    public HttpRequest buildRequest ( Map<String,String> oauthRequest) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(ENDPOINT_URL);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        request.setBody ( buildPostFormParameters (oauthRequest) );

        return request;
    }    
    
    private String buildPostFormParameters ( Map<String,String> oauthRequest ) {
    
        String parameters = '';
    
        for ( String parameterName : oauthRequest.keySet() ) {    
            if (oauthRequest.get( parameterName ) == null) continue;
            parameters += parameterName + '=' + EncodingUtil.urlEncode( oauthRequest.get( parameterName ), 'UTF-8') + '&';
        }
    
        return parameters;    
    }

    private Map<String, String> getOauthParams() {
        Map<String, String> oauthParams = new Map<String, String>();

        oauthParams.put('client_id', '3MVG9l2zHsylwlpS6h2vTmlmUGQBhdenOwDRCOFn28Edf9ajwCJ3THJs1OvxrZPVNucENmEJb.7paFUCK3Kqr');
        oauthParams.put('client_secret', 'BFC7A19775AA64B697A6F712F62E2D0A671321BBA2FAE18973580F4557F5FC68');
        oauthParams.put('redirect_uri', 'http://localhost');
        oauthParams.put('grant_type', 'password');
        oauthParams.put('username', 'integration.user@topirun.com');
        oauthParams.put('password', '@TopiRun2020');

        return oauthParams;
    }
}