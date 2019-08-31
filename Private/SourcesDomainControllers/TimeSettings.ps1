﻿$TimeSettings = [ordered] @{
    Enable = $true
    Source = @{
        Name       = "Time Settings"
        Data       = {
            Get-TimeSetttings -ComputerName $DomainController -Domain $Domain
        }
        Area       = ''
        Parameters = @{

        }
    }
    Tests  = [ordered] @{
        NTPServerEnabled = @{
            Enable     = $true
            Name       = 'NtpServer must be enabled.'
            Parameters = @{
                WhereObject   = { $_.ComputerName -eq $DomainController }
                Property      = 'NtpServerEnabled'
                ExpectedValue = $true
                OperationType = 'eq'
            }
        }
        VMTimeProvider   = @{
            Enable     = $true
            Name       = 'Virtual Machine Time Provider should be disabled.'
            Parameters = @{
                WhereObject   = { $_.ComputerName -eq $DomainController }
                Property      = 'VMTimeProvider'
                ExpectedValue = $false
                OperationType = 'eq'
            }
        }
        NtpTypeNonPDC    = [ordered]  @{
            Enable       = $true
            Name         = 'NTP Server should be set to Domain Hierarchy'
            Requirements = @{
                IsPDC = $false
            }
            Parameters   = @{
                WhereObject   = { $_.ComputerName -eq $DomainController }
                Property      = 'NtpType'
                ExpectedValue = 'NT5DS'
                OperationType = 'eq'

            }
        }
        NtpTypePDC       = [ordered] @{
            Enable       = $true
            Name         = 'NTP Server should be set to AllSync'
            Requirements = @{
                IsPDC = $true
            }
            Parameters   = @{
                WhereObject   = { $_.ComputerName -eq $DomainController }
                Property      = 'NtpType'
                ExpectedValue = 'AllSync'
                OperationType = 'eq'

            }
        }
    }
}