## Input Snippets

########### Get File from input prompt
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
        InitialDirectory = [Environment]::GetFolderPath('Desktop') 
    }

$FileBrowser.ShowDialog()

# Access File Path
$filePath = $FileBrowser.FileName

########### Get Folder
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

$foldername = New-Object System.Windows.Forms.FolderBrowserDialog
$foldername.Description = "Select a folder"
$foldername.rootfolder = "MyComputer"

if($foldername.ShowDialog() -eq "OK")
{
    $folder += $foldername.SelectedPath
}

return $folder



########### Get input via GUI pop-up
$inputBoxExample = [Windows.Forms.MessageBox]::show("There are buttons in this box", "PowerShell Rocks",
[Windows.Forms.MessageBoxButtons]::YesNo, [Windows.Forms.MessageBoxIcon]::Question)

# Access the input
$inputBoxExample


########### Get input via GUI pop-up example 2
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

$title = 'Look up user?'
$msg   = 'UPN of user:'

$text = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)

# Access input
$text
