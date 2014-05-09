{ cabal, conduit, conduitExtra, hspec, HUnit, resourcet
, systemFilepath, tagstreamConduit, text, transformers, xmlConduit
, xmlTypes
}:

cabal.mkDerivation (self: {
  pname = "html-conduit";
  version = "1.1.0.5";
  sha256 = "1yxvaiklg90fsiv2sfzrr3hp1wjs0fhcg709b24lqm81aryaq2sn";
  buildDepends = [
    conduit conduitExtra resourcet systemFilepath tagstreamConduit text
    transformers xmlConduit xmlTypes
  ];
  testDepends = [ hspec HUnit xmlConduit ];
  meta = {
    homepage = "https://github.com/snoyberg/xml";
    description = "Parse HTML documents using xml-conduit datatypes";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})
