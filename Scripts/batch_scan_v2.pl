#!/tool/pandora64/.package/perl-5.8.8/bin/perl

#Used for scan the batch files (lp4/long) in the project directory for seeds information
#-dir, the proj directory
#-logdir, the seeds information logs location
#-size, if specified, the logs will contain the size information of each seed.
#-warnings, if specifed, the warning message will be print to the STDOUT.(0 sized seeds and empty batches with no seed)
#
#v2:
#change -size to -verbose 
#add lp4/lpx_seed, batch_no info in the verbose mode.

#-- use these packages
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
use File::Find;
use File::Basename;

#-- constants
our $FALSE = 0;
our $TRUE  = 1;


#-- command line
my $opt_scan_dir;
my $opt_log_dir;
my $opt_verbose;
my $opt_warnings;

&GetOptions(
	"dir:s"		=> \$opt_scan_dir,
	"logdir:s"	=> \$opt_log_dir,
	"verbose"	=> \$opt_verbose,
	"warnings"	=> \$opt_warnings,
	) or pod2usage(1);

#-- No undefined command line args are allowed.
pod2usage(-exitstatus => 1,
          -message => "$0: \"".join("|",@ARGV)."\" syntax error.")
    if (0 < @ARGV);

#-- check for required command line options
pod2usage(-exitstatus => 1,
          -message => "$0: syntax error, please specify the scan directory.")
    if (!($opt_scan_dir));

pod2usage(-exitstatus => 1,
          -message => "$0: syntax error, please specify the log directory.")
    if (!($opt_log_dir));


print "Scan directory is $opt_scan_dir\n";
print "Save directory is $opt_log_dir\n";
my $logdir_abs = File::Spec->rel2abs($opt_log_dir);

unless (-e $logdir_abs)
{
	die "Error: No such directory $logdir_abs\n";
}

find(\&scan_batch_lp4, $opt_scan_dir);
find(\&scan_batch_long, $opt_scan_dir);


#--------------------------------------------
sub scan_batch_lp4
{
	if (-d $File::Find::name)
	{
		return ($FALSE);
	}

	unless ($File::Find::name =~ m/\.tar$/)
	{
		return ($FALSE);
	}

	my $basenameTar = basename($File::Find::name);
	if ($basenameTar =~ m/_(\d+)_lp4/)
	{
		my $logName = $1.".txt";
		my $logPath = File::Spec->catfile($logdir_abs, $logName);
		open(CLOG, ">> $logPath");
		print CLOG "$File::Find::name:\n";
		close(CLOG);
		
		#print "Scan batch $basenameTar ...\n";
		&scan_batch($basenameTar, $logPath, $FALSE);
	}
	else
	{
		return ($FALSE);
	}
}

sub scan_batch_long
{
	if (-d $File::Find::name)
	{
		return ($FALSE);
	}

	unless ($File::Find::name =~ m/\.tar$/)
	{
		return ($FALSE);
	}

	my $basenameTar = basename($File::Find::name);
	if ($basenameTar =~ m/_(\d+)_long/)
	{
		my $logName = $1.".txt";
		my $logPath = File::Spec->catfile($logdir_abs, $logName);
		open(CLOG, ">> $logPath");
		print CLOG "$File::Find::name\n";
		close(CLOG);

		#print "Scan batch $basenameTar ...\n";
		&scan_batch($basenameTar, $logPath, $TRUE);
	}
	else
	{
		return ($FALSE);
	}
}

sub scan_batch
{
	my ($tarfile, $logPath, $islong) = @_;

	my $batch_no;
	if ($tarfile =~ m/_(\d+)_/)
	{
		$batch_no = $1;
	}

	my @tarlines = `tar -tvf $tarfile`;

	my $seed_number = 0;
	open(CLOG, ">> $logPath");
	foreach my $line (@tarlines)
	{
		my $keep = ($line =~ m/(amex.*\.tux64\.gz)/);
		if ($keep)
		{
			my $seed_name = $1;
		
			my $size;
			if ($line =~ m/\s(\d+)\s/)
			{
				$size = $1;
			}

			if ($opt_warnings)
			{
				if ($size == 0)
				{
					print "$batch_no: 0 $seed_name\n";
				}
			}

			if ($opt_verbose)
			{
				my $prefix;
				if ($islong)
				{
					$prefix = "lpx_seed";
				}
				else
				{
					$prefix = "lp4_seed";
				}
				#print CLOG "$prefix\t\t$size\t\t$seed_name\n";
				print CLOG "$prefix,$batch_no,$seed_name\n"
			}
			else
			{
				print CLOG "$seed_name\n";
			}
			$seed_number += 1;
		}
	}
	if ($opt_warnings)
	{
		if ($seed_number == 0)
		{
			print "$batch_no: seeds not found in $tarfile.\n";
		}
	}
	print CLOG "\n";
	close(CLOG);
}









