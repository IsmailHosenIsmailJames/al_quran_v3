# Al Quran v3

An intuitive, feature-rich, and cross-platform Flutter application designed to be your daily companion for reading the Holy Quran, tracking prayer times, and personalizing your Islamic learning experience. This app aims to provide a seamless, beautiful, and accessible platform for daily Islamic practices.

## Screenshots

<!-- Add some screenshots of your app here -->
<!-- e.g., ![Screenshot 1](link_to_screenshot1.png) -->

## Key Features

### Quran Reader
*   **Multiple Scripts**: Read the Quran in various scripts including **Uthmani**, **Indopak**, and **QPC Hafs with Tajweed**. You can switch between these scripts at any time to suit your reading preference.
*   **Flexible Navigation**: Navigate with ease by **Surah**, **Juz**, **Page**, **Hizb**, and **Ruku**. This allows you to quickly jump to any section of the Quran.
*   **Translations & Tafsirs**: Access a wide range of Quran **translations** and **Tafsirs** in multiple languages. You can download your preferred resources and switch between them as you read.
*   **Word-by-Word Analysis**: Understand the Quran on a deeper level with word-by-word translations and analysis. Tap on any word to see its translation and hear its recitation.
*   **Offline Access**: All downloaded resources, including translations and scripts, are available for offline use, so you can read the Quran anytime, anywhere.

### Prayer Times & Qibla
*   **Accurate Timings**: Calculates prayer times based on your current location (latitude/longitude). You can also manually select your location.
*   **Prayer Alerts**: Get notified with **Adhan** for each prayer. You can customize the notification sound and even set reminders before the prayer time.
*   **Upcoming Prayer**: Always know when the next prayer is with a countdown timer, so you never miss a prayer.
*   **Qibla Compass**: An easy-to-use compass to find the direction of the Qibla, ensuring you're always facing the right direction for your prayers.
*   **Location Display**: Shows your current city and area, so you can be sure the prayer times are accurate for your location.

### Audio Player
*   **Audio Recitation**: Listen to segmented recitation audio for each verse. You can choose from a variety of reciters and download your favorite recitations for offline playback.
*   **Word-by-Word Audio**: Listen to the recitation of each word individually to perfect your pronunciation and understanding.
*   **Playlist Support**: Create and play playlists of multiple ayahs, so you can listen to a selection of verses without interruption.
*   **Background Playback**: Listen to the Quran even when the app is in the background, so you can continue your learning while doing other tasks.
*   **Audio Caching**: Downloaded audio is cached for offline playback, so you can listen to your favorite reciters without an internet connection.

### Collections & Notes
*   **Notes**: Take notes on ayahs and organize them into collections. This is a great way to keep track of your reflections and thoughts on the Quran.
*   **Pinned Ayahs**: Pin your favorite ayahs for quick access. You can create multiple collections of pinned ayahs to organize them by topic or theme.
*   **Search & Filter**: Easily search and filter through your collections to find the notes or pinned ayahs you're looking for.
*   **Sorting**: Sort your collections by name, date, or number of items, so you can easily find what you're looking for.

### Personalization & Settings
*   **User-Friendly Onboarding**: A smooth setup process to personalize the app to your liking. You can choose your preferred language, translation, and Quran script.
*   **Multi-Language Support**: The app interface is available in multiple languages, so you can use the app in the language you're most comfortable with.
*   **Resource Management**: Download necessary resources like translations, tafsirs, and audio with a clear progress indicator. You can also manage your downloaded resources to save space on your device.
*   **Theme Customization**: Personalize the look and feel of the app with flexible color options. You can choose from a variety of pre-set themes or create your own.
*   **Quran Script Customization**: Adjust the font size and line height for a comfortable reading experience. You can also choose to show or hide the translation, tafsir, and word-by-word analysis.

### Cross-Platform Support
*   **Android, iOS, Web, and Desktop**: A consistent experience across all major platforms, so you can access your Quran and prayer times from any device.

## Technology Stack

This project is built with Flutter and leverages a variety of packages to deliver a rich user experience:

### Core
*   **[Flutter](https://flutter.dev/)**: The UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
*   **[Dart](https://dart.dev/)**: The programming language used for Flutter development.

### State Management
*   **[flutter_bloc](https://pub.dev/packages/flutter_bloc)**: For predictable state management.

### UI & Theming
*   **[fluentui_system_icons](https://pub.dev/packages/fluentui_system_icons)**: For modern and clean icons.
*   **[flutter_svg](https://pub.dev/packages/flutter_svg)**: To render SVG files.
*   **[audio_video_progress_bar](https://pub.dev/packages/audio_video_progress_bar)**: For a better audio player UI.
*   **[flutter_spinkit](https://pub.dev/packages/flutter_spinkit)**: For loading animations.
*   **[flex_color_picker](https://pub.dev/packages/flex_color_picker)**: For theme customization.

### Data & Storage
*   **[hive](https://pub.dev/packages/hive)** & **[hive_flutter](https://pub.dev/packages/hive_flutter)**: For fast, local database storage.
*   **[shared_preferences](https://pub.dev/packages/shared_preferences)**: For simple key-value storage.

### Networking
*   **[dio](https://pub.dev/packages/dio)**: For powerful and reliable HTTP requests.
*   **[http](https://pub.dev/packages/http)**: For basic HTTP requests.
*   **[cached_network_image](https://pub.dev/packages/cached_network_image)**: To cache network images.

### Audio
*   **[just_audio](https://pub.dev/packages/just_audio)**: A feature-rich audio player.
*   **[just_audio_background](https://pub.dev/packages/just_audio_background)**: To play audio in the background.

### System & Device
*   **[permission_handler](https://pub.dev/packages/permission_handler)**: To request and check permissions.
*   **[geolocator](https://pub.dev/packages/geolocator)** & **[geocoding](https://pub.dev/packages/geocoding)**: For location services.
*   **[flutter_compass](https://pub.dev/packages/flutter_compass)**: For the Qibla compass.
*   **[workmanager](https://pub.dev/packages/workmanager)**: For background tasks.
*   **[awesome_notifications](https://pub.dev/packages/awesome_notifications)**: For local notifications.
*   **[wakelock_plus](https://pub.dev/packages/wakelock_plus)**: To keep the screen awake.

### Utilities
*   **[intl](https://pub.dev/packages/intl)**: For internationalization and localization.
*   **[dartx](https://pub.dev/packages/dartx)**: Superpowers for Dart collections.
*   **[path_provider](https://pub.dev/packages/path_provider)**: For finding commonly used locations on the filesystem.
*   **[share_plus](https://pub.dev/packages/share_plus)**: For sharing content.
*   **[url_launcher](https://pub.dev/packages/url_launcher)**: To launch URLs.

## Project Structure

The project is structured as follows:

*   `lib/`: The main source code of the application.
    *   `src/`: Contains the core logic of the application, divided into features.
        *   `alarm/`: Handles alarm and notification scheduling.
        *   `api/`: Defines API endpoints.
        *   `audio/`: Manages audio playback, including state management and resources.
        *   `functions/`: Contains utility functions used throughout the app.
        *   `notification/`: Manages local notifications.
        *   `resources/`: Contains data and resources used in the app.
        *   `screen/`: Contains the UI screens of the application.
        *   `theme/`: Manages the app's theme and styling.
        *   `widget/`: Contains reusable widgets.
    *   `main.dart`: The entry point of the application.
    *   `l10n/`: Contains localization files.
*   `assets/`: Contains static assets like images, fonts, and data files.
*   `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/`: Platform-specific code.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

*   Flutter SDK: Make sure you have the Flutter SDK installed. You can find instructions [here](https://flutter.dev/docs/get-started/install).

### Installation

1.  Clone the repo
    ```sh
    git clone https://github.com/your_username/al_quran_v3.git
    ```
2.  Install packages
    ```sh
    flutter pub get
    ```
3.  Run the app
    ```sh
    flutter run
    ```

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

Your Name - [@your_twitter](https://twitter.com/your_twitter) - email@example.com

Project Link: [https://github.com/your_username/al_quran_v3](https://github.com/your_username/al_quran_v3)