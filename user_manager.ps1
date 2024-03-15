# https://superuser.com/questions/608931/list-all-user-accounts-on-a-windows-system-via-command-line
# https://learn.microsoft.com/en-us/powershell

# function for user help 

# EXIT CODES (ZERO FOR SUCCESS, NONZERO FOR FAIL 
# COMMENT BLOCK TELLING WHAT SCRIPT DOES AND PARAMETERS IT TAKES (INCLUDE NAME AND DATE) 
# SCRIPT COMMENTS AT A USEFUL LEVEL 
# PROPER ERROR MESSAGES 

function user_help {
    Write-Host ""
    Write-Host "Usage: .\user_manager.ps1 [-arguments]" 
    Write-Host ""
    Write-Host "Arguments: " 
    Write-Host ""
    Write-Host "-m    Manage users (create, modify, and delete)" 
    Write-Host "-i    Display user information" 
    Write-Host "-p    Manipulate user privileges" 
}

function user_manager {

    $action = Read-Host "Choose action: ((c)reate, (d)elete, (m)odify)"

    switch ($action) {
        "c" {

            $acctnum = Read-Host "Enter number of user accounts"

            for (($i = 1); $i -le $acctnum; $i++) {
                $createduser = Read-Host "Enter username for account '$i' " 
                $createddesc = Read-Host "Enter a description of the account: " 

                New-LocalUser -Name "$createduser" -Description "$createddesc" -NoPassword
            }
             
        }
        "d" {
            $acctnum = Read-Host "Enter number of user accounts to delete"

            for (($i = 1); $i -le $acctnum; $i++) {
                $deleteduser = Read-Host "Enter username for account '$i' " 

                Remove-LocalUser -Name "$deleteduser"
            }

        }
        "m" {
            $moduser = Read-Host "Choose action: ((r)ename account, (c)hange description)" 

            switch ($moduser) {
                "r" {
                    
                    $oldname = Read-Host "Enter old account username"
                    $newname = Read-Host "Enter new username" 

                    Rename-LocalUser -Name "$oldname" -NewName "$newname"
                }
                "c" {
                
                    $targetacct = Read-Host "Enter target account username"
                    $newdesc = Read-Host "Enter a new description for the account" 

                    Set-LocalUser -Name "$targetacct" -Description "$newdesc"
                }
                default {
                    Write-Host "Invalid action. Please try again" 
                }
            }
        }
        default {
            Write-Host "Invalid action. Please try again."
        }
    }

}

function user_info { 

    $action = Read-Host "Choose action: ((s)how all user accounts, (g)et user description)"

    switch ($action) {
        "s" {
            # get list of user accounts 
            net user
        }
        "g" {
            $userdesc = Read-Host "Enter target user account"
             
            # list description of specific user account 
            Get-LocalUser -Name "$userdesc" | Select-Object Name, Description
        }
        default {
            Write-Host "Error: Not a valid argument,see proper usage below" 
            user_help
        }
    }
}

function privilege_manipulation {

    $targetuser = Read-Host "Enter target user account"
    $permdesc = Read-Host "Do you want to (a)dd or (r)emove permissions" 

    switch ($permdesc) {
        "r" {
            $desiredaction = Read-Host "Enter permissions to remove"
        }
        "a" {
            $desiredaction = Read-Host "Enter permissions to add"
        }
        default {
            Write-Host "ERROR" 
        }
    }

    # PASS OBJECT TO ANOTHER SCRIPT  
    .\permission_manager.ps1 $targetuser $desiredaction $permdesc
}

#main loop 
Write-Host "User management script by Colson Swope" 
Write-Host ""

if ($args.Count -eq 0) {
    Write-Host "Error: No arguments provided, see proper usage below" 
    user_help 

}
else {

    $choice = $args[0]
    
    switch ($choice) {
        "-m" {
            user_manager
        }
        "-i" {
            user_info
        }
        "-p" {
            privilege_manipulation
        }
        default {
            Write-Host "Error: Not a valid argument,see proper usage below" 
            user_help
        }
    }
}