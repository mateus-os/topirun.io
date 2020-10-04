/**
 * @author mateus-os
 */
public class GeolocalizationAddressResponse {
    public String name;
    public String externalId;

    public Address billingAddress;
    public Address shippingAddress;

    public GeolocalizationAddressResponse(){
        billingAddress = new GeolocalizationAddressResponse.Address();
        shippingAddress = new GeolocalizationAddressResponse.Address();
    }

    public class Address {
        public String street;
        public String city;
        public String zipCode;
        public String state;
        public String country;
        public Double longitude;
        public Double latitude;
    }
}