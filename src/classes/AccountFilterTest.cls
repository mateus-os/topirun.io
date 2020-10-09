/**
 * @author mateus-os
 */
@isTest
public with sharing class AccountFilterTest {

    @isTest
    static void givenCnpjWhenInsertedReturnAccounts() {
        List<Account> accounts = new List<Account>{
            new Account(Name='Test CNPJ', Cnpj__c = '61903124000171')
        };

        AccountFilter filter = new AccountFilter();

        List<Account> filteredAccounts = filter.filterByChangedCnpj(accounts, null);

        System.assertEquals(accounts.size(), filteredAccounts.size());
    }

    @isTest
    static void givenCnpjWhenChangedReturnAccounts() {
        Account account = AccountFixtureFactory.createAccount(new Account(Name='Test CNPJ'
                                                , Cnpj__c = '61903124000171'));

        List<Account> accounts = new List<Account>{
            account
        };

        Map<Id,Account> oldAccounts = new Map<Id,Account> (accounts);

        Account changedAccount = accounts.get(0).clone(true, true, true, true);
        changedAccount.Cnpj__c = '89926905000109';
        oldAccounts.put(changedAccount.Id, changedAccount);

        AccountFilter filter = new AccountFilter();

        List<Account> filteredAccounts = filter.filterByChangedCnpj(accounts, oldAccounts);

        System.assertEquals(accounts.size(), filteredAccounts.size());
        System.assertNotEquals(filteredAccounts.get(0).Cnpj__c, oldAccounts.get(changedAccount.Id).Cnpj__c);
    }

    @isTest
    static void givenCpfWhenInsertedReturnAccounts() {
        List<Account> accounts = new List<Account>{
            new Account(Name='Test CPF', Cpf__c = '44533580084')
        };

        AccountFilter filter = new AccountFilter();

        List<Account> filteredAccounts = filter.filterByChangedCpf(accounts, null);

        System.assertEquals(accounts.size(), filteredAccounts.size());
    }

    @isTest
    static void givenCpfWhenChangedReturnAccounts() {
        Account account = AccountFixtureFactory.createAccount(new Account(Name='Test CPF'
                                                , Cpf__c = '44533580084'));

        List<Account> accounts = new List<Account>{
            account
        };

        Map<Id,Account> oldAccounts = new Map<Id,Account> (accounts);

        Account changedAccount = accounts.get(0).clone(true, true, true, true);
        changedAccount.Cpf__c = '09802855006';
        oldAccounts.put(changedAccount.Id, changedAccount);

        AccountFilter filter = new AccountFilter();

        List<Account> filteredAccounts = filter.filterByChangedCpf(accounts, oldAccounts);

        System.assertEquals(accounts.size(), filteredAccounts.size());
        System.assertNotEquals(filteredAccounts.get(0).Cpf__c, oldAccounts.get(changedAccount.Id).Cpf__c);
    }

    @isTest
    static void givenPostalCodeWhenInsertedReturnAccounts() {
        List<Account> accounts = new List<Account>{
            new Account(Name='Test BillingPostalCode', BillingPostalCode = '06123450')
            , new Account (Name='Test ShippingPostalCode', ShippingPostalCode = '06123456')
        };

        AccountFilter filter = new AccountFilter();

        List<Account> filteredAccounts = filter.filterByChangedPostalCode(accounts, null);

        System.assertEquals(accounts.size(), filteredAccounts.size());
    }

    @isTest
    static void givenPostalCodeWhenChangedReturnAccounts() {
        List<Account> accounts = AccountFixtureFactory.createAccount(
            new List<Account>{
                new Account(Name='Test BillingPostalCode', BillingPostalCode = '06123450')
            , new Account (Name='Test ShippingPostalCode', ShippingPostalCode = '06123456')
            }
        );

        Map<Id,Account> oldAccounts = new Map<Id,Account> (accounts);

        Account changedBilling = accounts.get(0).clone(true, true, true, true);
        Account changedShipping = accounts.get(1).clone(true, true, true, true);

        changedBilling.BillingPostalCode = '16123450';
        changedShipping.ShippingPostalCode = '16123456';

        oldAccounts.put(changedBilling.Id, changedBilling);
        oldAccounts.put(changedShipping.Id, changedShipping);

        AccountFilter filter = new AccountFilter();

        List<Account> filteredAccounts = filter.filterByChangedPostalCode(accounts, oldAccounts);

        System.assertEquals(accounts.size(), filteredAccounts.size());
        System.assertNotEquals(filteredAccounts.get(0).BillingPostalCode, oldAccounts.get(changedBilling.Id).BillingPostalCode);
        System.assertNotEquals(filteredAccounts.get(1).ShippingPostalCode, oldAccounts.get(changedShipping.Id).ShippingPostalCode);
    }
}