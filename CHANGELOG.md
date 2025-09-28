# Changelog

All notable changes to this project will be documented in this file.

## [6.2.0-16kb] - 2025-09-28
### Changed
- Updated all `.so` files to Swift 6.2.0 from the official SDK with 16KB page size support
- Updated `copy-so-files.sh` helper script to align with the official SDK structure
### Removed
- Removed `compression` module with `libz.so` and `liblzma.so`
- Removed `libandroid-execinfo.so`, `libandroid-spawn.so`, and `libcharset.so` from `core` module
- Removed `libiconv.so` from `foundation` module
- Removed `libcrypto.so`, `libcurl.so`, `libnghttp2.so`, `libnghttp3.so`, `libssh2.so`, `libssl.so` from `networking` module
- Removed `libxml2.so` from `xml` module
_These libraries are not part of the official Swift Android SDK distribution and can be added separately if needed._

## [6.2.0] - 2025-09-18
### Added
- Added `lib_Testing_Foundation.so` into `testing` module
### Changed
- Updated all `.so` files to Swift 6.2.0
- Updated `copy-so-files.sh` helper script

## [6.1.3] - 2025-09-11
### Changed
- Updated all `.so` files to Swift 6.1.3
- Fixed `copy-so-files.sh` helper script

## [6.1.2] - 2025-06-04
### Added
- Added `copy-so-files.sh` helper script:
  - Supports extracting `.so` files from local archives, URLs, or extracted `.artifactbundle` folders
  - Automatically detects sysroot and organizes outputs into submodule `jniLibs`
  - Includes `--keep` flag to retain downloaded/extracted files
  - Includes `--dry` flag for dry-run mode (shows actions without copying)
### Changed
- Updated all `.so` files to Swift 6.1.2

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
