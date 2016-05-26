function Get-Card {
    <#
      .Synopsis 
       Gets all cards on a Trello board.
      .Description 
       Gets all cards on a Trello board.
    #>
    [CmdletBinding(DefaultParameterSetName="All")]
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
            Position=2,
            ParameterSetName="Name"
        )]
        [string]$Name,
        [parameter(
            Mandatory=$true,
            Position=2,
            ParameterSetName="List"
        )]
        $List,
        [parameter(
            Mandatory=$true,
            Position=2,
            ParameterSetName="All"
        )]
        [switch]$All
    )
    begin
    {
    }
    process
    {
        try
        {
            $Query = Invoke-RestMethod ("https://api.trello.com/1/boards/$($Id)/cards/?token=$($Token.Token)&key=$($Token.AccessKey)")
            switch ($PsCmdlet.ParameterSetName) 
            {
                "Name"  { $Query | Where-Object { $_.name -eq $Name      }; break }
                "List"  { $Query | Where-Object { $_.idList -eq $List.id }; break }
                "All"   { $Query; break }
                default { $Query; break }
            }
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

Export-ModuleMember Get-Card