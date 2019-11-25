# Create the array
$arrayList = [System.Collections.ArrayList]@();

function addToArrayList($key,$val)
{
    $obj = @($key, $val);
    $arrayList.Add($obj)
}

addToArrayList -key 'dog' -val 'mickey';
addToArrayList -key 'cat' -val 'tiffany';
addToArrayList -key 'person' -val 'jay';

$arrayList[0][0]
