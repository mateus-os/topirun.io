/**
 * @author mateus-os
 */
@SuppressWarnings ('PMD')
public class SalesforceAuthToken {

    public String access_token;
    public String instance_url;
    public String id;
    public String token_type;
    public String issued_at;
    public String signature;

    override
    public String toString(){
        return JSON.serialize(this);
    }
}