# Create the array
$arrayList = [System.Collections.ArrayList]@();

# Add to array
function addToArrayList($key,$val)
{
    $obj = @($key, $val);
    $arrayList.Add($obj)
    Write-Host "Successfully added $key $val"
}

# Remove from array
function removeFromArrayList($key,$val)
{
    $obj = @($key, $val);
    $arrayList.Remove(($obj));
    Write-Host "Successfully removed $key $val"
}

# Get ArrayList Item by Key
function getArrayListItemByKey($key)
{
    Write-Host -ForegroundColor Yellow "Values matching key '$key' : "
    foreach($item in $arrayList)
    {
        if($item[0] -eq $key)
        {
            Write-Host -ForegroundColor Yellow  $item[1]
        }
    }
}

# Get ArrayList Keys
function getArrayListKeys()
{
    foreach($item in $arrayList)
    {
        $item[0]
    }
}

# Get Values by ArrayList
function getArrayListValues()
{
    foreach($item in $arrayList)
    {
        $item[1]
    }
}


# Get keys
function getArrayListKeys()
{
    foreach($item in $arrayList)
    {
        $item[0]
    }
}

# Import keys from CSV
function setArrayListKeys()
{
    Write-Host -ForegroundColor Green "Setting up keys array..."
    $csvPath = '.\keysArray.csv'
    # Import csv
    try
    {
        Write-Host -ForegroundColor Green "Importing CSV...."
        $keysArray = Import-Csv -Path $csvPath

        # Make sure key is the header...
        try
        {
            $kaKey = $keysArray.key
        }
        catch
        {
            Write-host "Ensure the header 'key' present"
        }

        foreach($line in $keysArray)
        {
            $key = $line.key
            addToArrayList -key $key -val '';
        }
    }
    catch
    {
        Write-Host -ForegroundColor red "No file found in $csvPath, ensure the file is located in the current directory.";
    }
    
    Write-Host -ForegroundColor green "Successfully added all keys.";
}

function getKeysArrayCount()
{
    $c = $arrayList.Count
    Write-Host $c
    return $c;
}

function getKeySetValue($key,$val)
{
    try
    {
        foreach($item in $arrayList)
        {
            $item
        }
    }
    catch
    {
        Write-Host "unable to find key $key";
    }
}

setArrayListKeys;
