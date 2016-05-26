function Add-ChecklistItem {
    <#
      .Synopsis 
       Adds a new Item to a Trello Checklists.
      .Description 
       Adds a new Item to a Trello Checklists.
    #>
    [cmdletbinding()]
    param(
        [parameter(
            Mandatory=$true,
            Position=0
        )]
        $Token,
        [parameter(
            Mandatory=$true,
            Position=1
        )]
        [string]$Id,
        [parameter(
            Mandatory=$true,
            Position=2
        )]
        [string]$Name,
        [parameter(
            Mandatory=$false,
            Position=2
        )]
        [ValidateSet("true","false")]
        [string]$Checked = "false",
        [parameter(
            Mandatory=$false,
            Position=3
        )]
        [ValidateSet("top","bottom")]
        [string]$Position = "bottom"
    )
    begin
    {
    }
    process
    {
        try
        {
            $Hash = @{
                "name" = $Name
                "pos" = $Position
                "checked" = $checked
            }
            Invoke-RestMethod -Method "Post" -Uri "https://api.trello.com/1/checklists/$($Id)/checkitems?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash
        }
        catch
        {
            Write-Error $_
        }
    }
    end
    {
    }
}

Export-ModuleMember Add-Checklistitem