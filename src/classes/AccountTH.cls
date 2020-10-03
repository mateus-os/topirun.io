/**
 * @author mateus-os 
 */
public virtual class AccountTH extends TriggerHandler {

    List<Account> newAccounts;
    Map<Id, Account> oldAccounts;

    public AccountTH() {
        this ((List<Account>) Trigger.new, (Map<Id,Account>) Trigger.oldMap);
    }

    public AccountTH(List<Account> newAccounts, Map<Id, Account> oldAccounts) {
        this.newAccounts = newAccounts;
        this.oldAccounts = oldAccounts;
    }

    override
    public void beforeInsert() {

    }

    override
    public void beforeUpdate() {
        
    }
}