/**
 * @author mateus-os
 */
@isTest
public class AccountFixtureFactory {
    
    public static Account newAccount(String name) {
        return new Account (Name = name);
    }

    public static Account createAccount(String name) {
        return createAccount ( newAccount(name));
    }
    
    public static Account createAccount (Account account) {
        insert account;
        return account;
    }

    public static List<Account> createAccounts (List<Account> accounts) {
        insert accounts;
        return accounts;
    }

    public static Account fromJson (String payload) {
        return (Account) JSON.deserialize(payload, Account.class);
    }

    public static List<Account> fromAccountsJson (String payload) {
        return (List<Account>) JSON.deserialize(payload, List<Account>.class);
    }

    public static Map<String, SObject> createIntegratedScenario () {
        Map<String, SObject> records = new Map<String, SObject>();

        Account account = newAccount('Test Address');

        account.BillingStreet = 'Avenida Sumaré, 650';
        account.BillingPostalCode = '05016090';
        account.ShippingStreet = 'Avenida Sumaré, 650';
        account.ShippingPostalCode = '05016090';

        records.put('accountWithRequiredAddressData', account);

        records.put('accountAddressEmpty', newAccount('Test WithoutAddress'));
        
        return records;
    }
}