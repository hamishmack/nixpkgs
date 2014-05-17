{ cabal }:

cabal.mkDerivation (self: {
  pname = "primitive";
  version = "0.5.3.0";
  sha256 = "11wfdnhrgb7606d5sywqzlvnhzf45a9ywl9wghysvmr0mq2iypvn";
  meta = {
    homepage = "https://github.com/haskell/primitive";
    description = "Primitive memory-related operations";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
