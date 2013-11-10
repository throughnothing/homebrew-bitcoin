require 'formula'

class Obelisk < Formula
  homepage 'https://github.com/spesmilo/obelisk'
  url 'https://github.com/spesmilo/obelisk.git', :tag => 'v0.2'

  depends_on 'automake' => :build
  depends_on 'homebrew/versions/gcc48' => :build
  depends_on 'libconfig' => :build
  depends_on 'WyseNynja/bitcoin/boost-gcc48'
  depends_on 'WyseNynja/bitcoin/libbitcoin'
  depends_on 'WyseNynja/bitcoin/leveldb-gcc48'
  depends_on 'WyseNynja/bitcoin/zeromq2'

  def install
    ENV['CC']= "gcc-4.8"
    ENV['CXX'] = "g++-4.8"
    ENV['LD'] = ENV['CXX']
    ENV['CPPFLAGS'] = "-I/usr/local/opt/boost-gcc48/include -I/usr/local/opt/leveldb-gcc48/include -I/usr/local/opt/libbitcoin/include -I/usr/local/opt/zeromq2/include"
    ENV['LDFLAGS'] = "-L/usr/local/opt/boost-gcc48/lib -L/usr/local/opt/leveldb-gcc48/lib -L/usr/local/opt/libbitcoin/lib -L/usr/local/opt/zeromq2/lib"

    system "autoreconf", "-i"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test obelisk`.
    system "false"
  end
end
