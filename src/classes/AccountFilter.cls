/**
 * @author mateus-os
 */
public class AccountFilter {

    public List<Account> filterByChangedCnpj(List<Account> newAccounts, Map<Id,Account> oldAccounts) {
        List<Account> filteredAccounts = new List<Account> ();

        for (Account account : newAccounts) {

            if(String.isEmpty(account.Cnpj__c)) continue;

            if (oldAccounts == null || oldAccounts.isEmpty()) {
                filteredAccounts.add(account);
                continue;
            }

            if (account.Cnpj__c == oldAccounts.get(account.Id).Cnpj__c) {
                continue;
            }
            
            filteredAccounts.add(account);
        }
        return filteredAccounts;
    }

    public List<Account> filterByChangedCpf(List<Account> newAccounts, Map<Id,Account> oldAccounts) {
        List<Account> filteredAccounts = new List<Account> ();

        for (Account account : newAccounts) {

            if(String.isEmpty(account.Cpf__c)) continue;

            if (oldAccounts == null || oldAccounts.isEmpty()) {
                filteredAccounts.add(account);
                continue;
            }

            if (account.Cpf__c == oldAccounts.get(account.Id).Cpf__c) {
                continue;
            }
            
            filteredAccounts.add(account);
        }
        return filteredAccounts;
    }

    public List<Account> filterByChangedPostalCode(List<Account> newAccounts, Map<Id,Account> oldAccounts) {
        List<Account> filteredAccounts = new List<Account>();

        for (Account account : newAccounts) {

            if(String.isEmpty(account.BillingPostalCode) && String.isEmpty(account.ShippingPostalCode)) {
                continue;
            }

            if (oldAccounts == null || oldAccounts.isEmpty()) {
                filteredAccounts.add(account);
                continue;
            }

            if (account.BillingPostalCode == oldAccounts.get(account.Id).BillingPostalCode
                && account.ShippingPostalCode == oldAccounts.get(account.Id).ShippingPostalCode) {
                continue;
            }
            
            filteredAccounts.add(account);
        }
        return filteredAccounts;
    }
}