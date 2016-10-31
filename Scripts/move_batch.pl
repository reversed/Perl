#!/tool/pandora64/.package/perl-5.8.8/bin/perl

#-- use these packages
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
use File::Find;
use File::Basename;

#-- globals
my $srch_batch;

#-- constants
our $FALSE = 0;
our $TRUE  = 1;

#-- command line
my $opt_dir = ".";
my $opt_back = ".";
my $opt_batch_file;
my $opt_all =''; # false - copy only tar files; true - all files including csv

&GetOptions(
	"dir:s"		=> \$opt_dir,
	"batchfile:s"	=> \$opt_batch_file,
	"backdir:s"	=> \$opt_back,
	"all"		=> \$opt_all,
	) or pod2usage(1);

#-- No undefined command line args are allowed.
pod2usage(-exitstatus => 1,
          -message => "$0: \"".join("|",@ARGV)."\" syntax error.")
    if (0 < @ARGV);

#-- check for required command line options
pod2usage(-exitstatus => 1,
          -message => "$0: syntax error, missing required options.")
    if (!($opt_batch_file));


print "Scan directory is $opt_dir\n";
print "Backup directory is $opt_back\n";
my $backdir_abs = File::Spec->rel2abs($opt_back);

unless (-e $backdir_abs)
{
	die "Error: Can't open back directory $backdir_abs.\n";
}

if ($opt_batch_file)
{
	unless (-e $opt_batch_file)
	{
		die "Error: Can't open batch file $opt_batch_file.\n";
	}

	open(CLOG, "<$opt_batch_file");
	my @batcharray = <CLOG>;
	close(CLOG);

	foreach my $eachbatchline (@batcharray)
	{
		chomp($eachbatchline);
		chop($eachbatchline) if ($eachbatchline =~ m/\r$/);
		$srch_batch = $eachbatchline;

		if ($srch_batch)
		{
			print "\nStart moving batch $srch_batch ...\n";
			find(\&purge, $opt_dir);
		}
	}
}

#--------------------------------------------
sub purge
{
	if (-d $File::Find::name)
	{
		return ($FALSE);
	}
	move_tar($File::Find::name, $srch_batch);
}

#--------------------------------------------

sub move_tar
{
	my ($tarfile, $batch_no) = @_;

	# BUG, 207 may match 2207, 43207, 2071
	# Add '000' as prefix and '_' as postfix
	unless ($tarfile =~ m/000${batch_no}_/)
	{
		return ($FALSE);
	}

	unless ($opt_all)
	{
		unless ($tarfile =~ m/\.tar$/)
		{
			return ($FALSE);
		}
	}

	my $basenameTar = basename($tarfile);
	system("mv $basenameTar $backdir_abs");

	return ($TRUE);
}

