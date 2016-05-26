function Get-Label {
    <#
      .Synopsis 
       Gets all labels on a Trello board.
      .Description 
       Gets all labels on a Trello board.
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
            Mandatory=$false,
            Position=2,
            ParameterSetName="Name"
        )]
        [string]$Name,
        [parameter(
            Mandatory=$false,
            Position=2,
            ParameterSetName="Color"
        )]
        [ValidateSet("yellow","sky","red","purple","pink","orange","lime","green","blue","black")]
        [string]$Color,
        [parameter(
            Mandatory=$false,
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
            $Query = Invoke-RestMethod ("https://api.trello.com/1/boards/$($id)/labels/?token=$($Token.Token)&key=$($Token.AccessKey)")
            switch ($PsCmdlet.ParameterSetName) 
            {
                "Name"  { $Query | Where-Object { $_.name -eq $Name   }; break }
                "Color" { $Query | Where-Object { $_.color -eq $Color }; break }
                "All"   { $Query; break }
                default { $Query; break }
            }
        }
        catch
        {
            Write-Error
        }
    }
    end
    {
    }
}

Export-ModuleMember Get-Label