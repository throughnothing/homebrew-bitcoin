require 'formula'

class Libbitcoin < Formula
  homepage 'https://github.com/spesmilo/libbitcoin'
  url 'https://github.com/spesmilo/libbitcoin.git', :tag => 'v1.4'

  depends_on 'automake' => :build
  depends_on 'berkeley-db' => :optional
  depends_on 'homebrew/versions/gcc48' => :build
  depends_on 'openssl'
  depends_on 'protobuf' if build.include? 'with-berkeley-db'
  depends_on 'WyseNynja/bitcoin/boost-gcc48'
  depends_on 'WyseNynja/bitcoin/leveldb-gcc48' => :recommended

  def install
    ENV['CC']= "gcc-4.8"
    ENV['CXX'] = "g++-4.8"
    ENV['LD'] = "g++-4.8"
    ENV['CPPFLAGS'] = "-I/usr/local/opt/boost-gcc48/include -I/usr/local/opt/leveldb-gcc48/include -I/usr/local/opt/openssl/include"
    ENV['LDFLAGS'] = "-L/usr/local/opt/boost-gcc48/lib -L/usr/local/opt/leveldb-gcc48/lib -L/usr/local/opt/openssl/lib"

    # todo: is this the proper way to enable flags based on with-berkeley-db and with-leveldb
    system "autoreconf", "-i"
    # todo: the CC, CXX, and PKG_CONFIG_PATH stuff seem like they could be done better
    system "./configure", "#{(build.include? 'with-berkeley-db') ? "--enable-bdb" : ""}",
                          "#{(build.include? 'without-leveldb-gcc48') ? "" : "--enable-leveldb"}",
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
