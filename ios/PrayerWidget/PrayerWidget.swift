import WidgetKit
import SwiftUI
import Intents

// MARK: - Models

struct PrayerTimelinePayload: Codable {
    let location: String
    let days: [PrayerDayInfo]
    let labels: PrayerLabels
}

struct PrayerDayInfo: Codable {
    let date: String
    let date_formatted: String
    let fajr: String
    let fajr_formatted: String
    let sunrise: String
    let sunrise_formatted: String
    let dhuhr: String
    let dhuhr_formatted: String
    let asr: String
    let asr_formatted: String
    let maghrib: String
    let maghrib_formatted: String
    let isha: String
    let isha_formatted: String
}

struct PrayerLabels: Codable {
    let fajr: String
    let sunrise: String
    let dhuhr: String
    let asr: String
    let maghrib: String
    let isha: String
    let next: String
}

struct PrayerTimelineEntry: TimelineEntry {
    let date: Date
    let location: String
    let dateFormatted: String
    let currentPrayerName: String
    let currentPrayerIndex: Int // 0: Fajr, 1: Dhuhr, 2: Asr, 3: Maghrib, 4: Isha, -1: None/Sunrise
    let nextPrayerName: String
    let nextPrayerTargetDate: Date
    let nextPrayerFormatted: String
    let fajrTime: String
    let sunriseTime: String
    let dhuhrTime: String
    let asrTime: String
    let maghribTime: String
    let ishaTime: String
    let labels: PrayerLabels
}

// MARK: - Timeline Provider

struct PrayerTimelineProvider: TimelineProvider {
    let appGroupId = "group.com.ismail_hosen_james.al_bayan_quran"

    func placeholder(in context: Context) -> PrayerTimelineEntry {
        sampleEntry(for: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (PrayerTimelineEntry) -> Void) {
        completion(getLiveEntry(for: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PrayerTimelineEntry>) -> Void) {
        var entries: [PrayerTimelineEntry] = []
        let now = Date()

        guard let userDefaults = UserDefaults(suiteName: appGroupId),
              let jsonString = userDefaults.string(forKey: "prayer_timeline_json"),
              let data = jsonString.data(using: .utf8),
              let payload = try? JSONDecoder().decode(PrayerTimelinePayload.self, from: data) else {
            let entry = sampleEntry(for: now)
            let timeline = Timeline(entries: [entry], policy: .after(now.addingTimeInterval(3600)))
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

        // Build transitions across all days
        struct Event {
            let name: String
            let date: Date
            let formattedTime: String
            let index: Int
            let dayInfo: PrayerDayInfo
        }

        var allEvents: [Event] = []
        for day in payload.days {
            if let fDate = parseISO(day.fajr) {
                allEvents.append(Event(name: payload.labels.fajr, date: fDate, formattedTime: day.fajr_formatted, index: 0, dayInfo: day))
            }
            if let sDate = parseISO(day.sunrise) {
                allEvents.append(Event(name: payload.labels.sunrise, date: sDate, formattedTime: day.sunrise_formatted, index: -1, dayInfo: day))
            }
            if let dDate = parseISO(day.dhuhr) {
                allEvents.append(Event(name: payload.labels.dhuhr, date: dDate, formattedTime: day.dhuhr_formatted, index: 1, dayInfo: day))
            }
            if let aDate = parseISO(day.asr) {
                allEvents.append(Event(name: payload.labels.asr, date: aDate, formattedTime: day.asr_formatted, index: 2, dayInfo: day))
            }
            if let mDate = parseISO(day.maghrib) {
                allEvents.append(Event(name: payload.labels.maghrib, date: mDate, formattedTime: day.maghrib_formatted, index: 3, dayInfo: day))
            }
            if let iDate = parseISO(day.isha) {
                allEvents.append(Event(name: payload.labels.isha, date: iDate, formattedTime: day.isha_formatted, index: 4, dayInfo: day))
            }
        }

        allEvents.sort { $0.date < $1.date }

        // Generate timeline entry starting at 'now' and at each transition
        if allEvents.isEmpty {
            entries.append(sampleEntry(for: now))
        } else {
            // First entry for current moment
            entries.append(buildEntryFromEvents(allEvents, at: now, payload: payload))

            // Future entries at each event time
            for event in allEvents where event.date > now {
                entries.append(buildEntryFromEvents(allEvents, at: event.date, payload: payload))
            }
        }

        let refreshDate = entries.last?.date.addingTimeInterval(3600) ?? now.addingTimeInterval(3600)
        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }

    private func buildEntryFromEvents(_ events: [PrayerTimelineProvider.Event], at targetDate: Date, payload: PrayerTimelinePayload) -> PrayerTimelineEntry {
        var currentEvent: PrayerTimelineProvider.Event?
        var nextEvent: PrayerTimelineProvider.Event?

        for i in 0..<events.count {
            if events[i].date <= targetDate {
                currentEvent = events[i]
            } else if events[i].date > targetDate && nextEvent == nil {
                nextEvent = events[i]
            }
        }

        let day = currentEvent?.dayInfo ?? events.first?.dayInfo ?? payload.days.first!
        let nextTarget = nextEvent?.date ?? targetDate.addingTimeInterval(3600 * 3)

        return PrayerTimelineEntry(
            date: targetDate,
            location: payload.location,
            dateFormatted: day.date_formatted,
            currentPrayerName: currentEvent?.name ?? payload.labels.fajr,
            currentPrayerIndex: currentEvent?.index ?? -1,
            nextPrayerName: nextEvent?.name ?? payload.labels.fajr,
            nextPrayerTargetDate: nextTarget,
            nextPrayerFormatted: nextEvent?.formattedTime ?? "--:--",
            fajrTime: day.fajr_formatted,
            sunriseTime: day.sunrise_formatted,
            dhuhrTime: day.dhuhr_formatted,
            asrTime: day.asr_formatted,
            maghribTime: day.maghrib_formatted,
            ishaTime: day.isha_formatted,
            labels: payload.labels
        )
    }

    private func getLiveEntry(for date: Date) -> PrayerTimelineEntry {
        guard let userDefaults = UserDefaults(suiteName: appGroupId),
              let jsonString = userDefaults.string(forKey: "prayer_timeline_json"),
              let data = jsonString.data(using: .utf8),
              let payload = try? JSONDecoder().decode(PrayerTimelinePayload.self, from: data),
              let firstDay = payload.days.first else {
            return sampleEntry(for: date)
        }

        return PrayerTimelineEntry(
            date: date,
            location: payload.location,
            dateFormatted: firstDay.date_formatted,
            currentPrayerName: payload.labels.fajr,
            currentPrayerIndex: 0,
            nextPrayerName: payload.labels.dhuhr,
            nextPrayerTargetDate: date.addingTimeInterval(3600 * 3),
            nextPrayerFormatted: firstDay.dhuhr_formatted,
            fajrTime: firstDay.fajr_formatted,
            sunriseTime: firstDay.sunrise_formatted,
            dhuhrTime: firstDay.dhuhr_formatted,
            asrTime: firstDay.asr_formatted,
            maghribTime: firstDay.maghrib_formatted,
            ishaTime: firstDay.isha_formatted,
            labels: payload.labels
        )
    }

    private func sampleEntry(for date: Date) -> PrayerTimelineEntry {
        PrayerTimelineEntry(
            date: date,
            location: "Prayer Times",
            dateFormatted: "Friday, Aug 21",
            currentPrayerName: "Asr",
            currentPrayerIndex: 2,
            nextPrayerName: "Maghrib",
            nextPrayerTargetDate: date.addingTimeInterval(2500),
            nextPrayerFormatted: "6:24 PM",
            fajrTime: "4:32 AM",
            sunriseTime: "5:50 AM",
            dhuhrTime: "12:15 PM",
            asrTime: "4:30 PM",
            maghribTime: "6:24 PM",
            ishaTime: "7:45 PM",
            labels: PrayerLabels(fajr: "Fajr", sunrise: "Sunrise", dhuhr: "Dhuhr", asr: "Asr", maghrib: "Maghrib", isha: "Isha", next: "Next")
        )
    }
}

// MARK: - SwiftUI Views with Dark & Light Theme Support

struct PrayerSmallWidgetView: View {
    @Environment(\.colorScheme) var colorScheme
    let entry: PrayerTimelineEntry

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
                HStack(spacing: 4) {
                    Text("🕌")
                        .font(.system(size: 11))
                    Text(entry.location)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(isDark ? Color(white: 0.9) : Color(red: 0.1, green: 0.12, blue: 0.15))
                        .lineLimit(1)
                    Spacer()
                }

                Spacer()

                // Center: Next Prayer Name & Time
                VStack(alignment: .leading, spacing: 2) {
                    Text(entry.nextPrayerName.uppercased())
                        .font(.system(size: 18, weight: .black, design: .rounded))
                        .foregroundColor(isDark ? Color(red: 0.20, green: 0.83, blue: 0.60) : Color(red: 0.02, green: 0.59, blue: 0.41))

                    Text(entry.nextPrayerFormatted)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(isDark ? .white : Color(red: 0.1, green: 0.12, blue: 0.15))
                }

                Spacer()

                // Bottom: Relative Live Countdown
                HStack(spacing: 4) {
                    Text("In")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(isDark ? Color(red: 0.43, green: 0.90, blue: 0.72) : Color(red: 0.02, green: 0.47, blue: 0.34))
                    Text(entry.nextPrayerTargetDate, style: .timer)
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(isDark ? Color(red: 0.43, green: 0.90, blue: 0.72) : Color(red: 0.02, green: 0.47, blue: 0.34))
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background(isDark ? Color(red: 0.10, green: 0.73, blue: 0.51).opacity(0.18) : Color(red: 0.92, green: 0.99, blue: 0.96))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isDark ? Color.clear : Color(red: 0.65, green: 0.95, blue: 0.82), lineWidth: 1)
                )
            }
            .padding(12)
        }
        .widgetURL(URL(string: "al-quran://prayer"))
    }
}

struct PrayerMediumWidgetView: View {
    @Environment(\.colorScheme) var colorScheme
    let entry: PrayerTimelineEntry

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

            VStack(spacing: 8) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 1) {
                        HStack(spacing: 4) {
                            Text("🕌")
                                .font(.system(size: 11))
                            Text(entry.location)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(isDark ? .white : Color(red: 0.1, green: 0.12, blue: 0.15))
                                .lineLimit(1)
                        }
                        Text(entry.dateFormatted)
                            .font(.system(size: 9.5, weight: .medium))
                            .foregroundColor(isDark ? Color(white: 0.6) : Color(white: 0.45))
                    }

                    Spacer()

                    // Next Prayer Countdown Pill
                    HStack(spacing: 4) {
                        Text("\(entry.labels.next): \(entry.nextPrayerName)")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(isDark ? Color(red: 0.43, green: 0.90, blue: 0.72) : Color(red: 0.02, green: 0.47, blue: 0.34))
                        Text(entry.nextPrayerTargetDate, style: .timer)
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundColor(isDark ? Color(red: 0.43, green: 0.90, blue: 0.72) : Color(red: 0.02, green: 0.47, blue: 0.34))
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(isDark ? Color(red: 0.10, green: 0.73, blue: 0.51).opacity(0.18) : Color(red: 0.92, green: 0.99, blue: 0.96))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isDark ? Color.clear : Color(red: 0.65, green: 0.95, blue: 0.82), lineWidth: 1)
                    )
                }

                // 5-Prayer Row
                HStack(spacing: 4) {
                    prayerColumn(title: entry.labels.fajr, time: entry.fajrTime, isActive: entry.currentPrayerIndex == 0)
                    prayerColumn(title: entry.labels.dhuhr, time: entry.dhuhrTime, isActive: entry.currentPrayerIndex == 1)
                    prayerColumn(title: entry.labels.asr, time: entry.asrTime, isActive: entry.currentPrayerIndex == 2)
                    prayerColumn(title: entry.labels.maghrib, time: entry.maghribTime, isActive: entry.currentPrayerIndex == 3)
                    prayerColumn(title: entry.labels.isha, time: entry.ishaTime, isActive: entry.currentPrayerIndex == 4)
                }
            }
            .padding(12)
        }
        .widgetURL(URL(string: "al-quran://prayer"))
    }

    @ViewBuilder
    private func prayerColumn(title: String, time: String, isActive: Bool) -> some View {
        VStack(spacing: 3) {
            Text(title)
                .font(.system(size: 10, weight: isActive ? .bold : .medium))
                .foregroundColor(
                    isActive
                        ? .white
                        : (isDark ? Color(white: 0.75) : Color(red: 0.35, green: 0.38, blue: 0.42))
                )
                .lineLimit(1)

            Text(time)
                .font(.system(size: 10.5, weight: .bold, design: .rounded))
                .foregroundColor(
                    isActive
                        ? .white
                        : (isDark ? .white : Color(red: 0.1, green: 0.12, blue: 0.15))
                )
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 4)
        .background(
            isActive
                ? (isDark ? Color(red: 0.11, green: 0.48, blue: 0.36) : Color(red: 0.02, green: 0.59, blue: 0.41))
                : (isDark ? Color.white.opacity(0.06) : Color(red: 0.95, green: 0.96, blue: 0.97))
        )
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    isActive
                        ? (isDark ? Color(red: 0.30, green: 0.85, blue: 0.65) : Color(red: 0.02, green: 0.47, blue: 0.34))
                        : (isDark ? Color.clear : Color(red: 0.90, green: 0.91, blue: 0.93)),
                    lineWidth: 1
                )
        )
    }
}

// MARK: - Lock Screen Views (iOS 16+)

struct PrayerLockScreenRectangularView: View {
    let entry: PrayerTimelineEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 4) {
                Image(systemName: "clock.fill")
                    .font(.system(size: 10))
                Text("\(entry.nextPrayerName): \(entry.nextPrayerFormatted)")
                    .font(.system(size: 12, weight: .bold))
            }
            HStack(spacing: 3) {
                Text("In")
                    .font(.system(size: 11))
                Text(entry.nextPrayerTargetDate, style: .timer)
                    .font(.system(size: 11, weight: .semibold, design: .monospaced))
            }
            Text(entry.location)
                .font(.system(size: 10))
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
    }
}

struct PrayerLockScreenCircularView: View {
    let entry: PrayerTimelineEntry

    var body: some View {
        ZStack {
            AccessoryWidgetBackground()
            VStack(spacing: 1) {
                Text(entry.nextPrayerName)
                    .font(.system(size: 10, weight: .bold))
                Text(entry.nextPrayerFormatted)
                    .font(.system(size: 9, weight: .semibold))
            }
        }
    }
}

struct PrayerLockScreenInlineView: View {
    let entry: PrayerTimelineEntry

    var body: some View {
        Text("\(entry.nextPrayerName) at \(entry.nextPrayerFormatted)")
    }
}

// MARK: - Entry View Router

struct PrayerWidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: PrayerTimelineEntry

    var body: some View {
        switch family {
        case .systemSmall:
            PrayerSmallWidgetView(entry: entry)
        case .systemMedium:
            PrayerMediumWidgetView(entry: entry)
        case .accessoryRectangular:
            PrayerLockScreenRectangularView(entry: entry)
        case .accessoryCircular:
            PrayerLockScreenCircularView(entry: entry)
        case .accessoryInline:
            PrayerLockScreenInlineView(entry: entry)
        default:
            PrayerSmallWidgetView(entry: entry)
        }
    }
}

// MARK: - Main Widget Bundle

@main
struct PrayerWidget: Widget {
    let kind: String = "PrayerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PrayerTimelineProvider()) { entry in
            PrayerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Prayer Times")
        .description("Track prayer times, active prayer, and next prayer countdown on your home and lock screen.")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .accessoryRectangular,
            .accessoryCircular,
            .accessoryInline
        ])
    }
}
