function Add-Checklist {
    <#
      .Synopsis 
       Adds a new Checklists to a Trello card.
      .Description 
       Adds a new Checklists to a Trello card.
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
            Position=3
        )]
        [ValidateSet("top","bottom")]
        [string]$Position = "top"
    )
    begin
    {
    }
    process
    {
        try
        {
            $Hash = @{
                "id" = $Id
                "name" = $Name
                "pos" = $Position
            }
            Invoke-RestMethod -Method "Post" -Uri "https://api.trello.com/1/cards/$($Id)/checklists?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash
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

Export-ModuleMember Add-Checklist