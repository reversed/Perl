#!/tool/pandora64/.package/perl-5.8.8/bin/perl

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

#-- globals
my $srch_tux = "";
my $srch_batch ="";

#-- command line
my $opt_dir = ".";
my $opt_back = ".";
my $opt_seed_file;

&GetOptions(
	"dir:s"		=> \$opt_dir,
	"seedfile:s"	=> \$opt_seed_file,
	"backdir:s"	=> \$opt_back,
	) or pod2usage(1);

#-- No undefined command line args are allowed.
pod2usage(-exitstatus => 1,
          -message => "$0: \"".join("|",@ARGV)."\" syntax error.")
    if (0 < @ARGV);

#-- check for required command line options
pod2usage(-exitstatus => 1,
          -message => "$0: syntax error, missing required options.")
    if (!($opt_seed_file));


print "Scan directory is $opt_dir\n";
print "Backup directory is $opt_back\n";
my $backdir_abs = File::Spec->rel2abs($opt_back);

if ($opt_seed_file)
{
	unless (-e $opt_seed_file)
	{
		die "Error: Can't open seed file $opt_seed_file.\n";
	}

	open(CLOG, "<$opt_seed_file");
	my @seedarray = <CLOG>;
	close(CLOG);

	foreach my $eachseedline (@seedarray)
	{
		chomp($eachseedline);
		chop($eachseedline) if ($eachseedline =~ m/\r$/);
		my @seed_content = split(',', $eachseedline);
		my $seed_part1 = $seed_content[0];
		my $seed_batch = $seed_content[1];

		my $seed_tux;
		if ($seed_part1 =~ m/(amex.*_\d+_pd.*\.tux64)/)
		{
			$seed_tux = $1;
		}

		if ($seed_tux && $seed_batch)
		{
			$srch_batch = $seed_batch;
			$srch_tux = "$seed_tux";

			print "\nStart Purging seed $seed_tux ...\n";
			find(\&purge, $opt_dir);
		}
		else
		{
			print "Error: Seed or Batch ID missing in the seed file.\n";
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

	clean_seed_csv($File::Find::name, $srch_tux, $srch_batch);
	clean_seed_tar($File::Find::name, $srch_tux, $srch_batch);
}

#--------------------------------------------
sub clean_seed_csv
{
	my ($csvfile, $findString, $batch_no) = @_;

	unless ($csvfile =~ m/$batch_no/)
	{
		return ($FALSE);
	}

	unless ($csvfile =~ m/\.csv$/)
	{
		return ($FALSE);
	}

	my $basenameCsv = basename($csvfile);

	open(CLOG, "<$basenameCsv");
	my @csvlines = <CLOG>;
	close(CLOG);

	open(CLOG, ">$basenameCsv");
	my $lineNumber = 0;
	foreach my $line (@csvlines)
	{
		$lineNumber++;
		my $nokeep = (($line =~ m/$findString/) && ($line =~ m/AMEX_Loader/));
		if ($nokeep)
		{
			print "remove line $csvfile($lineNumber): $line\n";
		}
		else
		{
			print CLOG $line;
		}
	}
	close(CLOG);
	
	return ($TRUE);
}

#--------------------------------------------
sub clean_seed_tar
{
	my ($tarfile, $findString, $batch_no) = @_;

	unless ($tarfile =~ m/$batch_no/)
	{
		return ($FALSE);
	}

	unless ($tarfile =~ m/\.tar$/)
	{
		return ($FALSE);
	}

	my $basenameTar = basename($tarfile);
	my ($bname, $bpath, $bsuffix) = fileparse($tarfile, "\.[^.]*");
	my $fullCopyDir = File::Spec->catdir($backdir_abs, $bpath, $bname);
#	$basedirTar = dirname($tarfile);
#	$fullCopyDir = File::Spec->catdir($backdir_abs, $basedirTar);

	# test if seed exists in the target tar file.
	my @outputPath = `tar -tf $basenameTar | grep "$findString"`;
	unless ($outputPath[0])
	{
		# return here, if not exist.
		return ($TRUE);
	}

	# if exists, untar the tarfile
	system("tar -xf $basenameTar");

	foreach my $outputOnePath (@outputPath)
	{	
		# backup then delete the seed
		chomp($outputOnePath);
		system("mkdir -p $fullCopyDir && cp $outputOnePath $fullCopyDir");
		system("rm $outputOnePath");
		print "remove file in $tarfile: $outputOnePath\n\n";
	}

	# modify the checksums
	my $outputDir = `dirname $outputPath[0]`;
	chomp($outputDir);
	my $outputBase = "checksums.txt";
	my $checksum_path = ${outputDir}.'/'.${outputBase};

	if (-e $checksum_path)
	{
		open(CLOG, "<$checksum_path");
		my @cslines = <CLOG>;
		close(CLOG);

		open(CLOG, ">$checksum_path");
		my $lineNumber = 0;
		foreach my $line (@cslines)
		{
			$lineNumber++;
			my $nokeep = ($line =~ m/$findString/);
			if ($nokeep)
			{
				print "remove line in $tarfile checksum.txt($lineNumber): $line\n";
			}
			else
			{
				print CLOG $line;
			}
		}
		close(CLOG);
	}

	# retar the tar file with changes
	system("tar -cf $basenameTar $outputDir");

	# remove the temp dir
	system("rm -rf $outputDir");

	return ($TRUE);
}

