require 'formula'

class Libbitcoin < Formula
  homepage 'https://github.com/spesmilo/libbitcoin'
  url 'https://github.com/spesmilo/libbitcoin.git', :tag => 'v1.4'
  head 'https://github.com/spesmilo/libbitcoin.git', :branch => 'master'

  depends_on 'automake' => :build
  depends_on 'curl'
  depends_on 'homebrew/versions/gcc48' => :build
  depends_on 'openssl'
  depends_on 'WyseNynja/bitcoin/boost-gcc48'
  depends_on 'WyseNynja/bitcoin/leveldb-gcc48'

  def patches
    # lboost_thread is named differently on osx
    DATA
  end

  def install
    ENV['CC']= "gcc-4.8"
    ENV['CXX'] = "g++-4.8"
    ENV['LD'] = ENV['CXX']

    system "autoreconf", "-i"
    system "./configure", "--enable-leveldb",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test libbitcoin`.
    system "false"
  end
end
__END__
diff --git a/libbitcoin.pc.in b/libbitcoin.pc.in
index 81880f3..aa6d18e 100644
--- a/libbitcoin.pc.in
+++ b/libbitcoin.pc.in
@@ -9,6 +9,6 @@ URL: http://libbitcoin.dyne.org
 Version: @PACKAGE_VERSION@
 Requires: libcurl
 Cflags: -I${includedir} -std=c++11 @CFLAG_LEVELDB@
-Libs: -L${libdir} -lbitcoin -lboost_thread -lboost_system -lboost_regex -lboost_filesystem -lpthread -lcurl @LDFLAG_LEVELDB@
+Libs: -L${libdir} -lbitcoin -lboost_thread-mt -lboost_system -lboost_regex -lboost_filesystem -lpthread -lcurl @LDFLAG_LEVELDB@
 Libs.private: -lcrypto -ldl -lz
 
