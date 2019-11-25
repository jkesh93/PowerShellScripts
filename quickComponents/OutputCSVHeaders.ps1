######################
### What this does ###
######################
# Take in a CSV
# Creates array from headers
# Export headers as CSV

######################
###    Variables   ###
######################
$csvFile = '.\INPUTFILENAME.csv';
$csvOutput = '.\OUTPUTFILENAME.csv';
$headersArrayList = [System.Collections.ArrayList]@();
$returnedRowsArrayList = [System.Collections.ArrayList]@();

######################
###     Script     ###
######################

# Take in a CSV
$csvFile = Import-Csv $csvFile;

# Create array from headers
$headers = $csvFile | Get-member -MemberType 'NoteProperty' | Select-Object -ExpandProperty 'Name'

# Export headers as CSV
$headers | Export-Csv -Path $csvOutput -NoTypeInformation
