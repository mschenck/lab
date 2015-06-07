%define  debug_package %{nil}

%global __os_install_post %{nil}

Name:           mesos
Version:        0.21.1
Release:        1%{?dist}
Summary:        fault-tolerant job scheduling

Group:          Systems
License:        Apache license
URL:            http://mesos.apache.org/
Source0:        http://www.carfab.com/apachesoftware/mesos/0.21.1/mesos-0.21.1.tar.gz

AutoReqProv:    no
BuildRequires:  gcc
Requires:       glibc

%description
Apache Mesos abstracts CPU, memory, storage, and other compute resources away from machines (physical or virtual), enabling fault-tolerant and elastic distributed systems to easily be built and run effectively.

%prep
%setup -q -n %{name}-%{version}
rm -rf $RPM_BUILD_ROOT


%build
./bootstrap
mkdir build
cd build
../configure
make


%install
make install DESTDIR=$RPM_BUILD_ROOT


%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc

%changelog
