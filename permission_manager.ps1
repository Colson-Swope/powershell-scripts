# ACCEPT ARGUMENT FROM OTHER SCRIPT 

param($targetuser, $targetpermission, $permdesc) 

Write-Host "$targetuser"
Write-Host "$targetpermission"
Write-Host "$permdesc"

if ($targetuser -and $targetpermission -and $permdesc) {

    switch ($permdesc) {
        "r" {
            Remove-LocalGroupMember -Group "$targetpermission" -Member "$targetuser"            
        }
        "a" {
            Add-LocalGroupMember -Group "$targetpermission" -Member "$targetuser"    
        }
    }
}
