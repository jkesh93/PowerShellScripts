# Create the array
$MyArrayList = [System.Collections.ArrayList]@();

# Add to the array
$firstName = "John";
$lastName = "Smith";
$person = @($firstName, $lastName);
$MyArrayList.Add($person);

    # Show the array list
    $MyArrayList;
        # returns
        <#####
        PS C:\Users\YourUser\ScriptPath>
            0
            John
            Smith
        ######>

# Get an item from the array list
    # Only the first name
    $MyArrayList[0][0]
        # returns
        <#####
        PS C:\Users\YourUser\ScriptPath>
            0
            John
        ######>

    # Only the last name
    $MyArrayList[0][1]
        # returns
        <#####
        PS C:\Users\YourUser\ScriptPath>
            0
            Smith
        ######>

# Get the length of the array list
    $MyArrayList.length
        # returns
        <#####
        PS C:\Users\YourUser\ScriptPath>
            0
            2
        ######>
