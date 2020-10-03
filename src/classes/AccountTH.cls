/**
 * @author mateus-os 
 */
public virtual class AccountTH extends TriggerHandler {

    List<Account> newAccounts;
    Map<Id, Account> oldAccounts;

    AccountFilter filter;
    AccountValidator validator;

    public AccountTH() {
        this ((List<Account>) Trigger.new, (Map<Id,Account>) Trigger.oldMap);
    }

    public AccountTH(List<Account> newAccounts, Map<Id, Account> oldAccounts) {
        this.newAccounts = newAccounts;
        this.oldAccounts = oldAccounts;

        this.filter = new AccountFilter();
        this.validator = new AccountValidator();
    }

    override
    public void beforeInsert() {
        validateDocumentsNumber();
        validatePostalCode();
    }

    override
    public void beforeUpdate() {
        validateDocumentsNumber();
        validatePostalCode();
    }

    virtual
    public void validateDocumentsNumber() {
        List<Account> filteredChangedCnpj = this.filter.filterByChangedCnpj(newAccounts, oldAccounts);
        List<Account> filteredChangedCpf = this.filter.filterByChangedCpf(newAccounts, oldAccounts);

        this.validator.validateCnpj(filteredChangedCnpj);
        this.validator.validateCpf(filteredChangedCpf);
    }

    virtual
    public void validatePostalCode() {
        List<Account> filteredAccounts = filter.filterByChangedPostalCode(newAccounts, oldAccounts);

        this.validator.validateBillingPostalCode(filteredAccounts);
        this.validator.validateShippingPostalCode(filteredAccounts);
    }
}