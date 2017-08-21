function Get-List {
    <#
      .Synopsis 
       Gets all lists on a Trello board.
      .Description 
       Gets all lists on a Trello board.
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
        $Id,
        [parameter(
            Mandatory=$true,
            Position=2,
            ParameterSetName="Name"
        )]
        [string]$Name,
        [parameter(
            Mandatory=$false,
            Position=2,
            ParameterSetName="All"
        )]
        [switch]$All = $true
    )
    begin
    {
    }
    process
    {
        try
        {
            $Query = Invoke-RestMethod ("https://api.trello.com/1/boards/$($Id)/lists/?token=$($Token.Token)&key=$($Token.AccessKey)")
            switch ($PsCmdlet.ParameterSetName) 
            {
                "Name"  { $Query | Where-Object {$_.name -eq $Name}; break }
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

Export-ModuleMember Get-List