plugins {
    id("com.android.library")
    id("maven-publish")
}

android {
    namespace = "stream.swift.foundationessentials"
    compileSdk = 35

    defaultConfig {
        minSdk = 21
        consumerProguardFiles("consumer-rules.pro")
    }

    buildTypes {
        release {
            isMinifyEnabled = false
        }
    }

    sourceSets["main"].jniLibs.srcDirs("src/main/jniLibs")
}

publishing {
    publications {
        // Wrap in afterEvaluate only this one call if needed
        afterEvaluate {
            create<MavenPublication>("release") {
                // Use safe access to component
                val releaseComponent = components.findByName("release")
                if (releaseComponent != null) {
                    from(releaseComponent)
                }

                groupId = "com.github.swifdroid"
                artifactId = "foundationessentials"
                version = "6.1.0"

                pom {
                    name.set("Swift Foundation Essentials Runtime Libraries")
                    description.set("Foundation Essentials Runtime Libraries for Swift on Android")
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
