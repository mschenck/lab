Name:           bandwidth
Version:        1.0
Release:        1%{?dist}
Summary:        a memory bandwidth benchmark

Group:          Applications/Benchmark
License:        GPLv2
URL:            http://zsmith.co/bandwidth.html
Source0:        http://zsmith.co/archives/bandwidth-1.0.tar.bz2

BuildRequires:  nasm
#Requires:       

%description
bandwidth, is an artificial benchmark primarily for measuring memory bandwidth on x86 and x86_64 based computers, useful for identifying weaknesses in a computer's memory subsystem, in the bus architecture, in the cache architecture and in the processor itself.
Despite the focus on memory testing, in release 0.24 I also added network bandwidth testing. The results are graphed.

bandwidth also tests some libc functions and, under Linux, it attempts to test framebuffer memory access speed if the framebuffer device is available.

%prep
%setup -q


%build
# make %{?_smp_mflags}
make bandwidth64


%install
rm -rf $RPM_BUILD_ROOT

mkdir -p $RPM_BUILD_ROOT/usr/bin
cp bandwidth64 $RPM_BUILD_ROOT/usr/bin/bandwidth64

mkdir -p $RPM_BUILD_ROOT/usr/share/doc/%{name}-%{version}
cp README.txt $RPM_BUILD_ROOT/usr/share/doc/%{name}-%{version}/README.txt

%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc
/usr/bin/bandwidth64
/usr/share/doc/bandwidth-1.0/README.txt

%changelog
