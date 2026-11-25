allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val sdkDirStr = System.getenv("ANDROID_HOME") ?: System.getenv("ANDROID_SDK_ROOT") ?: "/opt/android-sdk"
val platformsDir = File(sdkDirStr, "platforms")
if (platformsDir.exists()) {
    val p37_0 = File(platformsDir, "android-37.0")
    val p37 = File(platformsDir, "android-37")
    if (p37_0.exists() && !p37.exists()) {
        try {
            p37_0.copyRecursively(p37, overwrite = true)
            val props = File(p37, "source.properties")
            if (props.exists()) {
                val content = props.readText().replace("37.0", "37")
                props.writeText(content)
            }
            val pkgXml = File(p37, "package.xml")
            if (pkgXml.exists()) {
                val content = pkgXml.readText()
                    .replace("37.0", "37")
                    .replace("repository2/04", "repository2/03")
                pkgXml.writeText(content)
            }
        } catch (_: Exception) {}
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    afterEvaluate {
        val android = project.extensions.findByName("android") as? com.android.build.gradle.BaseExtension
        android?.compileSdkVersion(37)
    }
}

subprojects {
    if (project.name != "app") {
        project.evaluationDependsOn(":app")
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
