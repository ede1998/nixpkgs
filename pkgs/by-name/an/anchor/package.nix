{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "anchor";
  version = "0.30.1";

  src = fetchFromGitHub {
    owner = "coral-xyz";
    repo = "anchor";
    rev = "v${version}";
    hash = "sha256-NL8ySfvnCGKu1PTU4PJKTQt+Vsbcj+F1YYDzu0mSUoY=";
    fetchSubmodules = true;
  };

  cargoPatches = [ ./0001-update-time-rs.patch ];

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "serum_dex-0.4.0" = "sha256-Nzhh3OcAFE2LcbUgrA4zE2TnUMfV0dD4iH6fTi48GcI=";
    };
  };

  checkFlags = [
    # the following test cases try to access network, skip them
    "--skip=tests::test_check_and_get_full_commit_when_full_commit"
    "--skip=tests::test_check_and_get_full_commit_when_partial_commit"
    "--skip=tests::test_get_anchor_version_from_commit"
  ];

  meta = with lib; {
    description = "Solana Sealevel Framework";
    homepage = "https://github.com/coral-xyz/anchor";
    changelog = "https://github.com/coral-xyz/anchor/blob/${src.rev}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = [ ];
    mainProgram = "anchor";
  };
}
