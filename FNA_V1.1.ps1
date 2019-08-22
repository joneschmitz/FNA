function main{
    Write-Host "Enter mode:`n1 Default`n2 Safe Mode`n`n** Safe Mode creates copies of all files with new names. **`n** This mode will run slower as it must copy every file in the folder. **"
    $case = Read-Host ">"
    While (($case -ne "1") -and ($case -ne "2")){
        $case = Read-Host "Invalid mode. Retry or enter 'X' to exit.`n>"
        if (($case -eq "x") -or ($case -eq "X")){
            Exit
        }
    }
    $lvl = Read-Host "`nPick an option:`n1 Increase numbers for all filenames.`n2 Decrease numbers for all filenames.`n>"
    While (($lvl -ne "1") -and ($lvl -ne "2")){
        $lvl = Read-Host "Invalid entry. Enter 1 or 2, or enter 'X' to exit.`n>"
        if (($lvl -eq "x") -or ($lvl -eq "X")){
            Exit
        }
    }
    getLocation
}
function idOp{
    $lvl = Read-Host "`nPick an option:`n1 Increase numbers for all filenames.`n2 Decrease numbers for all filenames.`n>"
    While (($lvl -ne "1") -and ($lvl -ne "2")){
        $lvl = Read-Host "Invalid entry. Enter 1 or 2, or enter 'X' to exit.`n>"
        if (($lvl -eq "x") -or ($lvl -eq "X")){
            Exit
        }
    }
    enterNum
}
function getLocation{
    $loc = Read-Host "`nEnter folder location or 1 if running from current folder"
    if ($loc -eq "1"){
        Write-Host "`nRunning for current directory"
        $loc = Get-Location
    }#run in current directory
    else {
        While (!(Test-Path $loc)){
            $loc = Read-Host "invalid path entered. Try again or enter 'X' to exit"
            if (($loc -eq "x") -OR ($loc -eq "x")){
                Exit
            }
        }
        set-Location $loc
        Write-Host "`nRunning for directory $loc"
    }#enter directory w/ verification
    $fn= Get-ChildItem -Name
    $fn = reorder $fn
    verification
}#goes to verification
function verification{
    Write-Host "`nThe files you have chosen to modify are:`n"
    if ((Get-ChildItem -Name).Count -eq 1){
        Write-Host Get-ChildItem -Name    
    }#1 file print file
    else{
        for ($i=0;$i -lt $fn.Count;$i+=1){ #else for loop through remainder
            Write-Host $fn[$i]
        }
    }
    $vrfy = Read-Host "Is this correct? (Y/N)"
    While (($vrfy -ne "y") -and ($vrfy -ne "Y") -and ($vrfy -ne "n") -and ($vrfy -ne "N")){
        $vrfy = Read-Host "Invalid entry. Enter Y or N, or enter 'X' to exit.`n>"
        if (($vrfy -eq "x") -or ($vrfy -eq "X")){
            Exit
        }
    }
    if (($vrfy -eq "y") -or ($vrfy -eq "Y")){
        enterNum
    }
    if (($vrfy -eq "n") -or ($vrfy -eq "N")){
        $x = Read-Host "Do you wish to enter a new folder location? (Y/N)`n>"
        While (($x -ne "y") -and ($x -ne "Y") -and ($x -ne "n") -and ($x -ne "N")){
            $x = Read-Host "Invalid entry. Enter Y or N`n>"
            if (($x -eq "x") -or ($x -eq "X")){
                Exit
            }
        }
        if (($x -eq "y") -or ($x -eq "Y")){
            getLocation
        }
    }
}#branches to enterNum or getLocation
function enterNum{
    $start = Read-Host "`nEnter new starting #"
    While (!($start -match '\d+')){
        $start = Read-Host "Enter new starting NUMBER or 'X' to exit"
        if (($start -eq "x") -or ($start -eq "X")){
            Exit
        }
    }
    $start = [int]$start
    $ep = 0
    $count = (Get-ChildItem $loc | Measure-Object).Count
    $check = $fn[0]
    for ($u=$check.Length;$u -ge 0;$u-=1){
        if(($check[$u] -match "\d")){
            Break
        }
    }
    $u=$check.Length-$u-1
    $null = $check -match "(\d+).{$u}$"
    $check = $Matches[1]
    if (($lvl -eq "1") -and ($start -lt $check)){
        Write-Host "`nYou must enter a number higher than that contained in the first file: $check."
        idOp
    }
    if (($lvl -eq "2") -and ($start -gt $check)){
        Write-Host "`nYou must enter a number lower than that contained in the first file: $check."
        idOp
    }

    if ($lvl -eq "1"){
        increment
    }
    elseif ($lvl -eq "2"){
        decrement
    }
    else{Write-Host "Error in option picked."}
}
function prompt{
#    $ask = Read-Host "Enter option:`n1 Remove copies and exit program.`n2 Enter a new filename.`n3 Re-enter starting number.`n>"
    $ask = Read-Host "Enter option:`n1 Remove copies and exit program.`n2 Re-enter starting number.`n>"
    While (($ask -ne "1") -and ($ask -ne "2") -and ($ask -ne "3")){
#        $ask = Read-Host "Invalid entry. Enter 1, 2, or 3, or enter 'X' to exit.`n>"
        $ask = Read-Host "Invalid entry. Enter 1 or 2, or enter 'X' to exit.`n>"
        if (($ask -eq "x") -or ($ask -eq "X")){
            Exit
        }
    }
    switch ($ask) {
        "1" {
            remove 2
            Exit
        }#remove copies and exit
 #       "2" {
 #           newFilename
 #           break
 #       }#re-enter filename
        "2" {
            remove 3
            enterNum
            break
        }#re-enter starting #
    }
}
function remove{
    Param ($a)
    if($a -eq 1){
        $trm = Get-ChildItem -Name -Exclude _*
		$trm = reorder $trm
    }
    else{
        $trm = Get-ChildItem -Name -Include _*
		$trm = reorder $trm
    }
    if ($trm.Count -eq 1){
        Remove-Item $trm
    }
    else{
        for ($o=0;$o -lt $trm.count;$o+=1){
            Remove-Item $trm[$o]
        }
    }
    if($a -eq 2){Exit}
}#uses: inputted mode result: files matching pattern are removed
#function newFilename{ #This section may be properly implemented in later versions
#    remove 3
#    $nfn = Read-Host "Enter new filename. (Must contain a number)`n>"
#    #filename verification *\d* and *$ext
#    while (!($nfn -match ".*\d.*")){
#        $nfn = Read-Host "Filename must contain a number to increment/decrement or enter 'X' to exit.`n>"
#        if (($nfn -eq "x") -or ($nfn -eq "X")){
#            Exit
#        }
#    }
#    
#
#    if ($lvl -eq "1"){
#        increment
#        Exit
#    }
#    elseif ($lvl -eq "2"){
#        decrement
#        Exit
#    }
#    else{Write-Host "Error. lvl variable unaccessible."}
#}#branch to increment or decrement
function charOut{
    $gci = Get-ChildItem -Name
    $gci = reorder $gci
    for ($g=0;$g -lt $gci.Count;$g+=1){
        $null = $gci[$g] -match "_(.*)"
        Rename-Item $gci[$g] $Matches[1]
    }
}
function displayCopied{
    $list = Get-ChildItem -Name -Include _*
    $list = reorder $list
    Write-Host "`n"
    for ($i=0;$i -lt $list.count;$i++){
        Write-Host $list[$i]
    }
    $yes = Read-Host "`nIs this numbering format correct? (Y/N)`n>"
    While (($yes -ne "y") -and ($yes -ne "Y") -and ($yes -ne "n") -and ($yes -ne "N")){
        $yes = Read-Host "Invalid entry. Enter Y or N, or enter 'X' to exit.`n>"
        if (($yes -eq "x") -or ($yes -eq "X")){
            Exit
        }
    }
    if (($yes -eq "y") -or ($yes -eq "Y")){
        remove 1
        charOut    #make function to remove _ in filename
                   #ex $fn -match "_(*)" where $Matches[1] is correct name
    }
    if (($yes -eq "n") -or ($yes -eq "N")){
        prompt     #make function ask the following options:
                   #1 Remove copies and exit program
                   #2 Enter a new filename
                   #3 Re-enter starting number
    }
}
function reorder{
    param ($objArr) 
    $size = $objArr.Count
    $fz = $objArr[0]
    $flagA=0
    $flagB=0
    $ext=""
    for ($c=$fz.Length-1;$c -ge 0;$c-=1){
        if(($fz[$c] -match '\d') -and ($flagA -ne 1)){
            $flagA=1
            $flagB=1
        }
        if($flagB -eq 1){
            $ext=$c
            $flagB=0
        }
        if(($flagA -eq 1) -AND !($fz[$c] -match '\d')){
            break
        }
    }
    $flagA=$ext-$c
    $c+=1
    $ext=$fz.Length-$ext-1
    if ($size -ne 1){
        $num = 0..($size-1)#create arr as large as number of files in folder
        for ($v=0;$v -lt $size;$v+=1){
            $flg=0
            $numSize=0
            for ($ns=($objArr[$v].length-1);$ns -ge 0;$ns-=1){#starting from the last char in string
                if($objArr[$v][$ns] -match "\d"){$flg=1;}#Write-Host "number match"}#find number location
                if($flg -eq 1){$numSize+=1;}#Write-Host "numSize+=1"}#and count the length of the number
                if(($flg -eq 1) -and !($objArr[$v][$ns] -match "\d")){
                    $ns=-1
                }
            }
            $numSize-=1
            $null = $objArr[$v] -match ".*(\d{$numSize}).{$ext}"
            $num[$v] = [int]$Matches[1]
        }
        for ($p=0;$p -lt $size;$p+=1){
            for($q=0;$q -lt $size-1;$q+=1){
                #Write-Host "Comparing "$num[$q]"and"$num[$q+1]":"($num[$q] -gt $num[$q+1])
                if ([int]$num[$q] -gt [int]$num[$q+1]){
                    $temp = $objArr[$q]
                    $objArr[$q] = $objArr[$q+1]
                    $objArr[$q+1] = $temp
                    $temp = $num[$q]
                    $num[$q] = $num[$q+1]
                    $num[$q+1] = $temp
                    #Write-Host "swapped "$num[$q+1]"and"$num[$q]
                }
            }
        }
    }
    return $objArr
}
function safeModeReName{
    Param ($f)
    $flagA=0
    $flagB=0
    $ext=""
    for ($c=$f.Length-1;$c -ge 0;$c-=1){
        if(($f[$c] -match '\d') -and ($flagA -ne 1)){
            $flagA=1
            $flagB=1
        }
        if($flagB -eq 1){
            $ext=$c
            $flagB=0
        }
        if(($flagA -eq 1) -AND !($f[$c] -match '\d')){
            break
        }
    }
    $flagA=$ext-$c
    $c+=1
    $ext=$f.Length-$ext-1
    $null = $f -match "(.{$c})\d{$flagA}(.{$ext})"
    #Write-Host "Surrounding text is '"$Matches[1]"' and '"$Matches[2]"'"
    $extension=$Matches[2]
    $newName = $Matches[1]+$ep+$Matches[2]
    #Write-Host $count " -> " $newName
    Copy-Item $f "_$newName"
    Write-Host "Copy Made: $newName"
}#finished?
function increment{
    if ($case -eq "2"){
        for ($i=$count - 1;$i -ge 0;$i-=1){
            $ep = [int]$start+$i
            #Write-Host $ep
            safeModeRename $fn[$i]
        }
        displayCopied
    }
    else{
        for ($i=$count - 1;$i -ge 0;$i-=1){
            $ep = [int]$start+$i
            #Write-Host $ep
            rename $fn[$i]
        }
    }
}#uses: $case,$start result: run safeModeRename or rename for every file
function decrement{#assigning files in reverse order
    if ($case -eq "2"){
        for ($i=0;($i -lt $count) -and ($count -gt $i);$i+=1){
            $ep = [int]$start+$i
            safeModeRename $fn[$i]
        }
        displayCopied
    }
    else{
        for ($i=0;($i -lt $count) -and ($count -gt $i);$i+=1){
            $ep = [int]$start+$i
            #Write-Host $ep
            rename $fn[$i]
        }
    }
}#uses: $case,$start result: run safeModeRename or rename for every file
function rename{
    Param ($f)
    $flagA=0
    $flagB=0
    $ext=""
    for ($c=$f.Length-1;$c -ge 0;$c-=1){
        if(($f[$c] -match '\d') -and ($flagA -ne 1)){
            $flagA=1
            $flagB=1
        }
        if($flagB -eq 1){
            $ext=$c
            $flagB=0
        }
        if(($flagA -eq 1) -AND !($f[$c] -match '\d')){
            break
        }
    }
    $flagA=$ext-$c
    $c+=1
    $ext=$f.Length-$ext-1
    $null = $fn[$i] -match "(.{$c})\d{$flagA}(.{$ext})"
    #Write-Host "Surrounding text is '"$Matches[1]"' and '"$Matches[2]"'"
    $extension = $Matches[2]#redundant statement for future updates
    $newName = $Matches[1]+$ep+$Matches[2]
    Write-Host $f " -> " $newName
    Rename-Item $f $newName
}#uses: $i result: renamed file
$again = 'y'
While(($again -eq 'y') -or ($again -eq 'Y')){
    $again = 'n'
    main
    $again = Read-Host "`nDo you wish to run the program again? (Y/N)`n>"
}
Exit
