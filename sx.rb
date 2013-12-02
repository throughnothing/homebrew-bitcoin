require 'formula'

class Sx < Formula
  homepage 'https://github.com/spesmilo/sx'
  url 'https://github.com/spesmilo/sx.git', :tag => 'v0.2'

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build

  depends_on 'qrencode' => :recommended
  depends_on 'WyseNynja/bitcoin/libbitcoin'
  depends_on 'WyseNynja/bitcoin/obelisk'

  def install
    # we depend on gcc48 for build, but the PATH is in the wrong order
    ENV['CC'] = "#{HOMEBREW_PREFIX}/opt/gcc48/bin/gcc-4.8"
    ENV['CXX'] = ENV['LD'] = "#{HOMEBREW_PREFIX}/opt/gcc48/bin/g++-4.8"

    # I thought depends_on libconfig-gcc48 would be enough, but I guess not...
    libconfiggcc48 = Formula.factory('WyseNynja/bitcoin/libconfig-gcc48')
    ENV.append 'CPPFLAGS', "-I#{libconfiggcc48.include}"
    ENV.append 'LDFLAGS', "-L#{libconfiggcc48.lib}"

    # I thought depends_on boost-gcc48 would be enough, but I guess not...
    boostgcc48 = Formula.factory('WyseNynja/bitcoin/boost-gcc48')
    ENV.append 'CPPFLAGS', "-I#{boostgcc48.include}"
    ENV.append 'LDFLAGS', "-L#{boostgcc48.lib}"

    # I thought depends_on leveldb-gcc48 would be enough, but I guess not...
    leveldbgcc48 = Formula.factory('WyseNynja/bitcoin/leveldb-gcc48')
    ENV.append 'CPPFLAGS', "-I#{leveldbgcc48.include}"
    ENV.append 'LDFLAGS', "-L#{leveldbgcc48.lib}"

    # I thought depends_on zermoq-gcc48 would be enough, but I guess not...
    zeromq2gcc48 = Formula.factory('WyseNynja/bitcoin/zeromq2-gcc48')
    ENV.append 'CPPFLAGS', "-I#{zeromq2gcc48.include}"
    ENV.append 'LDFLAGS', "-L#{zeromq2gcc48.lib} -lzmq"

    # I thought depends_on obelisk-gcc48 would be enough, but I guess not...
    obelisk = Formula.factory('WyseNynja/bitcoin/obelisk')
    ENV.append 'CPPFLAGS', "-I#{obelisk.include}"
    ENV.append 'LDFLAGS', "-L#{obelisk.lib}"

    ENV.append 'libbitcoin_LIBS', "-lbitcoin -lpthread -lleveldb -lcurl -lboost_thread-mt -lboost_regex -lboost_filesystem -lboost_system -lobelisk -lconfig++ -lzmq"

    # this is set in libbitcoin.pc.in
    ENV.cxx11

    # todo: very likely need to include some things here

    system "autoreconf", "-i"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "false"
  end
end
