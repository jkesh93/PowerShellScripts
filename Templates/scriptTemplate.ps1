#############################
# Inputs / Variables
#############################
$csvOutputName = ".\output.csv"

#############################
# Logic
#############################

## remove old file if it exists
if(Test-Path $csvOutputName)
{
"File exists"
rm $csvOutputName
}
else
{
"File does not exist"
Add-Content $csvOutputName -Value "Hola"
}
