function Get-Member {
    <#
      .Synopsis 
       Gets member of a Trello board.
      .Description 
       Gets member of a Trello board.
    #>
    [CmdletBinding(DefaultParameterSetName="UserName")]
    param(
        [parameter(
            Mandatory=$true,
            Position=0
        )]
        $Token,
        [parameter(
            Mandatory=$true,
            Position=1,
            ParameterSetName="Id"
        )]
        [string]$Id,
        [parameter(
            Mandatory=$true,
            Position=2,
            ParameterSetName="UserName"
        )]
        [string]$UserName
    )
    begin
    {
    }
    process
    {
        try
        {
            switch ($PsCmdlet.ParameterSetName) 
            {
                "Id"       {
                    $Option = $Id
                    break
                }
                "UserName" {
                    $Option = $UserName
                    break
                }
            }
            Invoke-RestMethod -Method "Get" -Uri "https://api.trello.com/1/members/$Option/?token=$($Token.Token)&key=$($Token.AccessKey)"
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

Export-ModuleMember Get-Member