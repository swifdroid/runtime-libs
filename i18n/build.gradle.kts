plugins {
    id("com.android.library")
    id("maven-publish")
}

android {
    namespace = "stream.swift.i18n"
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

afterEvaluate {
    publishing {
        publications {
            create<MavenPublication>("release") {
                from(components["release"])

                groupId = "com.github.swifdroid"
                artifactId = "i18n"
                version = "6.1.0"

                pom {
                    name.set("Swift i18n Runtime Libraries")
                    description.set("i18n Runtime Libraries for Swift on Android")
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
