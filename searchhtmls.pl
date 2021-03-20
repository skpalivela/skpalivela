#!/usr/bin/perl -w

opendir(DIR, ".");
@files = grep(/\.html$/,readdir(DIR));
closedir(DIR);

foreach $file (@files) {
   print "$file\n";
}
