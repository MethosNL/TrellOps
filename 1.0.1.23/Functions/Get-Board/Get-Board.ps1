function Get-Board {
    <#
      .Synopsis 
       Gets all your Trello boards.
      .Description 
       Gets all your Trello boards.
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
            Position=1,
            ParameterSetName="Name"
        )]
        [string]$Name,
        [parameter(
            Mandatory=$true,
            Position=1,
            ParameterSetName="Id"
        )]
        [string]$Id,
        [parameter(
            Mandatory=$false,
            Position=1,
            ParameterSetName="All"
        )]
        [switch]$All,
        [parameter(
            Mandatory=$false,
            Position=2
        )]
        [ValidateSet("Open","Closed","All")]
        [string]$Status = "All"
    )
    begin
    {
    }
    process
    {
        try
        {
            $Query = Invoke-RestMethod ("https://api.trello.com/1/members/my/boards/?token=$($Token.Token)&key=$($Token.AccessKey)")
            switch ($PsCmdlet.ParameterSetName) 
            {
                "Name"
                {
                    $PSNApplied = $Query | where {$_.name -eq $Name}
                    break
                }
                "Id"
                {
                    $PSNApplied = $Query | where {$_.id -eq $Id}
                    break
                }
                "All"
                {
                    $PSNApplied = $Query
                    break
                }
            }
            switch ($Status)
            {
                "Open"
                {
                    $PSNApplied | Where-Object {$_.closed -eq $False}
                }
                "Closed"
                {
                    $PSNApplied | Where-Object {$_.closed -eq $True}
                }
                "All"
                {
                    $PSNApplied
                }
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

Export-ModuleMember Get-Board