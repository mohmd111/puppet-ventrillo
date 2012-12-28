Name            : Ventrilo
Version         : 3.0.3
Release         : 1
Summary         : Ventrilo Server
Group           : System Environment/Daemons
Source0         : ventrilo_srv-3.0.3-Linux-i386.tar.gz
Source1         : ventrilo.init
URL             : http://www.ventrilo.com/
Vendor          : Flagship Industries
License         : CDDL
Packager        : Wolf Noble
BuildArch       : i386 x86_64
BuildRoot       : %{_tmppath}/%{name}-%{version}-root
Requires        : glibc
Requires(pre)   : shadow-utils
AutoReq   : 0

%description
Ventrilo 3.0.0 is the next evolutionary step of Voice over IP (VoIP) group communications software. Ventrilo is also the industry standard by which all others measure themselves as they attempt to imitate its features.

%prep
mkdir -p $RPM_BUILD_ROOT/usr/local/
%build
cd $RPM_BUILD_ROOT/usr/local/
zcat $RPM_SOURCE_DIR/ventrilo_srv-3.0.3-Linux-i386.tar.gz | tar -xvf -
%install

install -d -m 755 %{buildroot}%{_initrddir}
install -p -m 755 %{SOURCE1} %{buildroot}%{_initrddir}/ventrilo

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root)
%dir %{_initrddir}/ventrilo
%dir /usr/local/ventsrv
%attr(-,ventrilo,ventrilo) /usr/local/ventsrv

%pre
getent group ventrilo >/dev/null || groupadd -g 400 ventrilo
getent passwd ventrilo >/dev/null || \
    useradd -r -u 400 -g ventrilo -d /usr/local/ventrilo -s /dev/null -c "Ventrilo Daemon" ventrilo
exit 0

%post


%changelog
* Thu Dec 27 2012 Wolf Noble
- initial creation