function New-Card {
    <#
      .Synopsis 
       Adds a new Trello Card.
      .Description 
       Adds a new Trello Card.
    #>
    [cmdletbinding()]
    param (
        [parameter(
            Mandatory=$true,
            Position=0
        )]
        $Token,
        [parameter(
            Mandatory=$true,
            Position=1
        )]
        $Id,
        [parameter(
            Mandatory=$true,
            Position=2
        )]
        $Name,
        [parameter(
            Mandatory=$true,
            Position=3
        )]
        $Description,
        [parameter(
            Mandatory=$false,
            Position=4
        )]
        [string[]]$Label,
        [parameter(
            Mandatory=$false,
            Position=5
        )]
        [ValidateSet("top","bottom")]
        $Position = "bottom"
    )
    begin
    {
    }
    process
    {
        [hashtable]$Hash = @{
            "name" = $Name
            "desc" = $Description
            "idList" = $id
            "due" = $null
            "urlSource" = $null
            "idLabels" = $($Label -join ",")
        }
        try {
            Invoke-RestMethod -Method "Post" -Uri "https://api.trello.com/1/cards/?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash
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

Export-ModuleMember New-Card