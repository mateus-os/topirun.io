/**
 * @author mateus-os
 */
public class AccountAddressFilter extends Filter {

    public List<Account> filterByChangedAddresses(List<Account> newAccounts, Map<Id,Account> oldAccounts) {
        List<Account> filteredAccounts = new List<Account> ();

        for (Account account : newAccounts) {
            if(isRequiredAddressFieldsEmpty(account)) {
                continue;
            }

            if (oldAccounts == null || oldAccounts.isEmpty()) {
                filteredAccounts.add(account);
                continue;
            }

            if (!isAddressChanged(account, oldAccounts.get(account.Id))) {
                continue;
            }

            filteredAccounts.add(account);
        }
        return filteredAccounts;
    }

    private Boolean isAddressChanged(Account newAccount, Account oldAccount){
        if(newAccount.BillingCity != oldAccount.BillingCity
        || newAccount.ShippingCity != oldAccount.ShippingCity) {
            return true;
        }
        
        if(newAccount.BillingCountry != oldAccount.BillingCountry
        || newAccount.ShippingCountry != oldAccount.ShippingCountry) {
            return true;
        }

        if(newAccount.BillingPostalCode != oldAccount.BillingPostalCode
        || newAccount.ShippingPostalCode != oldAccount.ShippingPostalCode) {
            return true;
        }

        if(newAccount.BillingState != oldAccount.BillingState
        || newAccount.ShippingState != oldAccount.ShippingState) {
            return true;
        }

        if(newAccount.BillingStreet != oldAccount.BillingStreet
        || newAccount.ShippingStreet != oldAccount.ShippingStreet) {
            return true;
        }

        return false;
    }

    private Boolean isRequiredAddressFieldsEmpty(Account account){
        if(String.isEmpty(account.BillingStreet)) {
            return true;
        }

        if(String.isEmpty(account.BillingPostalCode)) {
            return true;
        }

        if(String.isEmpty(account.ShippingStreet)) {
            return true;
        }

        if(String.isEmpty(account.ShippingPostalCode)) {
            return true;
        }

        return false;
    }
}