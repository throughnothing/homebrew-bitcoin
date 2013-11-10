require 'formula'

class LibbitcoinExamples < Formula
  homepage 'https://github.com/spesmilo/libbitcoin'
  url 'https://github.com/spesmilo/libbitcoin.git', :tag => 'v1.4'

  depends_on 'WyseNynja/bitcoin/boost-gcc48'
  depends_on 'WyseNynja/bitcoin/libbitcoin'
  depends_on 'watch'

  def patches
    # lboost_thread is named differently on osx
    DATA
  end

  def install
    ENV['CC']= "gcc-4.8"
    ENV['CXX'] = "g++-4.8"
    ENV['LD'] = ENV['CXX']
    ENV['CPPFLAGS'] = "-I/usr/local/opt/libbitcoin/include -I/usr/local/opt/boost-gcc48/include -I/usr/local/opt/leveldb-gcc48/include"
    ENV['LDFLAGS'] = "-L/usr/local/opt/libbitcoin/lib -L/usr/local/opt/boost-gcc48/lib -L/usr/local/opt/leveldb-gcc48/lib"

    cd "examples" do
      system "make"

      for script in [
        "accept",
        "balance",
        "blocks.sh",
        "connect",
        "determ",
        "display-last",
        "fullnode",
        "initchain",
        "priv",
        "proto",
        "satoshiwords",
        "txrad",
      ] do
        system "mv", script, "bitcoin-"+script
        bin.install "bitcoin-"+script
      end
    end
  end

  test do
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test libbitcoin`.
    system "false"
  end
end
__END__
diff --git a/examples/Makefile b/examples/Makefile
index aa7fa9d..b2a6f68 100644
--- a/examples/Makefile
+++ b/examples/Makefile
@@ -1,5 +1,5 @@
-CXXFLAGS=$(shell pkg-config --cflags libbitcoin) -ggdb
-LIBS=$(shell pkg-config --libs libbitcoin)
+CXXFLAGS=$(shell pkg-config --cflags libbitcoin) -ggdb -I/usr/local/opt/boost-gcc48/include -I/usr/local/opt/curl/include -I/usr/local/opt/leveldb-gcc48/include
+LIBS=$(shell pkg-config --libs libbitcoin) -L/usr/local/opt/boost-gcc48/lib -L/usr/local/opt/curl/lib -L/usr/local/opt/leveldb-gcc48/lib

 default: all
 
