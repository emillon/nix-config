final: prev:
let
  inherit (prev) callPackage;
in
{
  ytdl-nfo = callPackage ./packages/ytdl-nfo.nix { };
  ffmpeg-concat = callPackage ./packages/ffmpeg-concat.nix { };
}
