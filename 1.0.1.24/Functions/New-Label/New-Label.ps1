function New-Label {
    <#
      .Synopsis 
       Creates a new Trello Label.
      .Description 
       Creates a new Trello Label.
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
            Position=2,
            ParameterSetName="Name"
        )]
        [string]$Name,
        [parameter(
            Mandatory=$true,
            Position=3
        )]
        [ValidateSet("yellow","sky","red","purple","pink","orange","lime","green","blue","black")]
        [string]$Color
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
                "color" = $color
                "idBoard" = $Id
            }
            Invoke-RestMethod -Method "Post" -Uri "https://api.trello.com/1/labels/?token=$($AuthWrite.Token)&key=$($AuthWrite.AccessKey)" -Body $Hash
        }
        catch
        {
        }
    }
    end
    {
    }
}

Export-ModuleMember New-Label