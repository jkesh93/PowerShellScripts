######################
### What this does ###
######################
# Function library for CSV files

######################
###     Inputs     ###
######################
#
# ADJUST THESE PARAMETERS AS NEEDED
#

$csvFileName = "INTPUTFILENAME"

######################
###    Variables   ###
######################
$csvFile = ".\$csvFileName.csv"
$headersArrayList = [System.Collections.ArrayList]@()

######################
###     Script     ###
######################

# Load in CSV
$csvFile = Import-Csv -Path $csvFile

######################
###   Functions    ###
######################

<#
FUNCTION NAME: getHeaders
DESCRIPTION: Returns an array of the headers for the CSV file
#>

function getHeaders()
{
    $headers = $csvFile | Get-member -MemberType 'NoteProperty' | Select-Object -ExpandProperty 'Name'
    return $headers
}

<#
FUNCTION NAME: getUniqueColumnEntries
DESCRIPTION: Returns an array of unique row entries for the column specified
#>

function getUniqueColumnEntries($column)
{
    $columnEntries = $csvFile."$column"
    $columnEntries | Get-Unique
    return $columnEntries
}


<#
FUNCTION NAME: exportUniqueColumnEntries
DESCRIPTION: Exports unique row entries for the column specified
#>

function exportUniqueColumnEntries($column)
{
    # Array of items
    $outArray = @()
    $columnEntries = $csvFile."$column"
    $columnEntries = $columnEntries | Sort-Object |  Get-Unique

    foreach($item in $columnEntries)
    {
        $outArray += New-Object PsObject -property @{
        "$column" = [string]$item
        }
    }
    $outArray | Export-Csv -Path .\"$column.csv" -NoTypeInformation
}

<#
FUNCTION NAME: getCSVRowCount
DESCRIPTION: Returns number of rows in CSV file
#>

function getCSVRowCount()
{
    # Variable
    $result = $csvFile.length

    return $result
}
