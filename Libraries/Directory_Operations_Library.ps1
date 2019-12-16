########### Get parent folder of item
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
    InitialDirectory = [Environment]::GetFolderPath('Desktop') 
}

$null = $FileBrowser.ShowDialog()

$directoryArray = @()
$directoryArray = ($FileBrowser.FileName).Split('\')

$path = ""

for($i = 0; $i -lt ($directoryArray.Length - 1); $i++){
    $path += $directoryArray[$i]
    $path += "\"
}
