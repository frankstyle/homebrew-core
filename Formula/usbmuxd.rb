class Usbmuxd < Formula
  desc "USB multiplexor daemon for iPhone and iPod Touch devices"
  homepage "http://www.libimobiledevice.org"
  revision 1

  stable do
    url "http://www.libimobiledevice.org/downloads/libusbmuxd-1.0.10.tar.bz2"
    sha256 "1aa21391265d2284ac3ccb7cf278126d10d354878589905b35e8102104fec9f2"

    # Backport of upstream security fix for CVE-2016-5104.
    patch do
      url "https://github.com/libimobiledevice/libusbmuxd/commit/4397b3376dc4.patch"
      sha256 "9f3a84c8d0a32df13985f6574f5f0e86af435a67606612c0811df631070a97e3"
    end
  end

  bottle do
    cellar :any
    sha256 "e7227fb7deaefc2990e23d9cfdb3aa4305fc7f31e902560fa46272168c85e151" => :el_capitan
    sha256 "0aae53db481257e6ce5eed9be080b63b347f2e05d5dfecc55b0936a9ee5ab336" => :yosemite
    sha256 "e36b16d09c26e83daf359216a9b66fd2515a10d7432fdcc724c7aba5224f19b1" => :mavericks
  end

  head do
    url "http://git.sukimashita.com/libusbmuxd.git"

    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libusb"
  depends_on "libplist"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"iproxy"
  end
end
