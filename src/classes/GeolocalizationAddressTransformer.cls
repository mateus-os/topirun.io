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
}