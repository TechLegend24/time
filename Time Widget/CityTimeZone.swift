import Foundation

struct CityTimeZone: Identifiable, Hashable {
    let id = UUID()
    let city: String
    let country: String
    let timeZoneID: String

    var timeZone: TimeZone {
        TimeZone(identifier: timeZoneID)!
    }

    var utcOffsetString: String {
        let seconds = timeZone.secondsFromGMT()
        let hours = seconds / 3600
        let minutes = abs(seconds % 3600) / 60
        return String(format: "UTC%+d:%02d", hours, minutes)
    }

    var displayName: String {
        "\(city), \(country)"
    }
}
