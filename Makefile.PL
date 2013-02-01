use inc::Module::Install;
use Config ();

if (! $Config::Config{use64bitint}) {
    print STDERR <<EOM;

This module requires perl with 64 bit int

EOM
    exit 1;
}

name 'Data-STUID';
all_from 'lib/Data/STUID.pm';
requires 'Class::Accessor::Lite';
requires 'Errno';
requires 'IPC::Semaphore';
requires 'IPC::SysV';
requires 'List::Util';
requires 'Net::Server';
requires 'Task::Weaken';
requires 'Time::HiRes';

no_index directory => 'misc';

WriteAll;
