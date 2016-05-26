function Get-ChecklistItem {
    <#
      .Synopsis 
       Gets a Trello Checklists Item.
      .Description 
       Adds a Trello Checklists Item.
    #>
    [cmdletbinding(DefaultParameterSetName="All")]
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
            Mandatory=$false,
            Position=2,
            ParameterSetName="Name"
        )]
        [string]$Name,
        [parameter(
            Mandatory=$false,
            Position=2,
            ParameterSetName="All"
        )]
        [switch]$All = $false
    )
    begin
    {
    }
    process
    {
        try
        {
            $Query = Invoke-RestMethod -Method "Get" -Uri "https://api.trello.com/1/checklists/$($Id)/checkitems?token=$($Token.Token)&key=$($Token.AccessKey)"
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

Export-ModuleMember Get-ChecklistItem