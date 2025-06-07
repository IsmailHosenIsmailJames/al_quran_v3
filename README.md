# Al Quran v3

An intuitive Flutter application designed to help users read the Holy Quran, keep track of prayer times, and personalize their religious learning experience. This app aims to provide a seamless and accessible platform for daily Islamic practices.

## Key Features

*   **Comprehensive Quran Navigation**:
    *   Read the Holy Quran with an easy-to-use interface.
    *   Navigate by Surah, Juz, Page, Hizb, and Ruku for flexible study.
*   **Accurate Prayer Times & Reminders**:
    *   Calculates prayer times based on user's location (latitude/longitude).
    *   Displays current location (city/area).
    *   Shows upcoming prayer times, highlighting the next one with a countdown.
    *   Allows users to set and manage reminders for individual prayers.
    *   Plays Adhan for prayer notifications.
*   **Initial Setup and Customization**:
    *   User-friendly setup process to tailor the app experience.
    *   Selectable app interface language.
    *   Choose preferred Quran translation(s) from various languages and books.
    *   Select preferred Quran Tafsir(s) from various languages and books.
    *   Option to select Quran script style (e.g., Tajweed, Uthmani, Indopak).
    *   Downloads required resources (translations, tafsirs, word-by-word data, segmented recitation audio) with progress indication.
*   **Offline Data Access**:
    *   Utilizes local storage (Hive) for downloaded Quran resources and user preferences, enabling offline access.
*   **Background Processing**:
    *   Manages prayer time notifications reliably using background tasks.

## About This Project

This application is built using Flutter, ensuring a cross-platform experience on mobile devices. It leverages a rich set of Flutter packages and features to deliver its functionalities:

*   **State Management**: (Assumed, typically BLoC/Cubit given `DownloadProgressCubitCubit`) for managing application state efficiently.
*   **UI Framework**: Flutter widgets for building a responsive and visually appealing user interface.
*   **Navigation**: `PageController` for swipeable views in the Quran reader.
*   **Location Services**: `geocoding` for displaying user's locality.
*   **Date & Time**: `intl` package for formatting dates and times.
*   **Background Tasks**: `workmanager` for scheduling prayer reminder checks.
*   **Notifications & Alarms**: `alarm` package for precise prayer time alerts with custom Adhan audio.
*   **Permissions**: `permission_handler` to request necessary permissions like notifications.
*   **Networking**: `dio` for downloading Quran resources during setup.
*   **Local Storage**: `hive` for storing user preferences and downloaded Quranic data.
*   **Asynchronous Operations**: `compute` for offloading intensive data processing (like JSON parsing) to background isolates, ensuring a smooth UI.
*   **User Feedback**: `fluttertoast` and `toastification` for providing in-app messages and notifications.

We aim to create a beautiful, feature-rich, and user-friendly interface for an enhanced Quran and prayer experience.
