# ACCEPT ARGUMENT FROM OTHER SCRIPT 
param($targetuser, $targetpermission, $permdesc) 

# logic for handling adding / removing permissions from local user accounts 
if ($targetuser -and $targetpermission -and $permdesc) {

    switch ($permdesc) {
        "r" {
            Remove-LocalGroupMember -Group "$targetpermission" -Member "$targetuser"            
        }
        "a" {
            Add-LocalGroupMember -Group "$targetpermission" -Member "$targetuser"    
        }
        default {
        
            Write-Host "Arguments out of range" 
            Write-Host "" 
            Write-Error "Arguments out of range. (7)" 2> error.log
            user_help
            exit 1

        }
    }
}
