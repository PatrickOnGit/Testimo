﻿$DNSScavengingForPrimaryDNSServer   = @{
    Enable = $false
    Source = @{
        Name       = "DNS Scavenging - Primary DNS Server"
        Data       = {
            $PSWinDocumentationDNS = Import-Module PSWinDocumentation.DNS -PassThru

            & $PSWinDocumentationDNS {
                param($Domain)
                # this gets all DNS Servers but limits it only to those repsponsible for scavenging
                # There should be only 1 such server

                $Object = Get-WinDnsServerScavenging -Domain $Domain
                $Object | Where-Object { $_.ScavengingInterval -ne 0 -and $null -ne $_.ScavengingInterval }

            } $Domain
        }
        Area       = ''
        Parameters = @{

        }
    }
    Tests  = [ordered] @{
        ScavengingCount      = @{
            Enable      = $true
            Name        = 'Scavenging DNS Servers Count'
            Parameters  = @{
                ExpectedCount = 1
                OperationType = 'eq'
            }
            Explanation = 'Scavenging Count should be 1. There should be 1 DNS server per domain responsible for scavenging. If this returns false, every other test fails.'
        }
        ScavengingInterval   = @{
            Enable     = $true
            Name       = 'Scavenging Interval'
            Parameters = @{
                Property      = 'ScavengingInterval', 'Days'
                ExpectedValue = 7
                OperationType = 'le'
            }
        }
        'Scavenging State'   = @{
            Enable                 = $true
            Name                   = 'Scavenging State'
            Parameters             = @{
                Property      = 'ScavengingState'
                ExpectedValue = $true
                OperationType = 'eq'
            }
            Explanation            = 'Scavenging State is responsible for enablement of scavenging for all new zones created.'
            RecommendedValue       = $true
            ExplanationRecommended = 'It should be enabled so all new zones are subject to scavanging.'
            DefaultValue           = $false
        }
        'Last Scavenge Time' = @{
            Enable     = $true
            Name       = 'Last Scavenge Time'
            Parameters = @{
                # this date should be the same as in Scavending Interval
                Property      = 'LastScavengeTime'
                ExpectedValue = (Get-Date).AddDays(-7)
                OperationType = 'lt'
            }
        }
    }
}