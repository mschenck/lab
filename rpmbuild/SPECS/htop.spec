Name:           htop
Version:        1.0.3
Release:        1%{?dist}
Summary:        an interactive process viewer for Linux

Group:          Applications/System
License:        GPLv2
URL:            http://hisham.hm/htop/index.php
Source0:        http://hisham.hm/htop/releases/1.0.3/htop-1.0.3.tar.gz

BuildRequires:  ncurses-devel
#Requires:       

%description
This is htop, an interactive process viewer for Linux. It is a text-mode application (for console or X terminals) and requires ncurses.

%prep
%setup -q


%build
%configure
make %{?_smp_mflags}


%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT


%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc
/usr/bin/htop
/usr/share/applications/htop.desktop
/usr/share/man/man1/htop.1.gz
/usr/share/pixmaps/htop.png



%changelog
