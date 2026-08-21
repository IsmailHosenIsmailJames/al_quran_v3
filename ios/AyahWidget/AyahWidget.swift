import WidgetKit
import SwiftUI
import Intents

// MARK: - Models

struct AyahTimelinePayload: Codable {
    let days: [AyahDayInfo]
}

struct AyahDayInfo: Codable {
    let date: String
    let surah_id: Int
    let ayah_number: Int
    let surah_name: String
    let surah_arabic_name: String
    let reference: String
    let surah_type: String
    let arabic_text: String
    let translation_text: String
    let theme: String
}

struct AyahTimelineEntry: TimelineEntry {
    let date: Date
    let surahId: Int
    let ayahNumber: Int
    let surahName: String
    let surahArabicName: String
    let reference: String
    let surahType: String
    let arabicText: String
    let translationText: String
    let theme: String
}

// MARK: - Timeline Provider

struct AyahTimelineProvider: TimelineProvider {
    let appGroupId = "group.com.ismail_hosen_james.al_bayan_quran"

    func placeholder(in context: Context) -> AyahTimelineEntry {
        sampleEntry(for: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (AyahTimelineEntry) -> Void) {
        completion(getLiveEntry(for: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<AyahTimelineEntry>) -> Void) {
        var entries: [AyahTimelineEntry] = []
        let now = Date()

        guard let userDefaults = UserDefaults(suiteName: appGroupId),
              let jsonString = userDefaults.string(forKey: "ayah_timeline_json"),
              let data = jsonString.data(using: .utf8),
              let payload = try? JSONDecoder().decode(AyahTimelinePayload.self, from: data),
              !payload.days.isEmpty else {
            let entry = sampleEntry(for: now)
            let timeline = Timeline(entries: [entry], policy: .after(now.addingTimeInterval(3600 * 6)))
            completion(timeline)
            return
        }

        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let fallbackFormatter = ISO8601DateFormatter()
        fallbackFormatter.formatOptions = [.withInternetDateTime]

        func parseISO(_ str: String) -> Date? {
            return isoFormatter.date(from: str) ?? fallbackFormatter.date(from: str)
        }

        for (index, day) in payload.days.enumerated() {
            let entryDate = parseISO(day.date) ?? now.addingTimeInterval(Double(index * 86400))
            let entry = AyahTimelineEntry(
                date: entryDate,
                surahId: day.surah_id,
                ayahNumber: day.ayah_number,
                surahName: day.surah_name,
                surahArabicName: day.surah_arabic_name,
                reference: day.reference,
                surahType: day.surah_type,
                arabicText: day.arabic_text,
                translationText: day.translation_text,
                theme: day.theme
            )
            entries.append(entry)
        }

        let refreshDate = entries.last?.date.addingTimeInterval(86400) ?? now.addingTimeInterval(86400)
        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }

    private func getLiveEntry(for date: Date) -> AyahTimelineEntry {
        guard let userDefaults = UserDefaults(suiteName: appGroupId),
              let jsonString = userDefaults.string(forKey: "ayah_timeline_json"),
              let data = jsonString.data(using: .utf8),
              let payload = try? JSONDecoder().decode(AyahTimelinePayload.self, from: data),
              let firstDay = payload.days.first else {
            return sampleEntry(for: date)
        }

        return AyahTimelineEntry(
            date: date,
            surahId: firstDay.surah_id,
            ayahNumber: firstDay.ayah_number,
            surahName: firstDay.surah_name,
            surahArabicName: firstDay.surah_arabic_name,
            reference: firstDay.reference,
            surahType: firstDay.surah_type,
            arabicText: firstDay.arabic_text,
            translationText: firstDay.translation_text,
            theme: firstDay.theme
        )
    }

    private func sampleEntry(for date: Date) -> AyahTimelineEntry {
        AyahTimelineEntry(
            date: date,
            surahId: 2,
            ayahNumber: 255,
            surahName: "Al-Baqarah",
            surahArabicName: "البقرة",
            reference: "2:255",
            surahType: "Medinan • 286 Verses",
            arabicText: "اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ",
            translationText: "Allah - there is no deity except Him, the Ever-Living, the Sustainer of all existence. Neither drowsiness overtakes Him nor sleep.",
            theme: "Ayat al-Kursi"
        )
    }
}

// MARK: - SwiftUI Views with Dark & Light Theme Support

struct AyahSmallWidgetView: View {
    @Environment(\.colorScheme) var colorScheme
    let entry: AyahTimelineEntry

    var isDark: Bool { colorScheme == .dark }

    var body: some View {
        ZStack {
            if isDark {
                LinearGradient(
                    colors: [Color(red: 0.08, green: 0.14, blue: 0.12), Color(red: 0.05, green: 0.09, blue: 0.08)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            } else {
                Color.white
            }

            VStack(alignment: .leading, spacing: 4) {
                // Header
                HStack(spacing: 4) {
                    Text("📖")
                        .font(.system(size: 11))
                    Text(entry.surahName)
                        .font(.system(size: 11.5, weight: .bold))
                        .foregroundColor(isDark ? .white : Color(red: 0.1, green: 0.12, blue: 0.15))
                        .lineLimit(1)
                    Spacer()
                    Text(entry.reference)
                        .font(.system(size: 9.5, weight: .bold, design: .monospaced))
                        .foregroundColor(isDark ? Color(red: 0.43, green: 0.90, blue: 0.72) : Color(red: 0.02, green: 0.47, blue: 0.34))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(isDark ? Color(red: 0.10, green: 0.73, blue: 0.51).opacity(0.18) : Color(red: 0.92, green: 0.99, blue: 0.96))
                        .cornerRadius(6)
                }

                Spacer()

                // Center: Arabic & Translation
                VStack(spacing: 3) {
                    Text(entry.arabicText)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(isDark ? Color(red: 0.30, green: 0.85, blue: 0.65) : Color(red: 0.02, green: 0.59, blue: 0.41))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)

                    Text(entry.translationText)
                        .font(.system(size: 10))
                        .foregroundColor(isDark ? Color(white: 0.75) : Color(white: 0.35))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }

                Spacer()
            }
            .padding(12)
        }
        .widgetURL(URL(string: "al-quran://ayah?surah=\(entry.surahId)&ayah=\(entry.ayahNumber)"))
    }
}

struct AyahMediumWidgetView: View {
    @Environment(\.colorScheme) var colorScheme
    let entry: AyahTimelineEntry

    var isDark: Bool { colorScheme == .dark }

    var body: some View {
        ZStack {
            if isDark {
                LinearGradient(
                    colors: [Color(red: 0.08, green: 0.14, blue: 0.12), Color(red: 0.05, green: 0.09, blue: 0.08)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            } else {
                Color.white
            }

            VStack(alignment: .leading, spacing: 6) {
                // Header
                HStack {
                    HStack(spacing: 4) {
                        Text("📖")
                            .font(.system(size: 11))
                        Text(entry.surahName)
                            .font(.system(size: 12.5, weight: .bold))
                            .foregroundColor(isDark ? .white : Color(red: 0.1, green: 0.12, blue: 0.15))
                        Text(entry.surahArabicName)
                            .font(.system(size: 11.5, weight: .bold))
                            .foregroundColor(isDark ? Color(red: 0.30, green: 0.85, blue: 0.65) : Color(red: 0.02, green: 0.59, blue: 0.41))
                    }

                    Spacer()

                    Text("Ayah \(entry.ayahNumber)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(isDark ? Color(red: 0.43, green: 0.90, blue: 0.72) : Color(red: 0.02, green: 0.47, blue: 0.34))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(isDark ? Color(red: 0.10, green: 0.73, blue: 0.51).opacity(0.18) : Color(red: 0.92, green: 0.99, blue: 0.96))
                        .cornerRadius(10)
                }

                // Body: Arabic Text (Right-aligned)
                Text(entry.arabicText)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(isDark ? .white : Color(red: 0.1, green: 0.12, blue: 0.15))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(2)

                // Body: Translation (Left-aligned)
                Text(entry.translationText)
                    .font(.system(size: 11))
                    .foregroundColor(isDark ? Color(white: 0.75) : Color(white: 0.40))
                    .lineLimit(2)
            }
            .padding(12)
        }
        .widgetURL(URL(string: "al-quran://ayah?surah=\(entry.surahId)&ayah=\(entry.ayahNumber)"))
    }
}

struct AyahLargeWidgetView: View {
    @Environment(\.colorScheme) var colorScheme
    let entry: AyahTimelineEntry

    var isDark: Bool { colorScheme == .dark }

    var body: some View {
        ZStack {
            if isDark {
                LinearGradient(
                    colors: [Color(red: 0.08, green: 0.14, blue: 0.12), Color(red: 0.05, green: 0.09, blue: 0.08)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            } else {
                Color.white
            }

            VStack(alignment: .leading, spacing: 8) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 4) {
                            Text("📖")
                                .font(.system(size: 12))
                            Text(entry.surahName)
                                .font(.system(size: 13.5, weight: .bold))
                                .foregroundColor(isDark ? .white : Color(red: 0.1, green: 0.12, blue: 0.15))
                            Text(entry.surahArabicName)
                                .font(.system(size: 12.5, weight: .bold))
                                .foregroundColor(isDark ? Color(red: 0.30, green: 0.85, blue: 0.65) : Color(red: 0.02, green: 0.59, blue: 0.41))
                        }
                        Text(entry.surahType)
                            .font(.system(size: 10))
                            .foregroundColor(isDark ? Color(white: 0.6) : Color(white: 0.45))
                    }

                    Spacer()

                    Text("Ayah \(entry.ayahNumber)")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(isDark ? Color(red: 0.43, green: 0.90, blue: 0.72) : Color(red: 0.02, green: 0.47, blue: 0.34))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(isDark ? Color(red: 0.10, green: 0.73, blue: 0.51).opacity(0.18) : Color(red: 0.92, green: 0.99, blue: 0.96))
                        .cornerRadius(10)
                }

                Divider()
                    .background(isDark ? Color.white.opacity(0.1) : Color.black.opacity(0.08))

                // Arabic Text
                Text(entry.arabicText)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(isDark ? .white : Color(red: 0.1, green: 0.12, blue: 0.15))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(4)

                // Translation Text
                Text(entry.translationText)
                    .font(.system(size: 12))
                    .foregroundColor(isDark ? Color(white: 0.80) : Color(white: 0.35))
                    .lineLimit(4)

                Spacer()
            }
            .padding(14)
        }
        .widgetURL(URL(string: "al-quran://ayah?surah=\(entry.surahId)&ayah=\(entry.ayahNumber)"))
    }
}

// MARK: - Lock Screen Views (iOS 16+)

struct AyahLockScreenRectangularView: View {
    let entry: AyahTimelineEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 4) {
                Image(systemName: "book.fill")
                    .font(.system(size: 10))
                Text("\(entry.surahName) \(entry.reference)")
                    .font(.system(size: 11.5, weight: .bold))
            }
            Text(entry.translationText)
                .font(.system(size: 10.5))
                .lineLimit(2)
        }
    }
}

struct AyahLockScreenCircularView: View {
    let entry: AyahTimelineEntry

    var body: some View {
        ZStack {
            AccessoryWidgetBackground()
            VStack(spacing: 1) {
                Text("📖")
                    .font(.system(size: 11))
                Text(entry.reference)
                    .font(.system(size: 9, weight: .bold, design: .monospaced))
            }
        }
    }
}

struct AyahLockScreenInlineView: View {
    let entry: AyahTimelineEntry

    var body: some View {
        Text("📖 \(entry.surahName) \(entry.reference): \(entry.translationText)")
    }
}

// MARK: - Entry View Router

struct AyahWidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: AyahTimelineEntry

    var body: some View {
        switch family {
        case .systemSmall:
            AyahSmallWidgetView(entry: entry)
        case .systemMedium:
            AyahMediumWidgetView(entry: entry)
        case .systemLarge:
            AyahLargeWidgetView(entry: entry)
        case .accessoryRectangular:
            AyahLockScreenRectangularView(entry: entry)
        case .accessoryCircular:
            AyahLockScreenCircularView(entry: entry)
        case .accessoryInline:
            AyahLockScreenInlineView(entry: entry)
        default:
            AyahMediumWidgetView(entry: entry)
        }
    }
}

// MARK: - Main Widget Bundle

@main
struct AyahWidget: Widget {
    let kind: String = "AyahWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: AyahTimelineProvider()) { entry in
            AyahWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Quran Ayah of the Day")
        .description("Daily uplifting Quranic verses with Arabic text and translation on your home and lock screen.")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .systemLarge,
            .accessoryRectangular,
            .accessoryCircular,
            .accessoryInline
        ])
    }
}
