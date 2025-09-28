[![](https://jitpack.io/v/SwifDroid/runtime-libs.svg)](https://jitpack.io/#SwifDroid/runtime-libs)

# Precompiled native libraries for Swift on Android

This repository packages Swift runtime `.so` files into AAR modules, published via [JitPack](https://jitpack.io/#swifdroid/runtime-libs)

## Modules

| Module                 | Artifact ID              | Description                                     |
|------------------------|--------------------------|-------------------------------------------------|
| Core                   | `core`                   | Core Swift runtime + libc++                     |
| Foundation             | `foundation`             | libFoundation, libdispatch, ICU                 |
| Foundation Essentials  | `foundationessentials`   | libFoundationEssentials                         |
| I18n                   | `i18n`                   | libFoundationInternationalization               |
| Networking             | `networking`             | libFoundationNetworking                         |
| Testing                | `testing`                | lib_Testing_Foundation, libXCTest, libTesting   |
| XML                    | `xml`                    | libFoundationXML                                |

## Usage

Add the JitPack repository to your project-level `settings.gradle`:

```kotlin
dependencyResolutionManagement {
    repositories {
        maven { url = uri("https://jitpack.io") }
        google()
        mavenCentral()
    }
}
```

Then add dependencies to the modules you need:

```kotlin
dependencies {
    implementation("com.github.SwifDroid.runtime-libs:core:6.2.0")
    implementation("com.github.SwifDroid.runtime-libs:foundation:6.2.0")
    implementation("com.github.SwifDroid.runtime-libs:foundationessentials:6.2.0")
    implementation("com.github.SwifDroid.runtime-libs:i18n:6.2.0")
    implementation("com.github.SwifDroid.runtime-libs:networking:6.2.0")
    implementation("com.github.SwifDroid.runtime-libs:testing:6.2.0")
    implementation("com.github.SwifDroid.runtime-libs:xml:6.2.0")
}
```

## Script: `copy-so-files.sh`

It is a helper script for collecting and organizing `.so` files from Swift Android SDK artifact bundle

### Features

- **Accepts the following input:**
    - Local path to a `.tar.gz` archive
    - URL to a remote `.tar.gz` archive
    - Path to an already-extracted `.artifactbundle` directory
- **Automatically extracts the archive** and locate inner folders
- **Copies `.so` files** into the correct submodule `jniLibs` folders
- Supports `--keep` to **preserve downloaded and extracted files**
- Supports `--dry` for **dry run mode** (shows what would be copied)

### Make the script executable

Before using the script, make it executable:

```bash
chmod +x ./copy-so-files.sh
```

### Example Usage

```bash
# Download and extract from URL, then copy .so files
./copy-so-files.sh https://github.com/swift-android-sdk/swift-android-sdk/releases/download/6.2/swift-6.2-RELEASE-android-0.1.artifactbundle.tar.gz

# Same as above, but keep the archive and extracted files
./copy-so-files.sh --keep https://github.com/...

# Dry run (shows what would be copied without copying)
./copy-so-files.sh --dry swift-6.2-RELEASE-android-0.1.artifactbundle.tar.gz

# Use an already-extracted artifact bundle directory
./copy-so-files.sh ./swift-6.2-RELEASE-android-0.1.artifactbundle
```

## Versioning

Each Git tag represents the corresponding Swift version the .so libraries were built for.

For example:
- 6.3.0 → Swift 6.3.0 (future official releases with 16KB page size)
- 6.2.0-16kb → Swift 6.2.0 (official with 16KB page size)
- 6.2.0 → Swift 6.2.0 (finagolfin's **without** 16KB page size)
- 6.1.3 → Swift 6.1.3
- 6.1.2 → Swift 6.1.2
- 6.1.0 → Swift 6.1.0