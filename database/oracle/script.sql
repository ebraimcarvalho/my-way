/* Replace <BASE URI> below with the URL you copied from your files in OCI Object Storage at runtime.
*/
set define on
define file_uri_base = 'https://objectstorage.sa-saopaulo-1.oraclecloud.com/n/grzhaznbyatx/b/training/o/'

begin
 dbms_cloud.copy_data(
    table_name =>'CHANNELS',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&file_uri_base/chan_v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true')
 );
end;
/

begin
 dbms_cloud.copy_data(
    table_name =>'COUNTRIES',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&file_uri_base/coun_v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true')
 );
end;
/

begin
 dbms_cloud.copy_data(
    table_name =>'CUSTOMERS',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&file_uri_base/cust1v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true', 'dateformat' value 'YYYY-MM-DD-HH24-MI-SS')
 );
end;
/

begin
 dbms_cloud.copy_data(
    table_name =>'SUPPLEMENTARY_DEMOGRAPHICS',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&file_uri_base/dem1v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true')
 );
end;
/

begin
 dbms_cloud.copy_data(
    table_name =>'SALES',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&file_uri_base/dmsal_v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true', 'dateformat' value 'YYYY-MM-DD')
 );
end;
/

begin
 dbms_cloud.copy_data(
    table_name =>'PRODUCTS',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&file_uri_base/prod1v3.dat',
    format => json_object('delimiter' value '|', 'quote' value '^', 'ignoremissingcolumns' value 'true', 'dateformat' value 'YYYY-MM-DD-HH24-MI-SS', 'blankasnull' value 'true')
 );
end;
/

begin
 dbms_cloud.copy_data(
    table_name =>'PROMOTIONS',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&file_uri_base/prom1v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true', 'dateformat' value 'YYYY-MM-DD-HH24-MI-SS', 'blankasnull' value 'true')
 );
end;
/

begin
 dbms_cloud.copy_data(
    table_name =>'SALES',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&file_uri_base/sale1v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true', 'dateformat' value 'YYYY-MM-DD', 'blankasnull' value 'true')
 );
end;
/

begin
 dbms_cloud.copy_data(
    table_name =>'TIMES',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&file_uri_base/time_v3.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true', 'dateformat' value 'YYYY-MM-DD-HH24-MI-SS', 'blankasnull' value 'true')
 );
end;
/


begin
 dbms_cloud.copy_data(
    table_name =>'COSTS',
    credential_name =>'OBJ_STORE_CRED',
    file_uri_list =>'&file_uri_base/costs.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'dateformat' value 'YYYY-MM-DD', 'blankasnull' value 'true')
 );
end;
/