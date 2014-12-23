# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, HDBC, mtl, odbc, time, utf8String }:

cabal.mkDerivation (self: {
  pname = "HDBC-odbc";
  version = "2.4.0.0";
  sha256 = "0zjq5j095jyh0axmgnr59fwhh1nhipj6flz77z46kygagygrg2qz";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [ HDBC mtl time utf8String ];
  extraLibraries = [ odbc ];
  noHaddock = true;
  meta = {
    homepage = "https://github.com/hdbc/hdbc-odbc";
    description = "ODBC driver for HDBC";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = with self.stdenv.lib.maintainers; [ ocharles ];
  };
})
