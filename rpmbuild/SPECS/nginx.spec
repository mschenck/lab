%define ngx_home       /var/lib/nginx
%define ngx_user_group nginx

Name:           nginx
Version:        1.6.1
Release:        2%{?dist}
Summary:        an open source reverse proxy server for HTTP, HTTPS, SMTP, POP3, and IMAP protocols

Group:          Proxy Server
License:        2-clause BSD
URL:            http://wiki.nginx.org
Source0:        http://nginx.org/download/nginx-1.6.1.tar.gz
Source1:        nginx.init
Source2:        nginx.logrotate
Source3:        nginx.sysconfig

#BuildRequires:  
BuildRequires: gcc
BuildRequires: openssl-devel
BuildRequires: zlib-devel
BuildRequires: libxml2-devel
BuildRequires: gd-devel
BuildRequires: pcre-devel
BuildRequires: perl

Requires: openssl
Requires: initscripts >= 8.36
Requires(pre): shadow-utils
Requires(post): chkconfig

%description
Nginx (pronounced "engine-x") is an open source reverse proxy server for HTTP, HTTPS, SMTP, POP3, and IMAP protocols, as well as a load balancer, HTTP cache, and a web server (origin server). The nginx project started with a strong focus on high concurrency, high performance and low memory usage. It is licensed under the 2-clause BSD-like license and it runs on Linux, BSD variants, Mac OS X, Solaris, AIX, HP-UX, as well as on other *nix flavors.[6] It also has a proof of concept port for Microsoft Windows.[7]

%prep
%setup -q -n nginx-%{version}

%build
./configure \
  --user=nginx --group=nginx --prefix=/usr/share/nginx --sbin-path=/usr/sbin/nginx    \
  --conf-path=/etc/nginx/nginx.conf --lock-path=/var/lock/subsys/nginx                \
  --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log \
  --http-client-body-temp-path=/var/lib/nginx/tmp/client_body                         \
  --http-proxy-temp-path=/var/lib/nginx/tmp/proxy                                     \
  --http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi                                 \
  --http-uwsgi-temp-path=/var/lib/nginx/tmp/uwsgi                                     \
  --http-scgi-temp-path=/var/lib/nginx/tmp/scgi --pid-path=/var/run/nginx.pid         \
  --with-http_ssl_module                                                              \
  --with-http_realip_module                                                           \
  --with-http_image_filter_module                                                     \
  --with-http_sub_module                                                              \
  --with-http_gzip_static_module                                                      \
  --with-http_random_index_module                                                     \
  --with-http_secure_link_module                                                      \
  --with-http_stub_status_module                                                      \
  --with-file-aio                                                                     \
  --with-ipv6                                                                         \
  --with-http_random_index_module                                                     \
  --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic'

make %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT
chmod 0755 %{buildroot}%{_sbindir}/nginx
%{__install} -p -D -m 0755 %{SOURCE1} %{buildroot}%{_initrddir}/nginx
%{__install} -p -D -m 0644 %{SOURCE2} %{buildroot}%{_sysconfdir}/logrotate.d/nginx
%{__install} -p -D -m 0644 %{SOURCE3} %{buildroot}%{_sysconfdir}/sysconfig/nginx

%clean
rm -rf $RPM_BUILD_ROOT

%pre
/usr/sbin/groupadd -r %{ngx_user_group} &>/dev/null ||:
/usr/sbin/useradd -g %{ngx_user_group} -s /bin/false -r -c "user for %{ngx_user_group}" -m -d %{ngx_home} %{ngx_user_group} &>/dev/null ||:

%post
mkdir -p /var/log/nginx
chown %{ngx_user_group}:%{ngx_user_group} /var/log/nginx
mkdir -p /var/lib/nginx/tmp
chown -R %{ngx_user_group}:%{ngx_user_group} /var/lib/nginx/tmp


%files
%defattr(-,root,root,-)
/etc/logrotate.d/nginx
/etc/nginx/
%config(noreplace) /etc/nginx/nginx.conf
/etc/rc.d/init.d/nginx
/etc/sysconfig/nginx
/usr/sbin/nginx
/usr/share/nginx/html/50x.html
/usr/share/nginx/html/index.html
%doc

%changelog

