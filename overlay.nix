{ ffmpeg-concat }:
final: prev:
let inherit (final.stdenv.hostPlatform) system; in
{
  ytdl-nfo = (import ./packages/ytdl-nfo.nix) { pkgs = prev; };
  ffmpeg-concat = ffmpeg-concat.outputs.packages."${system}".default;
}
