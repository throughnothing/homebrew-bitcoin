require 'formula'

class Bitcoinarmory < Formula
  homepage 'http://bitcoinarmory.com/'
  head 'https://github.com/WyseNynja/BitcoinArmory/tarball/dev'
  depends_on 'cryptopp'
  depends_on 'swig'
  depends_on 'sip'
  depends_on 'qt'
  depends_on 'pyqt'
  depends_on 'twisted' => :python

  def install
    ENV.j1  # if your formula's build system can't parallelize

    system "make"
    system "make DESTDIR=`brew --prefix BitcoinArmory` install"
    bin.install 'ArmoryQt.command'
  end

  def test
    system "PYTHONPATH=`brew --prefix`/lib/python2.7/site-packages /usr/bin/python `brew --prefix bitcoinarmory`/share/armory/ArmoryQt.py -h"
  end

  def caveats; <<-EOS.undent
    BitcoinArmory.command was installed in
        #{bin}

    To symlink into ~/Applications, you can do:
        ln -s #{bin}/ArmoryQt.command ~/Applications/
    EOS
  end
end
