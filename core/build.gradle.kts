plugins {
    id("com.android.library")
    id("maven-publish")
}

android {
    namespace = "stream.swift.core"
    compileSdk = 35

    defaultConfig {
        minSdk = 21
        consumerProguardFiles("consumer-rules.pro")
    }

    packaging {
        jniLibs {
            keepDebugSymbols.add("*/arm64-v8a/libandroid-spawn.so")
            keepDebugSymbols.add("*/arm64-v8a/libdispatch.so")
            keepDebugSymbols.add("*/armeabi-v7a/libandroid-spawn.so")
            keepDebugSymbols.add("*/armeabi-v7a/libdispatch.so")
            keepDebugSymbols.add("*/x86_64/libandroid-spawn.so")
            keepDebugSymbols.add("*/x86_64/libdispatch.so")
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
        }
    }

    sourceSets["main"].jniLibs.srcDirs("src/main/jniLibs")

    publishing {
        singleVariant("release") {
            withSourcesJar()
        }
    }
}

publishing {
    publications {
        afterEvaluate {
            val releaseComponent = components.findByName("release")
            if (releaseComponent != null) {
                create<MavenPublication>("release") {
                    from(releaseComponent)

                    groupId = "com.github.swifdroid"
                    artifactId = "core"
                    version = "6.1.0"

                    pom {
                        name.set("Swift Core Runtime Libraries")
                        description.set("Core Runtime Libraries for Swift on Android")
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
}
