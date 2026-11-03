{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ffmpeg
    ffmpeg-concat
    magic-wormhole-rs
    mpv
    mkvtoolnix-cli
    pirate-get
    yt-dlp
    ytdl-nfo
  ];
}
