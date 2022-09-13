#The goal of this script is to determine if a machine is vulnerable to the top 5 CVEs listed here https://www.sentinelone.com/blog/enterprise-security-essentials-top-15-most-routinely-exploited-vulnerabilities-2022/
#I would like to be able to have a GUI pop up and i am able to click which CVE to test or to select all the CVEs and have the results saved to an output file. Along with it being displayed in an alert box.

#Calling .net UI stuff
Add-Type -AssemblyName system.windows.forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationFramework

#Drawing GUI
$form = New-Object System.Windows.Forms.Form
$form.text = "VulnScanner"
$form.size = New-Object System.Drawing.Size(300,300)
$form.StartPosition = "CenterScreen"

$okb = New-Object System.Windows.Forms.Button
$okb.Location = New-Object System.Drawing.Point(75,170)
$okb.Size = New-Object System.Drawing.Size(75,25)
$okb.Text = "Confirm"
$okb.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okb
$form.Controls.Add($okb)

$cancelb = New-Object System.Windows.Forms.Button
$cancelb.Location = New-Object System.Drawing.Point(150,170)
$cancelb.Size = New-Object System.Drawing.size(75,25)
$cancelb.Text = "Cancel"
$cancelb.DialogResult = [System.Windows.Forms.Dialogresult]::Cancel
$form.CancelButton = $cancelb
$form.Controls.Add($cancelb)

#Label asking users to check which vulnerabilities to check for
$label = New-Object System.Windows.Forms.Label
$label.location = New-Object System.Drawing.Point(10,20)
$label.size = New-Object System.Drawing.Size(280,20)
$label.Text = "Please Select Which CVE to check"
$form.controls.Add($label)

$cb1 = New-Object System.Windows.Forms.CheckBox
$cb1.location = New-Object System.Drawing.Point(5,40)
$cb1.Size = New-Object System.Drawing.Size(10,10)
$form.Controls.Add($cb1)

$cb2 = New-Object System.Windows.Forms.CheckBox
$cb2.location = New-Object System.Drawing.Point(5,60)
$cb2.Size = New-Object System.Drawing.Size(10,10)
$form.Controls.Add($cb2)

$cb3 = New-Object System.Windows.Forms.CheckBox
$cb3.location = New-Object System.Drawing.Point(5,80)
$cb3.Size = New-Object System.Drawing.Size(10,10)
$form.Controls.Add($cb3)

$cb4 = New-Object System.Windows.Forms.CheckBox
$cb4.location = New-Object System.Drawing.Point(5,100)
$cb4.Size = New-Object System.Drawing.Size(10,10)
$form.Controls.Add($cb4)

$cb5 = New-Object System.Windows.Forms.CheckBox
$cb5.location = New-Object System.Drawing.Point(5,120)
$cb5.Size = New-Object System.Drawing.Size(10,10)
$form.Controls.Add($cb5)


#Log4Shell (CVE-2021-44228)
$label2 = New-Object System.Windows.Forms.Label
$label2.location = New-Object System.Drawing.Point(20,38)
$label2.size = New-Object System.Drawing.Size(280,20)
$label2.Text = "CVE-2021-44228"
$form.controls.Add($label2)


#Zoho ManageEngine ADSelfService Plus (CVE-2021-40539)
$label3 = New-Object System.Windows.Forms.Label
$label3.location = New-Object System.Drawing.Point(20,58)
$label3.size = New-Object System.Drawing.Size(280,20)
$label3.Text = "CVE-2021-40539"
$form.controls.Add($label3)


#ProxyShell (CVE-2021-31207)
$label4 = New-Object System.Windows.Forms.Label
$label4.location = New-Object System.Drawing.Point(20,78)
$label4.size = New-Object System.Drawing.Size(280,20)
$label4.Text = "CVE-2021-31207"
$form.controls.Add($label4)


#ProxyShell (CVE-2021-34473)
$label5 = New-Object System.Windows.Forms.Label
$label5.location = New-Object System.Drawing.Point(20,98)
$label5.size = New-Object System.Drawing.Size(280,20)
$label5.Text = "CVE-2021-34473"
$form.controls.Add($label5)


#ProxyShell (CVE-2021-34523)
$label6 = New-Object System.Windows.Forms.Label
$label6.location = New-Object System.Drawing.Point(20,118)
$label6.size = New-Object System.Drawing.Size(280,20)
$label6.Text = "CVE-2021-34523"
$form.controls.Add($label6)

#logic for checking if you have log4j
$log4jtest = Get-ChildItem -path C:\ -include *log4j* -Force -Recurse -ErrorAction SilentlyContinue 

#If statement for performing log4j check
if ($cb1.Checked -eq $true)
{ 
    Read-Host $log4jtest
}

#2.15.0 Is patched log4j version
#6114 is patched zoho manageengine


$form.TopMost = $true
$form.add_shown({$cb1.Select()})
$result = $form.ShowDialog()

#logic for determining if CVE is patched based on current build
$zohofile = Select-String -Path "C:\ManageEngine\ADSelfService Plus\conf\product.conf" -Pattern 'product.build_number'
$currzohover = $zohofile.substring(37,4)
Read-Host $currzohover

if ($cb2.Checked -eq $true)
{
    if ($currzohover -le 6113) 
    {
        Read-Host "You are vulnerable to CVE-2021-44228"
            else Read-Host "You are not vulnerable to CVE-2021-44228"
    }
}


#Rules for outputting results to log file
$resultsDirectory = "$env:UserProfile\Results"

if (!(test-path $resultsDirectory))
{
    New-Item -Path $resultsDirectory -ItemType Directory -Force
}

#Patched exchange builds:

$ex19 = @(15.2.792.10, 15.2.659.12, 15.2.595.8, 15.2.529.13, 15.2.464.15, 15.2.397.11, 15.2.330.11, 15.2.221.18)
$ex16 = @(15.1.2176.9, 15.1.2106.13, 15.1.2044.13, 15.1.1979.8, 15.1.1913.12, 15.1.1847.12, 15.1.1779.8, 15.1.1713.10, 15.1.1591.18, 15.1.1531.12, 15.1.1466.16, 15.1.1415.10)


