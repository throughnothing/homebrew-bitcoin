require 'formula'

class Bitcoind < Formula
  homepage 'http://bitcoin.org/'
  head 'https://github.com/bitcoin/bitcoin/zipball/master'
  url 'https://github.com/bitcoin/bitcoin/tarball/0.6.3'
  sha1 '334f06876b126b12a1b4fa1c8b00b5d8a89da284'
  version '0.6.3'
  depends_on 'boost'
  depends_on 'berkeley-db4'

  def install
    cd "src" do
        system "make -f makefile.osx USE_UPNP= DEPSDIR=#{HOMEBREW_PREFIX}"
        system "strip bitcoind"
        bin.install "bitcoind"
    end
  end

  def caveats; <<-EOS.undent
    You will need to setup your bitcoin.conf:
        echo "rpcuser=user" >> ~/Library/Application Support/Bitcoin/bitcoin.conf
        echo "rpcpassword=password" >> ~/Library/Application Support/Bitcoin/bitcoin.conf
    EOS
  end
end


__END__
diff --git a/src/makefile.osx b/src/makefile.osx
index 11c6248..112d9f7 100644
--- a/src/makefile.osx
+++ b/src/makefile.osx
@@ -7,7 +7,7 @@
 # Originally by Laszlo Hanyecz (solar@heliacal.net)

 CXX=llvm-g++
-DEPSDIR=/opt/local
+DEPSDIR?=/opt/local

 INCLUDEPATHS= \
  -I"$(CURDIR)" \
