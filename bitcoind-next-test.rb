require 'formula'

class BitcoindNextTest < Formula
  homepage 'http://bitcoin.org/'
  head 'https://github.com/luke-jr/bitcoin/tarball/next-test'
  version 'next-test'
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
        system "mv bitcoind bitcoind-next-test"
        bin.install "bitcoind-next-test"
    end
  end

  def caveats; <<-EOS.undent
    You will need to setup your bitcoin.conf:
        echo "rpcuser=user" >> "~/Library/Application Support/Bitcoin/bitcoin.conf"
        echo "rpcpassword=password" >> "~/Library/Application Support/Bitcoin/bitcoin.conf"
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
