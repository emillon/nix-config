final: prev:
{
  ytdl-nfo = (import ./packages/ytdl-nfo.nix) { pkgs = prev; };
  ffmpeg-concat = prev.callPackage ./packages/ffmpeg-concat.nix { };
}
