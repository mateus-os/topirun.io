/**
 * @author mateus-os
 */
public virtual class Filter {

    public List<String> convertSObjetList ( List<SObject> records , String fieldName ) {

        List<String> filtered = new List<String> ();

        for (SObject record : records) {
            filtered.add ( (String) record.get(fieldName) );
        }
        return filtered;
    } 

}