require 'formula'

class ArmoryQt < Formula
  homepage 'http://bitcoinarmory.com/'
  head 'https://github.com/etotheipi/BitcoinArmory.git'
  url 'https://github.com/etotheipi/BitcoinArmory.git', :tag => 'v0.86.3-beta'
  version '0.86.3-beta'

  depends_on 'cryptopp'
  depends_on 'swig' => :build
  depends_on 'sip'
  depends_on 'qt'
  depends_on 'pyqt'
  depends_on 'twisted' => :python

  def patches
    DATA
  end

  def install
    ENV.j1  # if your formula's build system can't parallelize
    system "make"
    system "mkdir -p #{share}/armory/"
    system "cp *.py *.so README LICENSE #{share}/armory/"
    bin.install 'ArmoryQt.command'
  end

  def caveats; <<-EOS.undent
    ArmoryQt.command was installed in
      #{bin}

    To symlink into ~/Applications, you can do:
      ln -s #{bin}/ArmoryQt.command ~/Applications/ArmoryQt

    Or you can just run 'ArmoryQt.command' from your terminal

    You will need bitcoin-qt or bitcoind running if you want to go online.
    EOS
  end
end

__END__
diff --git a/ArmoryQt.command b/ArmoryQt.command
new file mode 100644
index 0000000..2cc2154
--- /dev/null
+++ b/ArmoryQt.command
@@ -0,0 +1,3 @@
+#!/bin/sh
+PYTHONPATH=`brew --prefix`/lib/python2.7/site-packages /usr/bin/python `brew --prefix`/share/armory/ArmoryQt.py
+
