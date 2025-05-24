plugins {
    id("com.android.library")
    id("maven-publish")
}

android {
    namespace = "stream.swift.foundation"
    compileSdk = 35

    defaultConfig {
        minSdk = 21
        consumerProguardFiles("consumer-rules.pro")
    }

    packagingOptions {
        doNotStrip("*/arm64-v8a/libdispatch.so")
        doNotStrip("*/armeabi-v7a/libdispatch.so")
        doNotStrip("*/x86_64/libdispatch.so")
    }

    buildTypes {
        release {
            isMinifyEnabled = false
        }
    }

    // Ensure jniLibs are bundled in the AAR
    sourceSets["main"].jniLibs.srcDirs("src/main/jniLibs")
}

afterEvaluate {
    publishing {
        publications {
            create<MavenPublication>("release") {
                from(components["release"])

                groupId = "com.github.swifdroid"
                artifactId = "foundation"
                version = "6.1.0"

                pom {
                    name.set("Swift Foundation Runtime Libraries")
                    description.set("Foundation Runtime Libraries for Swift on Android")
                    url.set("https://github.com/swifdroid/runtime-libs")

                    licenses {
                        license {
                            name.set("MIT License")
                            url.set("http://www.opensource.org/licenses/mit-license.php")
                        }
                    }

                    developers {
                        developer {
                            id.set("imike")
                            name.set("Mikhail Isaev")
                            email.set("imike@swift.stream")
                        }
                    }

                    scm {
                        connection.set("scm:git:https://github.com/swifdroid/runtime-libs.git")
                        developerConnection.set("scm:git:ssh://git@github.com/swifdroid/runtime-libs.git")
                        url.set("https://github.com/swifdroid/runtime-libs")
                    }
                }
            }
        }
    }
}
