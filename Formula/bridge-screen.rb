class BridgeScreen < Formula
  desc "Keeps track of where your Claude Code agents are: progress, tangents, and handoffs."
  homepage "https://github.com/bedantsharma/session-plugin"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bedantsharma/session-plugin/releases/download/v0.1.0/bridge-screen-aarch64-apple-darwin.tar.xz"
      sha256 "6df217bbc22d364580119ef688d38f656b6ade191f53f5178da80b7161911a21"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bedantsharma/session-plugin/releases/download/v0.1.0/bridge-screen-x86_64-apple-darwin.tar.xz"
      sha256 "b341391188b6f5639a2348547856ecc761075d6065f3e0a7d90a4f5fb46a942a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bedantsharma/session-plugin/releases/download/v0.1.0/bridge-screen-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "93aa04dc9d88884462e6edc760b8e82d8f438e06193dc19d691b4dabe93b8745"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bedantsharma/session-plugin/releases/download/v0.1.0/bridge-screen-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a69ddf161981435bee41a7a64ca466672d7a5bb8877e634d891c63efa4199f9c"
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
