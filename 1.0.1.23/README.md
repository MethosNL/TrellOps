[![Build status](https://ci.appveyor.com/api/projects/status/gy0t1yxqwalbdwpb?svg=true)](https://ci.appveyor.com/project/MethosIT/trellops)
# **TrellOps**
This Windows PowerShell is for the management of Trello.
Help and examples for this module will be uploaded on the 28th of May 2016.

##### Written by: Jeff Wouters

## Example
This is an example on how you can use this Windows PowerShell module in order to manage your Trello environment.

###Get your token
Get your secret and key from here: https://trello.com/app-key
<pre><code>$Secret = "YourSecret"
$Key = "YourKey"

$AuthRead = New-TrelloToken -Key $Key -AppName "TrellOpsRead" -Expiration "never" -Scope 'read'
$AuthWrite = New-TrelloToken -Key $Key -AppName "TrellOpsWrite" -Expiration "never" -Scope 'read,write'

Get-TrelloBoard -Token $AuthRead -All</code></pre>

####Create a board
<pre><code>$TrelloBoard = New-TrelloBoard -Token $AuthWrite -Name "MethosIT - Demo" -Description "This is demo board of Methos IT"</code></pre>

####Create lists on the board
<pre><code>$TrelloBoardList_UnprioritisedBacklog = New-TrelloList -Token $AuthWrite -Id $TrelloBoard.id -Name "Un-prioritised Backlog" -Position "bottom"
$TrelloBoardList_Backlog = New-TrelloList -Token $AuthWrite -Id $TrelloBoard.id -Name "Backlog" -Position "bottom"
$TrelloBoardList_Sprint = New-TrelloList -Token $AuthWrite -Id $TrelloBoard.id -Name "Sprint" -Position "bottom"
$TrelloBoardList_WIP = New-TrelloList -Token $AuthWrite -Id $TrelloBoard.id -Name "WIP (Work in Progress)" -Position "bottom"
$TrelloBoardList_Done = New-TrelloList -Token $AuthWrite -Id $TrelloBoard.id -Name "Done" -Position "bottom"
$TrelloBoardList_Impediments = New-TrelloList -Token $AuthWrite -Id $TrelloBoard.id -Name "Impediments" -Position "bottom"</code></pre>

####Create labels on the board
<pre><code>$TrelloBoardLabel_Daily = New-TrelloLabel -Token $AuthWrite -Id $Trelloboard.id -Name "Daily" -Color "red"
$TrelloBoardLabel_Weekly = New-TrelloLabel -Token $AuthWrite -Id $Trelloboard.id -Name "Weekly" -Color "blue"
$TrelloBoardLabel_Monthly = New-TrelloLabel -Token $AuthWrite -Id $Trelloboard.id -Name "Monthly" -Color "black"</code></pre>

####Create cards in the lists
<pre><code>$NewTrelloCard = New-TrelloCard -Token $AuthWrite -Id $TrelloBoardList_Backlog.id -Name "TestCard" -Description "Just some description" -Label $TrelloBoardLabel_Daily.id -Position "bottom"
$NewTrelloCard2 = New-TrelloCard -Token $AuthWrite -Id $TrelloBoardList_Backlog.id -Name "TestCard2" -Description "Just some description" -Label $TrelloBoardLabel_Weekly.id -Position "bottom"
$NewTrelloCard3 = New-TrelloCard -Token $AuthWrite -Id $TrelloBoardList_Backlog.id -Name "TestCard3" -Description "Just some description" -Label $TrelloBoardLabel_Weekly.id -Position "bottom"
$NewTrelloCard4 = New-TrelloCard -Token $AuthWrite -Id $TrelloBoardList_Backlog.id -Name "TestCard4" -Description "Just some description" -Label $TrelloBoardLabel_Monthly.id -Position "bottom"
$NewTrelloCard5 = New-TrelloCard -Token $AuthWrite -Id $TrelloBoardList_Backlog.id -Name "TestCard5" -Description "Just some description" -Label $TrelloBoardLabel_Monthly.id -Position "bottom"
$NewTrelloCard6 = New-TrelloCard -Token $AuthWrite -Id $TrelloBoardList_Backlog.id -Name "TestCard6" -Description "Just some description" -Label $TrelloBoardLabel_Monthly.id -Position "bottom"
$NewTrelloCard7 = New-TrelloCard -Token $AuthWrite -Id $TrelloBoardList_Backlog.id -Name "TestCard7" -Description "Just some description" -Position "bottom"</code></pre>

####Create a checklist in a card
<pre><code>$TrelloCardChecklist = Add-TrelloChecklist -Token $AuthWrite -Id $NewTrelloCard.id -Name "Checklist" -Position "top"</code></pre>

####Create items in the checklist
<pre><code>
$TrelloCardChecklistItem1 = Add-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -Name "This is my rifle,"
$TrelloCardChecklistItem2 = Add-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -Name "This is my gun."
$TrelloCardChecklistItem3 = Add-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -Name "This is for fighting,"
$TrelloCardChecklistItem4 = Add-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -Name "This is for fun."</code></pre>

####Add an attachment to a card
<pre><code>$TrelloCardAttachment = Add-TrelloAttachment -Token $AuthWrite -Id $NewTrelloCard.id -Name "Some attachment" -Url "http://www.desktopbackgroundsi.net/wp-content/uploads/Picture_6.jpg"
$TrelloCardAttachment2 = Add-TrelloAttachment -Token $AuthWrite -Id $NewTrelloCard7.id -Name "Some attachment" -Url "http://www.freewebheaders.com/wordpress/wp-content/gallery/global/global-franchise-blue-header.jpg"</code></pre>


## Clean up the demo board
#Remove what you've created

####Remove items from a checklist
<pre><code>Remove-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -ItemId $TrelloCardChecklistItem4.id
Remove-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -ItemId $TrelloCardChecklistItem3.id
Remove-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -ItemId $TrelloCardChecklistItem2.id
Remove-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -ItemId $TrelloCardChecklistItem1.id

####Remove checklist
Remove-TrelloChecklist -Token $AuthWrite -Id $TrelloCardChecklist.id</code></pre>

####Remove attachment from a card
<pre><code>Remove-TrelloAttachment -Token $AuthWrite -Id $TrelloCardAttachment.id -CardId $NewTrelloCard.id
Remove-TrelloAttachment -Token $AuthWrite -Id $TrelloCardAttachment2.id -CardId $NewTrelloCard7.id</code></pre>

####Remove cards
<pre><code>Remove-TrelloCard -Token $AuthWrite -Id $NewTrelloCard7.id
Remove-TrelloCard -Token $AuthWrite -Id $NewTrelloCard6.id
Remove-TrelloCard -Token $AuthWrite -Id $NewTrelloCard5.id
Remove-TrelloCard -Token $AuthWrite -Id $NewTrelloCard4.id
Remove-TrelloCard -Token $AuthWrite -Id $NewTrelloCard3.id
Remove-TrelloCard -Token $AuthWrite -Id $NewTrelloCard2.id
Remove-TrelloCard -Token $AuthWrite -Id $NewTrelloCard.id</code></pre>

####Remove labels
<pre><code>Remove-TrelloLabel -Token $AuthWrite -Id $TrelloBoardLabel_Daily.id
Remove-TrelloLabel -Token $AuthWrite -Id $TrelloBoardLabel_Weekkly.id
Remove-TrelloLabel -Token $AuthWrite -Id $TrelloBoardLabel_Monthly.id</code></pre>