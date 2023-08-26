/****************************************************************/
/*                                                              */
/*               Project - Silently Zabbix Install.ps1          */
/*                                                              */
/*                                                              */
/*               Create  : 19 August 2019 11:56:29              */
/*             Update  : 26 August 2023 11:24:59                */
/*                                                              */
/****************************************************************/

$tmp = Get-Content -LiteralPath '**append path to file with list of computers'
for($i=0; $i -lt $tmp.Count; $i++)  {
    $Error.Clear()
    get-pssession | remove-pssession
    $computer = $tmp[$i]

    Copy-Item -Path '**add dist zabbix folder path' -Destination \\$computer\c$\ -Recurse

    Invoke-Command -ComputerName $computer -ScriptBlock {cmd /s /c "C:\Zabbix_agent\zabbix_agentd.exe -c C:\Zabbix_agent\zabbix_agentd.conf -i"} -ErrorAction SilentlyContinue
    Invoke-Command -ComputerName $computer -ScriptBlock {net start "Zabbix Agent"}

    $ErrorActionPreference = 'SilentlyContinue'

    If($Error -ne $null) {
      $Error.Clear()
       Write-Host($computer + "  error")
    }
}