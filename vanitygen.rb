require 'formula'

class Vanitygen < Formula
  homepage 'http://github.com/WyseNynja/vanitygen'
  head 'https://github.com/WyseNynja/vanitygen.git'
  url 'https://github.com/WyseNynja/vanitygen.git', :tag => '0.23-red'

  depends_on 'openssl'
  depends_on 'pcre'

  def install
    system "make", "all"
    %w[keyconv oclvanitygen oclvanityminer vanitygen].each do |binary|
      system "strip", "#{binary}"
      bin.install binary
    end
  end
end
