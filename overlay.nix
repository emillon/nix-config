{ ffmpeg-concat }:
final: prev:
let system = final.system; in
{
  ytdl-nfo = (import ./packages/ytdl-nfo.nix) { pkgs = prev; };
  ffmpeg-concat = ffmpeg-concat.outputs.packages."${system}".default;
}
