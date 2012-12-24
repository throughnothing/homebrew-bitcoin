require 'formula'

class Bitcoind < Formula
  homepage 'http://bitcoin.org/'
  head 'https://github.com/bitcoin/bitcoin.git'
  url 'https://github.com/bitcoin/bitcoin.git', :tag => 'v0.7.2'
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
    You will need to setup your bitcoin.conf if you haven't already done so:

    echo "rpcuser=user" >> "~/Library/Application Support/Bitcoin/bitcoin.conf"
    echo "rpcpassword=password" >> "~/Library/Application Support/Bitcoin/bitcoin.conf"
    EOS
  end
end
