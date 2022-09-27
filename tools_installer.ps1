# Original script from https://github.com/ChrisTitusTech/win10script

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$wshell = New-Object -ComObject Wscript.Shell
$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

# GUI Specs
Write-Host "Checking winget..."

# Check if winget is installed
if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe){
    'Winget Already Installed'
}  
else{
    # Installing winget from the Microsoft Store
	Write-Host "Winget not found, installing it now."
    $ResultText.text = "`r`n" +"`r`n" + "Installing Winget... Please Wait"
	Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
	$nid = (Get-Process AppInstaller).Id
	Wait-Process -Id $nid
	Write-Host Winget Installed
    $ResultText.text = "`r`n" +"`r`n" + "Winget Installed - Ready for Next Task"
}

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(400,400)
$Form.text                       = "Tools & Programs installer"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#658fa0")
$Form.AutoScaleDimensions     = '192, 192'
$Form.AutoScaleMode           = "Dpi"
$Form.AutoSize                = $True
$Form.AutoScroll              = $True
$Form.ClientSize              = '400, 400'
$Form.FormBorderStyle         = 'FixedSingle'

$Form.Width                   = $objImage.Width
$Form.Height                  = $objImage.Height

$Panel1                          = New-Object system.Windows.Forms.Panel
$Panel1.height                   = 500
$Panel1.width                    = 219
$Panel1.location                 = New-Object System.Drawing.Point(6,50)

$python                           = New-Object system.Windows.Forms.Button
$python.text                      = "Python"
$python.width                     = 212
$python.height                    = 30
$python.location                  = New-Object System.Drawing.Point(4,60)
$python.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$pip                         = New-Object system.Windows.Forms.Button
$pip.text                    = "pip"
$pip.width                   = 212
$pip.height                  = 30
$pip.location                = New-Object System.Drawing.Point(4,90)
$pip.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$codespell                         = New-Object system.Windows.Forms.Button
$codespell.text                    = "Spell-check"
$codespell.width                   = 212
$codespell.height                  = 30
$codespell.location                = New-Object System.Drawing.Point(4,120)
$codespell.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$nodejs                         = New-Object system.Windows.Forms.Button
$nodejs.text                    = "Node JS"
$nodejs.width                   = 212
$nodejs.height                  = 30
$nodejs.location                = New-Object System.Drawing.Point(4,150)
$nodejs.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Form.controls.AddRange(@($Panel1,$Panel2,$Label3,$Label15,$Panel4,$PictureBox1,$Label1,$Label4,$Panel3,$ResultText,$Label10,$Label11,$urlfixwinstartup,$urlremovevirus,$urlcreateiso))
$Panel1.controls.AddRange(@($python,$pip,$codespell,$nodejs))
$Panel2.controls.AddRange(@($essentialtweaks,$backgroundapps,$cortana,$actioncenter,$darkmode,$performancefx,$onedrive,$lightmode,$essentialundo,$EActionCenter,$ECortana,$RBackgroundApps,$HTrayIcons,$EClipboardHistory,$ELocation,$InstallOneDrive,$removebloat,$reinstallbloat,$WarningLabel,$Label5,$appearancefx,$STrayIcons,$EHibernation,$dualboottime))
$Panel4.controls.AddRange(@($defaultwindowsupdate,$securitywindowsupdate,$Label16,$Label17,$Label18,$Label19))
$Panel3.controls.AddRange(@($yourphonefix,$Label6,$windowsupdatefix,$ncpa,$oldcontrolpanel,$oldsoundpanel,$Button1))

$python.Add_Click({
    Write-Host "Installing Python"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Python... Please Wait" 
    winget install Python.Python.3.10 | Out-Host
    if($?) { Write-Host "Installed Python" }
    $ResultText.text = "`r`n" + "Finished Installing Python" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$pip.Add_Click({
    Write-Host "Checking if its already installed"
    py -m ensurepip --upgrade
    if($?) { Write-Host "Installed pip" }
    $ResultText.text = "`r`n" + "Finished Installing pip" + "`r`n" + "`r`n" + "Ready for Next Task"
    if(Get-Command py){
        if(Get-Command pip){ç
            Write-Host "Already installed"
        }else{
            py -m ensurepip --upgrade
            if($?) { Write-Host "Installed pip" }
            $ResultText.text = "`r`n" + "Finished Installing pip" + "`r`n" + "`r`n" + "Ready for Next Task"
        }
    }else{
        Write-Host "Please install Python first"
    }
})

$codespell.Add_Click({
    Write-Host "Spell-check installation"
    pip install codespell
    if($?) { Write-Host "Installed codespell" }
})

$nodejs.Add_Click({
    Write-Host "Installing NodeJs & npm version manager"
    $ResultText.text = "`r`n" +"`r`n" + "Installing NodeJs & npm version manager... Please Wait" 
    winget install -e --id OpenJS.NodeJS | Out-Host
    Write-Host "Installed NodeJs & npm version manager"
    $ResultText.text = "`r`n" + "Finished Installing NodeJs & npm version manager" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$putty.Add_Click({
    Write-Host "Installing PuTTY & WinSCP"
    $ResultText.text = "`r`n" +"`r`n" + "Installing PuTTY & WinSCP... Please Wait" 
    winget install -e PuTTY.PuTTY | Out-Host
    winget install -e WinSCP.WinSCP | Out-Host
    Write-Host "Installed PuTTY & WinSCP"
    $ResultText.text = "`r`n" + "Finished Installing PuTTY & WinSCP" + "`r`n" + "`r`n" + "Ready for Next Task"
})

[void]$Form.ShowDialog()
