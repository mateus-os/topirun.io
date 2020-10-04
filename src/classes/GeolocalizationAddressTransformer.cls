/**
 * @author mateus-os
 */
public class GeolocalizationAddressTransformer {

    public GeolocalizationAddressRequest toGeolocalizationAddressRequest(Account account) {

        GeolocalizationAddressRequest request = new GeolocalizationAddressRequest();

        request.name = Account.Name;
        request.externalId = Account.Id;

        request.billingAddress.street = Account.BillingStreet;
        request.billingAddress.city = Account.BillingCity;
        request.billingAddress.zipCode = Account.BillingPostalCode;
        request.billingAddress.state = Account.BillingState;
        request.billingAddress.country = Account.BillingCountry;

        request.shippingAddress.street = Account.ShippingStreet;
        request.shippingAddress.city = Account.ShippingCity;
        request.shippingAddress.zipCode = Account.ShippingPostalCode;
        request.shippingAddress.state = Account.ShippingState;
        request.shippingAddress.country = Account.ShippingCountry;

        return request;
    }

    public List<Account> toAccounts(List<GeolocalizationAddressResponse> responses) {
        Account account;
        List<Account> accounts = new List<Account>();

        for (GeolocalizationAddressResponse response : responses){
            account = new Account();

            // account.Name = response.name;
            account.Id = response.externalId;
            account.GeolocationRequested__c = false;

            // account.BillingStreet = response.billingAddress.street;
            // account.BillingCity = response.billingAddress.city;
            // account.BillingPostalCode = response.billingAddress.zipCode;
            // account.BillingState = response.billingAddress.state;
            // account.BillingCountry = response.billingAddress.country;
            account.BillingLongitude = response.billingAddress.longitude;
            account.BillingLatitude = response.billingAddress.latitude;

            // account.ShippingStreet = response.shippingAddress.street;
            // account.ShippingCity = response.shippingAddress.city;
            // account.ShippingPostalCode = response.shippingAddress.zipCode;
            // account.ShippingState = response.shippingAddress.state;
            // account.ShippingCountry = response.shippingAddress.country;
            account.ShippingLongitude = response.shippingAddress.longitude;
            account.ShippingLatitude = response.shippingAddress.latitude;

            accounts.add(account);
        }

        return accounts;
    }

    public ExternalAccountIds toExternalAccountIds(List<Account> accounts) {
        ExternalAccountIds ids = new ExternalAccountIds();
        for (Account account : accounts) {
            ids.externalIds.add(account.Id);
        }
    
        return ids;
    }
}