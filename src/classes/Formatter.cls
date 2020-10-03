/**
 * @author mateus-os
 */
public class Formatter {

    public String formatCnpj(String cnpj) {
        String template = '{0}.{1}.{2}/{3}-{4}';
        List<Object> parameters = new List<Object> {
            cnpj.substring(0, 2)
            , cnpj.substring(2, 5)
            , cnpj.substring(5, 8)
            , cnpj.substring(8, 12)
            , cnpj.substring(12)
        };
        return String.format(template, parameters);
    }

    public String formatCpf(String cpf) {
        String template = '{0}.{1}.{2}-{3}';
        List<Object> parameters = new List<Object> {
            cpf.substring(0, 3)
            , cpf.substring(3, 6)
            , cpf.substring(6, 9)
            , cpf.substring(9)
        };
        return String.format(template, parameters);
    }

    public static String formatPostalCode(String cpf) {
        String template = '{0}-{1}';
        List<Object> parameters = new List<Object> {
            cpf.substring(0, 5)
            , cpf.substring(5)
        };
        return String.format(template, parameters);
    }
}