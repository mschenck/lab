%define  debug_package %{nil}

%global __os_install_post %{nil}

Name:           go
Version:        1.3
Release:        1%{?dist}
Summary:        open source programming language that makes it easy to build simple, reliable, and efficient software.

Group:          Development/Languages
License:        BSD license
URL:            http://golang.org/
Source0:        http://golang.org/dl/go1.3.src.tar.gz

AutoReqProv:    no
BuildRequires:  gcc
Requires:       glibc

%description
Go is expressive, concise, clean, and efficient. Its concurrency mechanisms make it easy to write programs that get the most out of multicore and networked machines, while its novel type system enables flexible and modular program construction. Go compiles quickly to machine code yet has the convenience of garbage collection and the power of run-time reflection. It's a fast, statically typed, compiled language that feels like a dynamically typed, interpreted language.

%prep
%setup -q -n %{name}
rm -rf $RPM_BUILD_ROOT


%build
cd src
export GOROOT=$RPM_BUILD_ROOT
export GOROOT_FINAL=/usr/local/go
./make.bash

%install
mkdir -p $RPM_BUILD_ROOT/usr/local/
mkdir -p $RPM_BUILD_ROOT/etc/profile.d/

cp -r $RPM_BUILD_DIR/go $RPM_BUILD_ROOT/usr/local/

echo "
export GOARCH=amd64
export GOOS=linux
export PATH=\$PATH:/usr/local/go/bin" > $RPM_BUILD_ROOT/etc/profile.d/go.sh

chmod +x $RPM_BUILD_ROOT/etc/profile.d/go.sh

%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc
/usr/local/go
/etc/profile.d/go.sh

%changelog
