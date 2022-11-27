#!/bin/perl
if ($#ARGV<1) {
  print "\n*** Bad usage, please use the command as the following line:\n";
  print "Module2Instvhdl.pl -InputFile <Input file name> -Block_Name <block name>\n";
  print "example:\n Module2Instvhdl\.pl -InputFile input_file_name\.txt -Block_Name block_name\n";
  exit;
}
$token=$ARGV[0];
while ($ARGV=shift) {
  if ($token =~ /^-InputFile/) {
    print "input_file= $ARGV[0] \t";
    $input_file=$ARGV[0];
  }
  if ($token =~ /^-Block_Name/) {
    print "Block Name : $ARGV[0] \n";
    $Block_Name=$ARGV[0];
  }
  shift;
  $token=$ARGV[0];
}
$InstFile = "$Block_Name\_Inst\.txt";
$WireInputFile = "$Block_Name\_WireIN\.txt";
$WireOutputFile = "$Block_Name\_WireOUT\.txt";
$WireIOFile = "$Block_Name\_IO\.txt";
print "\n";
print "inst file       : $InstFile\n";
print "WireInput file  : $WireInputFile\n";
print "WireOutput file : $WireOutputFile\n";
print "WireIO file     : $WireIOFile\n";

open (READ_FILE,$input_file) || die "error: Can't open $InstFile ";
open (WRITE_wireIN_FILE,">$WireInputFile") || die "error: Can't open $WireInputFile ";
open (WRITE_wireOUT_FILE,">$WireOutputFile") || die "error: Can't open $WireOutputFile ";
open (WRITE_inst_FILE,">$InstFile") || die "error: Can't open $InstFile ";
open (WRITE_IO_FILE,">$WireIOFile") || die "error: Can't open $WireIOFile ";
while ($line = <READ_FILE>) {
#	APB_M_0_paddr : out STD_LOGIC_VECTOR ( 31 downto 0 )
#	if ($line =~ /input\s*\[\s*(\S+)\s*\:\s*(\S+)\s*\]\s*(\S+)\s*\,/){
	if ($line =~ /(\S+)\s*\:\s*(\S+)\s*(\S+)\s*\(\S+)\s*\;/){
		print WRITE_inst_FILE "\t$1 $4 => $1 $4\,\n";
		if ($2 =~ /in/){
			print WRITE_wireIN_FILE "signal $1 \: $3  $4\;\n";
		} elsif ($2 =~ /out/){
			print WRITE_wireOUT_FILE "signal $1 \: $3  $4\;\n";
		} elsif ($2 =~ /inout/){
			print WRITE_wireOUT_FILE "signal $1 \: $3  $4\;\n";
		}		
	}
#	APB_M_0_penable : out STD_LOGIC;
	if ($line =~ /(\S+)\s*\:\s*(\S+)\s*(\S+)\s*\;/){
		print WRITE_inst_FILE "\t$1 => $1 \,\n";
		if ($2 =~ /in/){
			print WRITE_wireIN_FILE "signal $1 \: $3\;\n";
		} elsif ($2 =~ /out/){
			print WRITE_wireOUT_FILE "signal $1 \: $3\;\n";
		} elsif ($2 =~ /inout/){
			print WRITE_wireOUT_FILE "signal $1 \: $3\;\n";
		}		
	}
}
close(WRITE_IO_FILE);
close(WRITE_inst_FILE);
close(WRITE_wireOUT_FILE);
close(WRITE_wireIN_FILE);
close(READ_FILE);
