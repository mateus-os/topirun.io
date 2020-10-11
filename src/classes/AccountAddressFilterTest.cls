/**
 * @author mateus-os
 */
@isTest
public class AccountAddressFilterTest {
    
    @isTest
    static void givenAccountAddressWithRequiredDataWhenInsertedReturnAccounts() {
        Map<String, SObject> records = AccountFixtureFactory.createIntegratedScenario();

        List<Account> accounts = new List<Account>{
            (Account) records.get('accountWithRequiredAddressData')
        };

        AccountAddressFilter filter = new AccountAddressFilter();

        List<Account> filteredAccounts = filter.filterByChangedAddresses(accounts, null);

        System.assertEquals(accounts.size(), filteredAccounts.size());
    }

    @isTest
    static void givenAccountAddressWithoutRequiredDataWhenInsertedReturnEmptyList() {
        Map<String, SObject> records = AccountFixtureFactory.createIntegratedScenario();

        List<Account> accounts = new List<Account>{
            (Account) records.get('accountAddressEmpty')
        };

        AccountAddressFilter filter = new AccountAddressFilter();

        List<Account> filteredAccounts = filter.filterByChangedAddresses(accounts, null);

        System.assert(filteredAccounts.size() == 0);
    }

    @isTest
    static void givenMultipleAccountWithMultipleAddressChangesWhenInsertReturnAccountsWithRequiredFields() {
        Map<String, SObject> records = AccountFixtureFactory.createIntegratedScenario();

        List<Account> accounts = new List<Account>{
            (Account) records.get('accountAddressEmpty')
            , (Account) records.get('accountAddressEmpty')
        };

        accounts.addAll(AccountFixtureFactory.fromAccountsJson('[ { "Name": "Empty Billing Street" }, { "Name": "Empty Shipping Street", "BillingStreet": "Rua um, 2", "BillingPostalCode": "12345670" }, { "Name": "Empty Billing Postal", "BillingStreet": "Rua um, 2" }, { "Name": "Empty Shipping Postal", "BillingStreet": "Rua um, 2", "ShippingStreet": "Rua dois, 1", "BillingPostalCode": "12345670" } ]'));

        AccountAddressFilter filter = new AccountAddressFilter();

        List<Account> filteredAccounts = filter.filterByChangedAddresses(accounts, null);

        System.assertNotEquals(filteredAccounts.size(), accounts.size());
    }

    @isTest
    static void givenMultipleAccountWithRequiredAddressFieldsWhenUpdateAddressReturnAllAccounts() {
        Map<String, SObject> records = AccountFixtureFactory.createIntegratedScenario();

        List<Account> accounts = AccountFixtureFactory.fromAccountsJson('[ { "Name": "Test 01", "BillingStreet": "Rua um, 2", "ShippingStreet": "Rua dois, 1", "BillingPostalCode": "12345670", "ShippingPostalCode": "76543210" }, { "Name": "Test 02", "BillingStreet": "Rua um, 2", "ShippingStreet": "Rua dois, 1", "BillingPostalCode": "12345670", "ShippingPostalCode": "76543210" }, { "Name": "Test 03", "BillingStreet": "Rua um, 2", "ShippingStreet": "Rua dois, 1", "BillingPostalCode": "12345670", "ShippingPostalCode": "76543210" }, { "Name": "Test 04", "BillingStreet": "Rua um, 2", "ShippingStreet": "Rua dois, 1", "BillingPostalCode": "12345670", "ShippingPostalCode": "76543210" }, { "Name": "Test 05", "BillingStreet": "Rua um, 2", "ShippingStreet": "Rua dois, 1", "BillingPostalCode": "12345670", "ShippingPostalCode": "76543210" } ]');

        Test.setMock(HttpCalloutMock.class , new AccountHttpMock());
        Test.startTest();

        accounts = AccountFixtureFactory.createAccounts(accounts);

        Map<Id,Account> oldAccounts = editAddresses(accounts);

        AccountAddressFilter filter = new AccountAddressFilter();

        List<Account> filteredAccounts = filter.filterByChangedAddresses(accounts, oldAccounts);

        Test.stopTest();

        System.assertEquals(filteredAccounts.size(), accounts.size());
    }

    private static Map<Id,Account> editAddresses(List<Account> accounts) {
        Map<Id,Account> oldAccounts = new Map<Id,Account> (accounts);

        Account changedCity = accounts.get(0).clone(true, true, true, true);
        Account changedCountry = accounts.get(1).clone(true, true, true, true);
        Account changedState = accounts.get(2).clone(true, true, true, true);
        Account changedStreet = accounts.get(3).clone(true, true, true, true);
        Account changedPostalCode = accounts.get(4).clone(true, true, true, true);

        changedCity.BillingCity = 'São Paulo';
        changedCountry.BillingCountry = 'Brasil';
        changedState.BillingState = 'SP';
        changedStreet.BillingStreet = 'Avenida do teste, 123';
        changedPostalCode.BillingPostalCode = '11111222';

        oldAccounts.put(changedCity.Id, changedCity);
        oldAccounts.put(changedCountry.Id, changedCountry);
        oldAccounts.put(changedState.Id, changedState);
        oldAccounts.put(changedStreet.Id, changedStreet);
        oldAccounts.put(changedPostalCode.Id, changedPostalCode);

        return oldAccounts;
    }

    public class AccountHttpMock implements HttpCalloutMock {

        public HttpResponse respond  (HttpRequest request) {

            HttpResponse response = new HttpResponse();

            response.setBody('');
            response.setStatusCode(200);

            return response;
        }
    }
}