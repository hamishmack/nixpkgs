{ stdenv, lib, fetchurl, fetchpatch, SDL, boost, cmake, ffmpeg, gettext, glew
, ilmbase, libXi, libjpeg, libpng, libsamplerate, libsndfile
, libtiff, mesa, openal, opencolorio, openexr, openimageio, openjpeg, python
, zlib, fftw
, jackaudioSupport ? false, jack2
, cudaSupport ? false, cudatoolkit65
, colladaSupport ? true, opencollada
}:

with lib;

stdenv.mkDerivation rec {
  name = "blender-2.73a";

  src = fetchurl {
    url = "http://download.blender.org/source/${name}.tar.gz";
    sha256 = "114ipidrja6ryi6wv0w55wmh10ikazy24r8js596g7b9fpkzpymc";
  };

  patches = [ ./sm52.patch ];

  buildInputs =
    [ SDL boost cmake ffmpeg gettext glew ilmbase libXi
      libjpeg libpng libsamplerate libsndfile libtiff mesa openal
      opencolorio openexr openimageio /* openjpeg */ python zlib fftw
    ]
    ++ optional jackaudioSupport jack2
    ++ optional cudaSupport cudatoolkit65
    ++ optional colladaSupport opencollada;

  postUnpack =
    ''
      substituteInPlace */doc/manpage/blender.1.py --replace /usr/bin/python ${python}/bin/python3
    '';

  cmakeFlags =
    [ "-DWITH_MOD_OCEANSIM=ON"
      "-DWITH_CODEC_FFMPEG=ON"
      "-DWITH_CODEC_SNDFILE=ON"
      "-DWITH_INSTALL_PORTABLE=OFF"
      "-DWITH_FFTW3=ON"
      "-DWITH_SDL=ON"
      "-DWITH_GAMEENGINE=ON"
      "-DWITH_OPENCOLORIO=ON"
      "-DWITH_PLAYER=ON"
      "-DPYTHON_LIBRARY=python${python.majorVersion}m"
      "-DPYTHON_LIBPATH=${python}/lib"
      "-DPYTHON_INCLUDE_DIR=${python}/include/python${python.majorVersion}m"
      "-DPYTHON_VERSION=${python.majorVersion}"
    ]
    ++ optional jackaudioSupport "-DWITH_JACK=ON"
    ++ optional cudaSupport "-DWITH_CYCLES_CUDA_BINARIES=ON"
    ++ optional colladaSupport "-DWITH_OPENCOLLADA=ON";

  NIX_CFLAGS_COMPILE = "-I${ilmbase}/include/OpenEXR -I${python}/include/${python.libPrefix}m";

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "3D Creation/Animation/Publishing System";
    homepage = http://www.blender.org;
    # They comment two licenses: GPLv2 and Blender License, but they
    # say: "We've decided to cancel the BL offering for an indefinite period."
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = [ maintainers.goibhniu ];
  };
}
