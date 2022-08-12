#Calls .net Framework
Add-Type -AssemblyName system.windows.forms
Add-Type -AssemblyName system.drawing
Set-ExecutionPolicy Unrestricted

#Names process
$form = New-Object System.Windows.Forms.Form
$form.Text = "rosesocscript"
$form.Size = New-Object System.Drawing.Size(300,250)
$form.StartPosition = "CenterScreen"

#Defines location and size of the confirm button
$okb = New-Object System.Windows.Forms.Button
$okb.Location = New-Object System.Drawing.Point(75,170)
$okb.Size = New-Object System.Drawing.Size(75,25)
$okb.Text = "Confirm"
$okb.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okb
$form.Controls.Add($okb)

#Defines location and size of the cancel button
$cancelb = New-Object System.Windows.Forms.Button
$cancelb.Location = New-Object System.Drawing.Point(150,170)
$cancelb.Size = New-Object System.Drawing.size(75,25)
$cancelb.Text = "Cancel"
$cancelb.DialogResult = [System.Windows.Forms.Dialogresult]::Cancel
$form.CancelButton = $cancelb
$form.Controls.Add($cancelb)

#Label asking users to input text
$label = New-Object System.Windows.Forms.Label
$label.location = New-Object System.Drawing.Point(10,20)
$label.size = New-Object System.Drawing.Size(280,20)
$label.Text = "Enter the name of the file you're looking for"
$form.controls.Add($label)

#User input box to enter the name of the file
$textbox = New-Object System.Windows.Forms.TextBox
$textbox.location = New-Object system.drawing.point(10,40)
$textbox.size = New-Object system.drawing.size(260,20)
$form.controls.Add($textbox)

#Label asking users to input a full directory path
$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10,70)
$label2.Size = New-Object System.Drawing.Size(280,20)
$label2.Text = "Please Enter the directory you want to search"
$form.controls.Add($label2)

#Textbox for users to enter a full directory path
$textbox2 = New-Object System.Windows.Forms.TextBox
$textbox2.location = New-Object system.drawing.point(10,90)
$textbox2.size = New-Object system.drawing.size(260,20)
$form.controls.Add($textbox2)

#Label instructing users to enter their username for logging purposes
$label3 = New-Object System.Windows.Forms.Label
$label3.location = New-Object System.Drawing.Point(10,110)
$label3.Size = New-Object System.Drawing.Size (280,20)
$label3.Text = "Please enter your username"
$form.Controls.Add($label3)

#Textbox for entering username
$textbox3 = New-Object System.Windows.Forms.TextBox
$textbox3.Location = New-Object System.Drawing.Point(10,130)
$textbox3.Size = New-Object System.Drawing.Size(260,20)
$form.controls.Add($textbox3)



$form.TopMost = $true

$form.add_shown({$textbox.Select()})
$result = $form.ShowDialog()

#If statement that defines the textbox input as a variable
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $filename = $textbox.Text
    
    $directory = $textbox2.Text
    
    $username = $textbox3.Text
    
}
$endDate = Get-Date -Format f
$resultspath = "$($filename)_$($env:UserName)_$($endDate).txt"
$resultspath1 = $resultspath.replace(':','')
#$path = read-host "please type your file path"
#$filename = read-host "please type your file name"
Add-Content -Path $Env:UserProfile\Logs\logs.txt -Value "$($env:username) search for $($filename) in directory $($directory) at $($enddate)"
Get-ChildItem -path $directory -include *$filename* -recurse -erroraction SilentlyContinue | Out-File -FilePath C:\Users\Rose\Results\$($resultspath1)
