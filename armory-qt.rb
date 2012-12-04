require 'formula'

class ArmoryQt < Formula
  homepage 'http://bitcoinarmory.com/'
  head 'https://github.com/etotheipi/BitcoinArmory/archive/master.tar.gz'
  url 'https://github.com/etotheipi/BitcoinArmory/archive/v0.85-beta.tar.gz'
  sha1 '26354bdb5096ea4a9aeccbf1c80e103fb89c72a1'
  version 'v0.85-beta'

  depends_on 'cryptopp'
  depends_on 'swig'
  depends_on 'sip'
  depends_on 'qt'
  depends_on 'pyqt'
  depends_on 'twisted' => :python

  def patches
    DATA
  end

  def install
    ENV.j1  # if your formula's build system can't parallelize

    # my makefile patches weren't working
    system "make"
    system "mkdir -p #{prefix}/share/armory/img"
    system "cp *.py *.so README LICENSE #{prefix}/share/armory/"
    system "cp img/* #{prefix}/share/armory/img"
    bin.install 'ArmoryQt.command'
  end

  def caveats; <<-EOS.undent
    ArmoryQt.command was installed in
        #{bin}

    To symlink into ~/Applications, you can do:
        ln -s #{bin}/ArmoryQt.command ~/Applications/ArmoryQt

    Or you can just run 'ArmoryQt.command' from your terminal
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
