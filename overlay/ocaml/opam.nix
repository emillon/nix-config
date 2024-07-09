{ pkgs }:
let
  fetchurl = pkgs.fetchurl;
  version = "2.2.0";
  opam_src = pkgs.fetchFromGitHub ({
    owner = "ocaml";
    repo = "opam";
    rev = version;
    hash = "sha256-ogBSommjV3qM/11CmJSKOpiM7kWTUVtYdzgJ3MqdPLk=";
  });
  srcs = {
    "0install-solver" = fetchurl {
      url =
        "https://github.com/0install/0install/releases/download/v2.17/0install-v2.17.tbz";
      sha256 = "08q95mzmf9pyyqs68ff52422f834hi313cxmypwrxmxsabcfa10p";
    };
    "base64" = fetchurl {
      url =
        "https://github.com/mirage/ocaml-base64/releases/download/v3.5.0/base64-v3.5.0.tbz";
      sha256 = "19735bvb3k263hzcvdhn4d5lfv2qscc9ib4q85wgxsvq0p0fk7aq";
    };
    "cmdliner" = fetchurl {
      url = "http://erratique.ch/software/cmdliner/releases/cmdliner-1.3.0.tbz";
      sha256 = "sha256-joGA9XO0QPanqMII2rLK5KgjhP7HMtInhNG7bmQWjLs=";
    };
    "cppo" = fetchurl {
      url = "https://github.com/ocaml-community/cppo/archive/v1.6.8.tar.gz";
      sha256 = "0lxy4xkkkwgs1cj6d9lyzsqi9f6fc9r6cir5imi7yjqrpd86s1by";
    };
    "cudf" = fetchurl {
      url = "https://gitlab.com/irill/cudf/-/archive/v0.10/cudf-v0.10.tar.gz";
      sha256 = "0l7vzvlrk4x4vw1lkd1wzarxz3h82r3835singcay8m8zj8777bv";
    };
    "dose3" = fetchurl {
      url = "https://gitlab.com/irill/dose3/-/archive/7.0.0/dose3-7.0.0.tar.gz";
      sha256 = "0ab0llqdmy82ljh8xdf57y00c9jvf1vnxiq9hczli0r6vc263nq2";
    };
    "dune-local" = fetchurl {
      url =
        "https://github.com/ocaml/dune/releases/download/3.15.3/dune-3.15.3.tbz";
      sha256 = "PCfHZ2QUBW8DaKcf3GcNKwpZiYCQx4obaCMJhOW+txM=";
    };
    "extlib" = fetchurl {
      url =
        "https://github.com/ygrek/ocaml-extlib/releases/download/1.7.9/extlib-1.7.9.tar.gz";
      sha256 = "1jydzw2n84cfiz9y6lk4gih4wbr8jybanmiryfs01svd07g4vpjq";
    };
    "mccs" = fetchurl {
      url = "https://github.com/AltGr/ocaml-mccs/archive/1.1+13.tar.gz";
      sha256 = "05nnji9h8mss3hzjr5faid2v3xfr7rcv2ywmpcxxp28y6h2kv9gv";
    };
    "ocamlgraph" = fetchurl {
      url =
        "https://github.com/backtracking/ocamlgraph/releases/download/2.0.0/ocamlgraph-2.0.0.tbz";
      sha256 = "029692bvdz3hxpva9a2jg5w5381fkcw55ysdi8424lyyjxvjdzi0";
    };
    "opam-0install-cudf" = fetchurl {
      url =
        "https://github.com/ocaml-opam/opam-0install-solver/releases/download/v0.4.2/opam-0install-cudf-v0.4.2.tbz";
      sha256 = "10wma4hh9l8hk49rl8nql6ixsvlz3163gcxspay5fwrpbg51fmxr";
    };
    "opam-file-format" = fetchurl {
      url = "https://github.com/ocaml/opam-file-format/archive/2.1.4.tar.gz";
      sha256 = "0xbdlpxb0348pbwijna2x6nbi8fcxdh63cwrznn4q4zzbv9zsy02";
    };
    "re" = fetchurl {
      url =
        "https://github.com/ocaml/ocaml-re/releases/download/1.10.3/re-1.10.3.tbz";
      sha256 = "1fqfg609996bgxr14yyfxhvl6hm9c1j0mm2xjdjigqrzgyb4crc4";
    };
    "result" = fetchurl {
      url =
        "https://github.com/janestreet/result/releases/download/1.5/result-1.5.tbz";
      sha256 = "0cpfp35fdwnv3p30a06wd0py3805qxmq3jmcynjc3x2qhlimwfkw";
    };
    "seq" = fetchurl {
      url = "https://github.com/c-cube/seq/archive/0.2.2.tar.gz";
      sha256 = "1ck15v3pg8bacdg6d6iyp2jc3kgrzxk5jsgzx3287x2ycb897j53";
    };
    "stdlib-shims" = fetchurl {
      url =
        "https://github.com/ocaml/stdlib-shims/releases/download/0.3.0/stdlib-shims-0.3.0.tbz";
      sha256 = "0jnqsv6pqp5b5g7lcjwgd75zqqvcwcl5a32zi03zg1kvj79p5gxs";
    };
    opam = fetchurl {
      url = "https://github.com/ocaml/opam/archive/2.1.5.zip";
      sha256 = "0s8r5gfs2zsyfn3jzqnvns3g0rkik3pw628n0dik55fwq3zjgg4a";
    };
  };
  usingConfigure = pkgs.opam.overrideAttrs (old: {
    inherit version;
    src = pkgs.fetchurl {
      url =
        "https://github.com/ocaml/opam/releases/download/2.2.0/opam-full-2.2.0.tar.gz";
      hash = "sha256-OTNPNq2+KAaDSHzyBLewZCCA/FlldH99b3zHuDzXoZI=";
    };
    patches = [ ];

    postUnpack = ''
      ln -sv ${srcs."0install-solver"} $sourceRoot/src_ext/0install-solver.tbz
      ln -sv ${srcs."base64"} $sourceRoot/src_ext/base64.tbz
      ln -sv ${srcs."cmdliner"} $sourceRoot/src_ext/cmdliner.tbz
      ln -sv ${srcs."cppo"} $sourceRoot/src_ext/cppo.tar.gz
      ln -sv ${srcs."cudf"} $sourceRoot/src_ext/cudf.tar.gz
      ln -sv ${srcs."dose3"} $sourceRoot/src_ext/dose3.tar.gz
      ln -sv ${srcs."dune-local"} $sourceRoot/src_ext/dune-local.tbz
      ln -sv ${srcs."extlib"} $sourceRoot/src_ext/extlib.tar.gz
      ln -sv ${srcs."mccs"} $sourceRoot/src_ext/mccs.tar.gz
      ln -sv ${srcs."ocamlgraph"} $sourceRoot/src_ext/ocamlgraph.tbz
      ln -sv ${
        srcs."opam-0install-cudf"
      } $sourceRoot/src_ext/opam-0install-cudf.tbz
      ln -sv ${
        srcs."opam-file-format"
      } $sourceRoot/src_ext/opam-file-format.tar.gz
      ln -sv ${srcs."re"} $sourceRoot/src_ext/re.tbz
      ln -sv ${srcs."result"} $sourceRoot/src_ext/result.tbz
      ln -sv ${srcs."seq"} $sourceRoot/src_ext/seq.tar.gz
      ln -sv ${srcs."stdlib-shims"} $sourceRoot/src_ext/stdlib-shims.tbz
    '';
    configureFlags = [ "--with-vendored-deps" ];
    postConfigure =
      if pkgs.stdenv.isDarwin then
        "echo '( -noautolink -cclib -lunix -cclib -lmccs_stubs -cclib -lmccs_glpk_stubs -cclib -lsha_stubs -cclib -lc++ -ccopt -lc++abi )' > src/client/linking.sexp"
      else
        [ ];
  });
  swhid_core = pkgs.ocamlPackages.buildDunePackage {
    pname = "swhid_core";
    version = "0.1";
    src = pkgs.fetchFromGitHub {
      owner = "ocamlpro";
      repo = "swhid_core";
      rev = "0.1";
      hash = "sha256-uLnVbptCvmBeNbOjGjyAWAKgzkKLDTYVFY6SNH2zf0A=";
    };
  };
  zeroinstall-solver = pkgs.ocamlPackages.buildDunePackage {
    pname = "0install-solver";
    version = "2.18";
    src = fetchurl {
      url = "https://github.com/0install/0install/releases/download/v2.18/0install-2.18.tbz";
      hash = "sha256-ZIxLMYwaJt/LRAZcImq4ynI3lZJK2Ao785rhzg6ZIMM=";
    };
  };
  opam-0install-cudf = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam-0install-cudf";
    version = "0.4.3";
    src = fetchurl {
      url = "https://github.com/ocaml-opam/opam-0install-solver/releases/download/v0.4.3/opam-0install-cudf-0.4.3.tbz";
      hash = "sha256-1Z4Ovd2lj3mP9Q6+ITyDiTtafDQMOMIJUFdNZ+YUW4o=";
    };
    propagatedBuildInputs = [ zeroinstall-solver pkgs.ocamlPackages.cudf ];
  };
  spdx_licenses = pkgs.ocamlPackages.buildDunePackage {
    pname = "spdx_licenses";
    version = "1.2.0";
    src = fetchurl {
      url = "https://github.com/kit-ty-kate/spdx_licenses/releases/download/v1.2.0/spdx_licenses-1.2.0.tar.gz";
      hash = "sha256-9ViB7PRDz70w3RJczapgn2tJx9wTWgAbdzos6r3J2r4=";
    };
  };
  opam_solver = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam-solver";
    dontConfigure = true;
    inherit version;
    src = opam_src;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ opam-0install-cudf re dose3 opam_format ];
  };
  opam_core = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam-core";
    dontConfigure = true;
    inherit version;
    src = opam_src;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ uutf swhid_core jsonm sha ocamlgraph re ];
  };
  opam_format = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam-format";
    dontConfigure = true;
    inherit version;
    src = opam_src;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ re opam-file-format opam_core ];
  };
  opam_repository = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam-repository";
    dontConfigure = true;
    inherit version;
    src = opam_src;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ opam_format ];
  };
  opam_state = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam-state";
    dontConfigure = true;
    inherit version;
    src = opam_src;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ spdx_licenses re opam_repository ];
  };
  opam_client = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam-client";
    dontConfigure = true;
    inherit version;
    src = opam_src;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ cmdliner base64 re opam_repository opam_solver opam_state ];
  };
  opam = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam";
    dontConfigure = true;
    inherit version;
    src = opam_src;
    buildInputs = with pkgs.ocamlPackages; [ opam_client ];
  };
in
{
  inherit usingConfigure;
  usingDune = opam;
}
