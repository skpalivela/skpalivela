#!/usr/bin/perl


#program to read all the files in a child
#current directory and replace an old
#string with the new one.
#Puts the changed files in the working directory
#and leaves the original files in child directory
#unchanged.



#get sub-directory in which files to be scanned
#and changed are located in.
print "\n Which directory are the files to be changed located in? ";
$directory = <STDIN>;
chomp($directory);


#get old string to replace and new string
#from user on command line
print "\nEnter the old string to be replaced?  ";
$oldString = <STDIN>;
chomp($oldString);

print "\nEnter is the new string?  ";
$newString = <STDIN>;
chomp($newString);

#last chance to bail before changing files
print "\nAre you sure you want to replace $oldString with $newString? y or n:";
$answer = <STDIN>;
chomp($answer);

if( $answer eq "y" ) {
   print( "Altering files now...\n" );
} else {
     die ( "No changes were made, try again!\n" );
}


#switch to sub-directory of files to scan and change
#read current working directory and store file names in @flist

opendir( INDIR, "./$directory") || die ("$0: Can not read directory");

while( $fname = readdir INDIR){
    next if $fname =~ /^\./;  #not hidden
    next if $fname =~ /^\.\.?$/;  #it's pwd or parent
    next if $fname =~ "fnReplacestrings.pl";
    push @flist, $fname;
}
closedir(INDIR);

system ("cd $directory");


#read each file and switch strings if needed
#write to a file named temp in current dir
#if changed any lines, let user know and copy
#temp to correct file name in current directory
foreach $fn (@flist) {

    open( IN, "$directory/$fn")  || die ("\n can not read $fn \n");
    open( OUT, ">temp") || die ("\n can not write $fn \n");
    $flag = 0;
    $lineNo = 0;

    while( <IN> ){	
	
	$lineNo++;
	$line = $_;

	if ( $line =~ m/$oldString/ ) { $flag = 1; } 
	$line =~ s/$oldString/$newString/ && print "\n Changed: $fn, line: $lineNo \n";
	print OUT "$line";
    }

    close(IN);
    close(OUT);
 
    if($flag){
	rename (temp, $fn) || die "couldn't rename temp to $fn.\n";    
    }
}
