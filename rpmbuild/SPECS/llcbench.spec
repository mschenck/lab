Name:           llcbench
Version:        1.10
Release:        1%{?dist}
Summary:        LLCbench (Low-Level Characterization Benchmarks) was created by combining MPBench, CacheBench, and BLASBench into a single benchmark package.

Group:          Applications/Benchmark
License:        GPLv3
URL:            http://icl.cs.utk.edu/projects/llcbench/index.htm
Source0:        http://icl.cs.utk.edu/projects/llcbench/llcbench.tar.gz

BuildRequires:  gcc
#Requires:       

%description
LLCbench (Low-Level Characterization Benchmarks) was created by combining MPBench, CacheBench, and BLASBench into a single benchmark package.

%prep
%setup -q -n %{name}


%build
#%configure
#make %{?_smp_mflags} linux-mpich
make linux-mpich


%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT


%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc



%changelog
