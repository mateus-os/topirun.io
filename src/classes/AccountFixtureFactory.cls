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

    public static Account fromJson (String payload) {
        return (Account) JSON.deserialize(payload, Account.class);
    }
}