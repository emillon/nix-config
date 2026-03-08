{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ffmpeg-concat
    pirate-get
    yt-dlp
    ytdl-nfo
  ];
}
