/**
 * @author mateus-os
 */
public class AccountAddressFilter extends Filter {

    public List<Account> filterByChangedAddresses(List<Account> newAccounts, Map<Id,Account> oldAccounts) {
        List<Account> filteredAccounts = new List<Account> ();

        for (Account account : newAccounts) {
            if(String.isEmpty(account.BillingStreet) || String.isEmpty(account.BillingPostalCode)
            || String.isEmpty(account.ShippingStreet) || String.isEmpty(account.ShippingPostalCode)) {
                continue;
            }

            if (oldAccounts == null || oldAccounts.isEmpty()) {
                filteredAccounts.add(account);
                continue;
            }

            if (account.BillingStreet == oldAccounts.get(account.Id).BillingStreet
            && account.BillingPostalCode == oldAccounts.get(account.Id).BillingPostalCode
            && account.ShippingStreet == oldAccounts.get(account.Id).ShippingStreet
            && account.ShippingPostalCode == oldAccounts.get(account.Id).ShippingPostalCode) {
                continue;
            }

            filteredAccounts.add(account);
        }
        return filteredAccounts;
    }
}