import java.util.Properties
import java.io.FileInputStream


plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.ismail_hosen_james.al_bayan_quran"
    compileSdk = 37
    ndkVersion = "29.0.14206865"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.ismail_hosen_james.al_bayan_quran"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    packaging {
        jniLibs {
            useLegacyPackaging = true
        }
    }

    signingConfigs {
        if (keystorePropertiesFile.exists()) {
            val keyConfig: com.android.build.api.dsl.ApkSigningConfig.() -> Unit = {
                keyAlias = keystoreProperties["keyAlias"] as? String ?: ""
                keyPassword = keystoreProperties["keyPassword"] as? String ?: ""
                storeFile = keystoreProperties["storeFile"]?.let {
                    val f = file(it)
                    if (f.exists()) f else rootProject.file(it)
                }
                storePassword = keystoreProperties["storePassword"] as? String ?: ""
            }
            create("release", keyConfig)
            getByName("debug", keyConfig)
        }
    }

    buildTypes {
        val appSigningConfig = signingConfigs.findByName("release") ?: signingConfigs.findByName("debug")

        getByName("debug") {
            if (appSigningConfig != null) {
                signingConfig = appSigningConfig
            }
        }
        getByName("release") {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
            if (appSigningConfig != null) {
                signingConfig = appSigningConfig
            }
        }
        maybeCreate("profile").apply {
            initWith(getByName("release"))
            matchingFallbacks += listOf("release")
            if (appSigningConfig != null) {
                signingConfig = appSigningConfig
            }
        }
    }
    buildToolsVersion = "36.1.0"
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
