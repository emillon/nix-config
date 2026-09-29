{ fetchFromGitHub, writeShellApplication }:

let
  src = fetchFromGitHub {
    owner = "emillon";
    repo = "ffmpeg-concat";
    rev = "2bcc3cb5d53d841655f0e1bc169e2c36b76e9ff9";
    hash = "sha256-RvCn8S40hvU9QDxsvYEPU6eckcLUJNt3pgVeC3Hx+RY=";
  };
in
writeShellApplication {
  name = "ffmpeg-concat";
  text = ''
    python3 ${src}/ffmpeg-concat "$@"
  '';
}
