# function for user help 

# NEED TWO ITERATION FUNCTIONS 
# NEED SIX CONDITIONAL FUNCTIONS, ONE SWITCH STATEMENT 
# MUST OPERATE ON FOUR OBJECTS 
# ACCEPT OBJECT FROM ANOTHER SCRIPT 
# PASS OBJECT TO ANOTHER SCRIPT 
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

function test_args() {

    Write-Host "here is arg 0: $($args[0])"
    Write-Host "here is arg 1: $($args[1])"

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
        "1" {
            
        }
        "2" {
        
        }
        "3" {
        
        }
        default {
            Write-Host "Error: Not a valid argument,see proper usage below" 
            user_help
        }
    }

}