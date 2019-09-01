﻿$WellKnownFolders = @{
    Enable = $true
    Source = @{
        Name       = 'Well known folders'
        Data       = {
            $DomainInformation = Get-ADDomain -Server $Domain
            $WellKnownFolders = $DomainInformation | Select-Object -Property UsersContainer, ComputersContainer, DomainControllersContainer, DeletedObjectsContainer, SystemsContainer, LostAndFoundContainer, QuotasContainer, ForeignSecurityPrincipalsContainer
            $CurrentWellKnownFolders = [ordered] @{ }

            $DomainDistinguishedName = $DomainInformation.DistinguishedName
            $DefaultWellKnownFolders = [ordered] @{
                UsersContainer                     = "CN=Users,$DomainDistinguishedName"
                ComputersContainer                 = "CN=Computers,$DomainDistinguishedName"
                DomainControllersContainer         = "OU=Domain Controllers,$DomainDistinguishedName"
                DeletedObjectsContainer            = "CN=Deleted Objects,$DomainDistinguishedName"
                SystemsContainer                   = "CN=System,$DomainDistinguishedName"
                LostAndFoundContainer              = "CN=LostAndFound,$DomainDistinguishedName"
                QuotasContainer                    = "CN=NTDS Quotas,$DomainDistinguishedName"
                ForeignSecurityPrincipalsContainer = "CN=ForeignSecurityPrincipals,$DomainDistinguishedName"
            }
            foreach ($_ in $WellKnownFolders.PSObject.Properties.Name) {
                $CurrentWellKnownFolders[$_] = $DomainInformation.$_
                $CurrentWellKnownFolders[$_] = $DomainInformation.$_
            }
            Compare-MultipleObjects -Object @($DefaultWellKnownFolders, $CurrentWellKnownFolders) -SkipProperties
        }
        Area       = ''
        Parameters = @{

        }
    }
    Tests  = [ordered] @{
        UsersContainer                     = @{
            Enable     = $true
            Name       = "Users Container shouldn't be at default"
            Parameters = @{
                WhereObject           = { $_.Name -eq 'UsersContainer' }
                ExpectedValue         = $false
                Property              = 'Status'
                OperationType         = 'eq'
                PropertyExtendedValue = '1'
            }
        }
        ComputersContainer                 = @{
            Enable     = $true
            Name       = "Computers Container shouldn't be at default"
            Parameters = @{
                WhereObject           = { $_.Name -eq 'ComputersContainer' }
                ExpectedValue         = $false
                Property              = 'Status'
                OperationType         = 'eq'
                PropertyExtendedValue = '1'
            }
        }
        DomainControllersContainer         = @{
            Enable     = $true
            Name       = "Domain Controllers Container should be at default location"
            Parameters = @{
                WhereObject           = { $_.Name -eq 'DomainControllersContainer' }
                ExpectedValue         = $true
                Property              = 'Status'
                OperationType         = 'eq'
                PropertyExtendedValue = '1'
            }
        }
        DeletedObjectsContainer            = @{
            Enable     = $true
            Name       = "Deleted Objects Container should be at default location"
            Parameters = @{
                WhereObject           = { $_.Name -eq 'DeletedObjectsContainer' }
                ExpectedValue         = $true
                Property              = 'Status'
                OperationType         = 'eq'
                PropertyExtendedValue = '1'
            }
        }
        SystemsContainer                   = @{
            Enable     = $true
            Name       = "Systems Container should be at default location"
            Parameters = @{
                WhereObject           = { $_.Name -eq 'SystemsContainer' }
                ExpectedValue         = $true
                Property              = 'Status'
                OperationType         = 'eq'
                PropertyExtendedValue = '1'
            }
        }
        LostAndFoundContainer              = @{
            Enable     = $true
            Name       = "Lost And Found Container should be at default location"
            Parameters = @{
                WhereObject           = { $_.Name -eq 'LostAndFoundContainer' }
                ExpectedValue         = $true
                Property              = 'Status'
                OperationType         = 'eq'
                PropertyExtendedValue = '1'
            }
        }
        QuotasContainer                    = @{
            Enable     = $true
            Name       = "Quotas Container shouldn be at default location"
            Parameters = @{
                WhereObject           = { $_.Name -eq 'QuotasContainer' }
                ExpectedValue         = $true
                Property              = 'Status'
                OperationType         = 'eq'
                PropertyExtendedValue = '1'
            }
        }
        ForeignSecurityPrincipalsContainer = @{
            Enable     = $true
            Name       = "Foreign Security Principals Container should be at default location"
            Parameters = @{
                WhereObject           = { $_.Name -eq 'ForeignSecurityPrincipalsContainer' }
                ExpectedValue         = $true
                Property              = 'Status'
                OperationType         = 'eq'
                PropertyExtendedValue = '1'
            }
        }
    }
}