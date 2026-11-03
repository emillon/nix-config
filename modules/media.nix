{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ffmpeg
    ffmpeg-concat
    mpv
    mkvtoolnix-cli
    pirate-get
    yt-dlp
    ytdl-nfo
  ];
}
