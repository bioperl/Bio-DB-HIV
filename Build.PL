use Module::Build;
use File::Find;
my $pm_files = {};
my $build = Module::Build->new(
  dist_name => 'Bio-DB-HIV',
  dist_abstract => 'BioPerl object interface to the Los Alamos HIV Sequence Database',
  dist_author => 'BioPerl',
  dist_version => '1.7.6', # current bp version on CPAN
  license => 'perl',
  # pm_files => $pm_files,
  config_requires => {
    'Module::Build' => 0
   },
  build_requires => {
    # 'Bio::Root::Test' => 0, (in shadowlib)
    'Test::Most' => 0,
    'Test::Builder' => 0,
    'Test::Builder::Module' => 0,
  },
  requires => {
    'LWP::UserAgent' => 0,
    'HTTP::Request::Common' => 0,
    'HTTP::Response' => 0,
    'IO::String' => 0,
    'Error' => 0,
    'XML::Simple' => 0,
    'CGI' => 0,
  },
);
find( { no_chdir => 1,
	wanted => sub {
	  /\.pm$/ && ($pm_files->{$_} = $_);
	  /\.xml/ &&  ($pm_files->{$_} = $_);
	 },
      },
      'lib' );
find( { no_chdir => 1,
	wanted => sub {
	  /\.pm$/ && do {
	    my ($mod) = m|.*/(Bio.*)\.pm$|;
	    $mod =~ s|/|::|g;
	    $pm_files->{$_} = s/shadow//r unless
	      $build->check_installed_version($mod) # check for bioperl
	  }
	 },
      },
      'shadowlib' );
$build->pm_files($pm_files);
$build->create_build_script;

