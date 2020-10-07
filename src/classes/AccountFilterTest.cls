/**
 * @author mateus-os
 */
@isTest
public with sharing class AccountFilterTest {

    @isTest
    static void givenChangedCnpjWhenInsertReturnAccounts() {
        Account account = AccountFixtureFactory.createAccount(new Account(Name='Projeto CNPJ'
                                                , Cnpj__c = '61903124000171'));

        List<Account> accounts = new List<Account>{
            account
        };

        AccountFilter filter = new AccountFilter();

        List<Account> filteredAccounts = filter.filterByChangedCnpj(accounts, null);

        System.assertEquals(accounts.size(), filteredAccounts.size());
    }

    @isTest
    static void givenChangedCnpjWhenUpdateReturnAccounts() {
        Account account = AccountFixtureFactory.createAccount(new Account(Name='Projeto CNPJ'
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
    static void givenChangedCpfWhenInsertReturnAccounts() {
        Account account = AccountFixtureFactory.createAccount(new Account(Name='Projeto CPF'
                                                , Cpf__c = '44533580084'));

        List<Account> accounts = new List<Account>{
            account
        };

        AccountFilter filter = new AccountFilter();

        List<Account> filteredAccounts = filter.filterByChangedCpf(accounts, null);

        System.assertEquals(accounts.size(), filteredAccounts.size());
    }

    @isTest
    static void givenChangedCpfWhenUpdateReturnAccounts() {
        Account account = AccountFixtureFactory.createAccount(new Account(Name='Projeto CPF'
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
}