# Name: Colson Swope
# Date: 3/15/2024 
# Description: This is a script that an administrative professional can use for 
# efficient user account management, and for gathering information on these accounts. 
# This script can be used to strictly manage permissions for these user accounts as well. 

# Resources used: 
# https://superuser.com/questions/608931/list-all-user-accounts-on-a-windows-system-via-command-line
# https://learn.microsoft.com/en-us/powershell

####################################################################################################

# function that explains what the program does 
# function is called whenever user does not use the program correctly 
function user_help {
    Write-Host ""
    Write-Host "Usage: .\user_manager.ps1 [-arguments]" 
    Write-Host ""
    Write-Host "Arguments: " 
    Write-Host ""
    Write-Host "-m    Manage users (create, modify, and delete)" 
    Write-Host "-i    Display user information" 
    Write-Host "-p    Manipulate user privileges" 
    Write-Host ""
}

# function that creates, deletes, and modifies local user accounts 
# options to modify the user account description are available as well 
function user_manager {

    $action = Read-Host "Choose action: ((c)reate, (d)elete, (m)odify)"

    # perform user management actions based on the provided input 
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

                    Write-Host "Arguments out of range. (1)" 
                    Write-Error "Arguments out of range. (1)" 2> error.log
                    exit 1 
                }
            }
        }
        default {
            Write-Host "Arguments out of range. (2)" 
            Write-Error "Arguments out of range. (2)" 2> error.log
            exit 1 
        }
    }

}

# function that retrieves information on the local created user accounts 
function user_info { 

    $action = Read-Host "Choose action: ((s)how all user accounts, (g)et user description)"

    # perform user info actions based on provided input 
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
            Write-Host "Arguments out of range. (3)" 
            Write-Host "" 
            Write-Error "Arguments out of range. (3)" 2> error.log
            exit 1  
            user_help
        }
    }
}

# function that passes arguments to another script 
# used for adding and removing specified user permissions 
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
            Write-Host "Arguments out of range. (4)" 
            Write-Host "" 
            Write-Error "Arguments out of range. (4)" 2> error.log
            exit 1
        }
    }

    # PASS OBJECT TO ANOTHER SCRIPT  
    .\permission_manager.ps1 $targetuser $desiredaction $permdesc
}

#main loop 
Write-Host "User management script by Colson Swope" 
Write-Host ""

# provide error if arguments are not provided 
if ($args.Count -eq 0) {
    Write-Host "No arguments provided, see proper usage below. " 
    Write-Host ""
    Write-Error "No arguments provided, see proper usage below. (5)" 2> error.log
    user_help
    exit 1
     

}
else {

    $choice = $args[0]
    
    # call a function associated with the specified user input 
    switch ($choice) {
        "-m" {
            user_manager
            exit 0 
        }
        "-i" {
            user_info
            exit 0 
        }
        "-p" {
            privilege_manipulation
            exit 0 
        }
        default {
            Write-Host "Arguments out of range. See proper usage below. (6)" 
            Write-Host "" 
            Write-Error "Arguments out of range. See proper usage below. (6)" 2> error.log
            user_help
            exit 1
        }
    }
}
