<#
.Synopsis
   Get email address based on Windows Logon/SamAccountName.
.DESCRIPTION
   Get email address based on Windows Logon/SamAccountName. Useful for username exports from SEP Cloud 15
.EXAMPLE
   Get-EmailFromSamAccountName -samAccountList @("user1","user2")
.EXAMPLE
   Get-EmailFromSamAccountName -samAccountList $UserList
#>
function Get-EmailFromSamAccountName
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # List of valid samAccountNames
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [Object[]]$samAccountList
    )

    foreach ($item in $samAccountList)
    {
        get-aduser -filter 'samAccountName -eq $item' | select userprincipalname   
    }
}
