use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile
  (
   'NAME'	   => 'Puppet::LogBody',
   'VERSION_FROM' => 'LogBody.pm', # finds $VERSION
   'dist' => {COMPRESS=>'gzip -9f', SUFFIX => 'gz'},
   ($] >= 5.005 ?
    (ABSTRACT   => 'Logging facility (no Tk)',
     AUTHOR     => 'Dominique Dumont (ddumont@cpan.org)') : ()),
  );
