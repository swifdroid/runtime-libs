# Changelog

All notable changes to this project will be documented in this file.

## [6.1.2] - 2025-06-04
### Added
- Updated all `.so` files to Swift 6.1.2
- Added `copy-so-files.sh` helper script:
  - Supports extracting `.so` files from local archives, URLs, or extracted `.artifactbundle` folders
  - Automatically detects sysroot and organizes outputs into submodule `jniLibs`
  - Includes `--keep` flag to retain downloaded/extracted files
  - Includes `--dry` flag for dry-run mode (shows actions without copying)

## [6.1.0] - 2025-05-26
### Added
- Initial release of runtime-libs for Swift 6.1.0 targeting Android.
- Includes precompiled `.so` libraries packaged as AARs for the following modules:
    - `compression`
    - `core`
    - `foundation`
    - `foundationessentials`
    - `i18n`
    - `networking`
    - `testing`
    - `xml`
- Supports architectures: `armeabi-v7a`, `arm64-v8a`, `x86_64`
- Compatible with `minSdk 21` and `compileSdk 35`
