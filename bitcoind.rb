require 'formula'

class Bitcoind < Formula
  homepage 'http://bitcoin.org/'
  head 'https://github.com/bitcoin/bitcoin/archive/master.tar.gz'
  url 'https://github.com/bitcoin/bitcoin/archive/v0.7.2.tar.gz'
  sha1 '6afb648f273a52934a65d8a127a08dccdb74db48'
  version '0.7.2'

  depends_on 'boost'
  depends_on 'berkeley-db4'
  depends_on 'miniupnpc' if build.include? 'with-upnp'

  option 'with-upnp', 'Compile with UPnP support'
  option 'without-ipv6', 'Compile without IPv6 support'

  def install
    cd "src" do
        system "make", "-f", "makefile.osx",
                       "DEPSDIR=#{HOMEBREW_PREFIX}",
                       "USE_UPNP=#{(build.include? 'with-upnp') ? '1' : '-'}",
                       "USE_IPV6=#{(build.include? 'without-ipv6') ? '-' : '1'}"
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
