{ pkgs, ... }:
{ home.packages = with pkgs; [ pirate-get yt-dlp ytdl-nfo ]; }
