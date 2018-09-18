function Get-CheckList {
    <#
      .Synopsis 
       Gets all Checklists in a Trello card.
      .Description 
       Gets all Checklists in a Trello card.
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
            ParameterSetName="List"
        )]
        [string]$Name,
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
            $Query = Invoke-RestMethod -Uri "https://api.trello.com/1/cards/$($Id)/checklists?token=$($Token.Token)&key=$($Token.AccessKey)"
            switch ($PsCmdlet.ParameterSetName) 
            {
                "Name"  { $Query | Where-Object { $_.name -eq $Name }; break }
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

Export-ModuleMember Get-Checklist