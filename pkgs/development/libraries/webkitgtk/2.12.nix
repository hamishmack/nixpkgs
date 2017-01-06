{ stdenv, fetchurl, perl, python2, ruby, bison, gperf, cmake
, pkgconfig, gettext, gobjectIntrospection, libnotify
, gtk2, gtk3, wayland, libwebp, enchant, xlibs, libxkbcommon, epoxy, at_spi2_core
, libxml2, libsoup, libsecret, libxslt, harfbuzz, libpthreadstubs
, enableGeoLocation ? !stdenv.isDarwin, geoclue2, sqlite
, gst-plugins-base, readline, libedit, libintlOrEmpty
}:

assert false;
assert enableGeoLocation -> geoclue2 != null;

with stdenv.lib;
stdenv.mkDerivation rec {
  name = "webkitgtk-${version}";
  version = "2.12.5";

  meta = {
    description = "Web content rendering engine, GTK+ port";
    homepage = "http://webkitgtk.org/";
    license = licenses.bsd2;
    platforms = platforms.linux;
    hydraPlatforms = [];
    maintainers = with maintainers; [ koral ];
  };

  preConfigure = "patchShebangs Tools";

  src = fetchurl {
    url = "http://webkitgtk.org/releases/${name}.tar.xz";
    sha256 = "0h0wig413399wws6l88mn1nnjbqb42vb55yvz8az39b4p1a7h53b";
  };

  patches = [ ./finding-harfbuzz-icu.patch ];

  cmakeFlags = [
    "-DPORT=GTK"
    "-DUSE_LIBHYPHEN=0"
  ] ++ optionals stdenv.isDarwin [
    "-DENABLE_GEOLOCATION=0"
    "-DENABLE_OPENGL=0"
  ];

  configureFlags = optionals stdenv.isDarwin [
    "--disable-x11-target"
    "--enable-quartz-target"
    "--disable-web-audio"
  ];

  # XXX: WebKit2 missing include path for gst-plugins-base.
  # Filled: https://bugs.webkit.org/show_bug.cgi?id=148894
  NIX_CFLAGS_COMPILE = "-I${gst-plugins-base.dev}/include/gstreamer-1.0";

  nativeBuildInputs = [
    cmake perl python2 ruby bison gperf sqlite
    pkgconfig gettext gobjectIntrospection
  ];

  buildInputs = [
    gtk2 libwebp enchant libnotify
    libxml2 libsecret libxslt harfbuzz libpthreadstubs
    gst-plugins-base libxkbcommon epoxy at_spi2_core
  ] ++ optional enableGeoLocation geoclue2
    ++ (with xlibs; [ libXdmcp libXt libXtst ])
    ++ (if stdenv.isDarwin then [
    readline libedit libintlOrEmpty
  ] else [
    wayland
  ]);

  propagatedBuildInputs = [
    libsoup gtk3
  ];

  enableParallelBuilding = true;
}
