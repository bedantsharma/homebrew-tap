class BridgeScreen < Formula
  desc "Keeps track of where your Claude Code agents are: progress, tangents, and handoffs."
  homepage "https://github.com/bedantsharma/session-plugin"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bedantsharma/session-plugin/releases/download/v0.2.1/bridge-screen-aarch64-apple-darwin.tar.xz"
      sha256 "0a4805ee058b5024611bee6dbf3a46dc4441a9d03b89598996379bf63bcaaab5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bedantsharma/session-plugin/releases/download/v0.2.1/bridge-screen-x86_64-apple-darwin.tar.xz"
      sha256 "f2180ef0268f10260080d113e12d5ce67156b814e036cb0218ff09dddd795d4e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bedantsharma/session-plugin/releases/download/v0.2.1/bridge-screen-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "010bc2585552c00110787e4fd57bb5d352130b25f73ff47198d0105e736ca07e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bedantsharma/session-plugin/releases/download/v0.2.1/bridge-screen-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "89fd9c73beb7736c9e6f1d252d965ab9baa98e9c7ebb77af6e5cf016a2f0f375"
    end
  end
  license "PolyForm-Strict-1.0.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "bridge-screen"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "bridge-screen"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "bridge-screen"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "bridge-screen"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
