/**
 * @author mateus-os 
 */
public virtual class AccountTH extends TriggerHandler {

    List<Account> newAccounts;
    Map<Id, Account> oldAccounts;

    AccountFilter filter;
    AccountValidator validator;

    AccountAddressFilter filterAddress;

    public AccountTH() {
        this ((List<Account>) Trigger.new, (Map<Id,Account>) Trigger.oldMap);
    }

    public AccountTH(List<Account> newAccounts, Map<Id, Account> oldAccounts) {
        this.newAccounts = newAccounts;
        this.oldAccounts = oldAccounts;

        this.filter = new AccountFilter();
        this.validator = new AccountValidator();

        this.filterAddress = new AccountAddressFilter();
    }

    override
    public void beforeInsert() {
        validateData();
    }

    override
    public void beforeUpdate() {
        validateData();
    }

    override
    public void afterInsert() {
        sendToGeolocalizationSystem();
    }

    override
    public void afterUpdate() {
        sendToGeolocalizationSystem();
    }

    virtual
    public void validateDocumentsNumber() {
        List<Account> filteredChangedCnpj = this.filter.filterByChangedCnpj(newAccounts, oldAccounts);
        List<Account> filteredChangedCpf = this.filter.filterByChangedCpf(newAccounts, oldAccounts);

        if(filteredChangedCnpj.isEmpty() && filteredChangedCpf.isEmpty()) return;

        this.validator.validateCnpj(filteredChangedCnpj);
        this.validator.validateCpf(filteredChangedCpf);
    }

    virtual
    public void validatePostalCode() {
        List<Account> filteredAccounts = filter.filterByChangedPostalCode(newAccounts, oldAccounts);

        if(filteredAccounts.isEmpty()) return;

        this.validator.validateBillingPostalCode(filteredAccounts);
        this.validator.validateShippingPostalCode(filteredAccounts);
    }

    virtual
    public void sendToGeolocalizationSystem() {
        List<Account> filteredAccounts = filterAddress.filterByChangedAddresses(newAccounts, oldAccounts);

        if(filteredAccounts.isEmpty()) return;

        SendGeolocalizationAddress.sendAddresses(this.filterAddress.convertSObjetList(filteredAccounts, 'Id'));
    }

    virtual
    public void validateData(){
        validateDocumentsNumber();
        validatePostalCode();
    }
}