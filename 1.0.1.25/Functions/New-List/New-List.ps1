function New-List {
    <#
      .Synopsis 
       Adds a list to a Trello Board.
      .Description 
       Adds a list to a Trello Board.
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
                "name" = $Name
                "idBoard" = $Id
                "pos" = $Position
            }
            Invoke-RestMethod -Method "Post" -Uri "https://api.trello.com/1/lists?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash
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

Export-ModuleMember New-List