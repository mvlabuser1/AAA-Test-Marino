# Script to Export some User Profile Data
#########################################
[System.Reflection.Assembly]::Load(“Microsoft.SharePoint, Version=12.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c”) 
[System.Reflection.Assembly]::Load(“Microsoft.SharePoint.Portal, Version=12.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c”) 
$siteurl = "https://url"
$filename = "C:\Install\Scripts\ExportUserProfileData.csv" # Please adjust
$site = New-Object Microsoft.SharePoint.SPSite($siteurl)
$context = [Microsoft.Office.Server.ServerContext]::GetContext($site)
$upm = New-Object Microsoft.Office.Server.UserProfiles.UserProfileManager($context) 
$upm.Count;
$profiles = $upm.GetEnumerator()
$Export = @()
foreach ($userobject in $Profiles )
{
    $Userdata = @{
        AccountName = $userobject.item("AccountName")
        Lastname=$userobject.item("Lastname")
        Firstname=$userobject.item("Firstname")
        LetterCode=$userobject.item("LetterCode")
        EmployeeID=$userobject.item("EmployeeID")
        BusinessUnitCode=$userobject.item("BusinessUnitCode")
        Country=$userobject.item("Country")
        City=$userobject.item("City")
        Building=$userobject.item("Building")
        Level=$userobject.item("Level")
        Room=$userobject.item("Room")
        Homebase=$userobject.item("Homebase")
    }
    $Export += New-Object PSObject -Property $Userdata
}
$Export | Select AccountName, Lastname, Firstname, LetterCode, EmployeeID, BusinessUnitCode, Country, City, Building, Level, Room, Homebase | export-csv -Path $filename -NoTypeInformation  -Encoding:UTF8 -Delimiter ";"
$site.Dispose()
