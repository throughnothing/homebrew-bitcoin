require 'formula'

class Obelisk < Formula
  homepage 'https://github.com/spesmilo/obelisk'
  url 'https://github.com/spesmilo/obelisk.git', :tag => 'v0.2'

  depends_on 'automake' => :build
  depends_on 'homebrew/versions/gcc48' => :build
  depends_on 'WyseNynja/bitcoin/libconfig-gcc48' => :build  # todo: does this need gcc48?
  depends_on 'WyseNynja/bitcoin/boost-gcc48'
  depends_on 'WyseNynja/bitcoin/libbitcoin'
  depends_on 'WyseNynja/bitcoin/leveldb-gcc48'
  depends_on 'homebrew/versions/zeromq22'

  def install
    ENV['CC'] = ENV['LD'] = "#{HOMEBREW_PREFIX}/opt/gcc48/bin/gcc-4.8"
    ENV['CXX'] = "#{HOMEBREW_PREFIX}/opt/gcc48/bin/g++-4.8"

    system "autoreconf", "-i"
    system "./configure", "--prefix=#{prefix}"
    #system "make"
    system "make", "install"
  end

  test do
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test obelisk`.
    system "false"
  end
end
