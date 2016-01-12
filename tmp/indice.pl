#!/usr/bin/perl
my @liste1 = ( "a","b","c");
print "depart : @liste1 : ", scalar(@liste1),"\n";
@liste1=();
print "avec =() : @liste1 : ", scalar(@liste1),"\n";
@liste1=("a");
print "avec =() puis ajout de a : @liste1 : ", scalar(@liste1),"\n";
undef (@liste1);
print "avec undef : @liste1 : ", scalar(@liste1),"\n";
