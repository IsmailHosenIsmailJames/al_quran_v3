# Audio Service & Just Audio Background
-keep class com.ryanheise.** { *; }
-keep class com.ryanheise.audioservice.** { *; }
-keep class com.ryanheise.just_audio_background.** { *; }
-dontwarn com.ryanheise.**

# ExoPlayer and Media3 Keep Rules (needed by just_audio)
-keep class com.google.android.exoplayer2.** { *; }
-dontwarn com.google.android.exoplayer2.**
-keep class androidx.media3.** { *; }
-dontwarn androidx.media3.**

# Awesome Notifications
-keep class com.google.common.reflect.TypeToken
-keep class * extends com.google.common.reflect.TypeToken

# InAppWebView Keep Rules
-keep class com.pichillilorenzo.flutter_inappwebview.** { *; }
-keep interface com.pichillilorenzo.flutter_inappwebview.** { *; }

