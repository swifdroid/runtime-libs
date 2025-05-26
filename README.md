[![](https://jitpack.io/v/SwifDroid/runtime-libs.svg)](https://jitpack.io/#SwifDroid/runtime-libs)

# Precompiled native libraries for Swift on Android

This repository packages Swift runtime `.so` files into AAR modules, published via [JitPack](https://jitpack.io/#swifdroid/runtime-libs)

## Modules

| Module                  | Artifact ID              | Description                                |
|------------------------|--------------------------|--------------------------------------------|
| Compression            | `compression`            | liblzma, libz                              |
| Core                   | `core`                   | Core Swift runtime + libcharset, libc++    |
| Foundation             | `foundation`             | libFoundation, libdispatch, ICU            |
| Foundation Essentials  | `foundationessentials`   | libFoundationEssentials                    |
| I18n                   | `i18n`                   | libFoundationInternationalization          |
| Networking             | `networking`             | libFoundationNetworking, libcurl, libssl   |
| Testing                | `testing`                | libXCTest, libTesting                      |
| XML                    | `xml`                    | libFoundationXML, libxml2                  |

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
    implementation("com.github.SwifDroid.runtime-libs:core:6.1.0")
    implementation("com.github.SwifDroid.runtime-libs:foundation:6.1.0")
    implementation("com.github.SwifDroid.runtime-libs:networking:6.1.0")
    // Add more as needed...
}
```

## Versioning

Each Git tag represents the corresponding Swift version the .so libraries were built for.

For example:
- 6.1.0 → Swift 6.1.0
- 6.2.0 → Swift 6.2.0 (future)