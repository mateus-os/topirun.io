/**
 * @author mateus-os
 */
public class GeolocalizationAddressRequest {
    public String name;
    public String externalId;

    public Address billingAddress;
    public Address shippingAddress;

    public GeolocalizationAddressRequest(){
        billingAddress = new GeolocalizationAddressRequest.Address();
        shippingAddress = new GeolocalizationAddressRequest.Address();
    }

    public class Address {
        public String street;
        public String city;
        public String zipCode;
        public String state;
        public String country;
    }
}