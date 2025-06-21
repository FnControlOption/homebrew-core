class Optivorbis < Formula
  desc "Lossless, format-preserving, two-pass optimization and repair of Vorbis data"
  homepage "https://optivorbis.github.io/OptiVorbis"
  url "https://github.com/OptiVorbis/OptiVorbis/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "f1069b35fa24c9b73abb9a28859b84ad0accf968b8892b7a7825decc6c316cd3"
  license "AGPL-3.0-or-later"
  head "https://github.com/OptiVorbis/OptiVorbis.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "packages/optivorbis_cli")
    pkgshare.install "packages/optivorbis/resources/test"
  end

  test do
    cp pkgshare/"test/44100hz_500ms_6ch_sine_waves.ogg", testpath
    system bin/"optivorbis", "44100hz_500ms_6ch_sine_waves.ogg", "out.ogg"
    assert_path_exists testpath/"out.ogg"
  end
end
