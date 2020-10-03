/**
 * @author mateus-os
 */
public class AccountValidator {

    public List<Account> validateCnpj(List<Account> accounts) {
        Formatter formatter = new Formatter();
        BrazilianDocumentValidator validator = new BrazilianDocumentValidator();

        for (Account account : accounts) {
            if(!validator.isCNPJ(account.Cnpj__c)) {
                account.Cnpj__c.addError('Inválido');
                continue;
            }
            account.Cnpj__c = formatter.formatCnpj(account.Cnpj__c);
        }
        return accounts;
    }

    public List<Account> validateCpf(List<Account> accounts) {
        Formatter formatter = new Formatter();
        BrazilianDocumentValidator validator = new BrazilianDocumentValidator();

        for (Account account : accounts) {
            if(!validator.isCPF(account.Cpf__c)) {
                account.Cpf__c.addError('Inválido');
                continue;
            }
            account.Cpf__c = formatter.formatCpf(account.Cpf__c);
        }
        return accounts;
    }

    public List<Account> validateBillingPostalCode(List<Account> accounts) {
        for (Account account : accounts) {
            if(account.BillingPostalCode.length() == 0){
                continue;
            }

            if(account.BillingPostalCode.length() != 8 ) {
                account.BillingPostalCode.addError('Inválido');
                continue;
            }

            account.BillingPostalCode = formatter.formatPostalCode(account.BillingPostalCode);
        }
        return accounts;
    }

    public List<Account> validateShippingPostalCode(List<Account> accounts) {
        for (Account account : accounts) {
            if(account.ShippingPostalCode == null){
                continue;
            }

            if(account.ShippingPostalCode.length() != 8 ) {
                account.ShippingPostalCode.addError('Inválido');
                continue;
            }
            
            account.ShippingPostalCode = formatter.formatPostalCode(account.ShippingPostalCode);
        }
        return accounts;
    }
}