import SwiftUI

struct FullScreenClock: View {
    
    let date: Date
    let timeZone: TimeZone
    
    private var calendar: Calendar {
        var cal = Calendar.current
        cal.timeZone = timeZone
        return cal
    }
    
    private var hour: Int {
        calendar.component(.hour, from: date)
    }
    
    private var timeFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "h:mm:ss a"
        df.timeZone = timeZone
        return df
    }
    
    // MARK: Dynamic Gradient (like your old card)
    private var dynamicGradient: LinearGradient {
        switch hour {
        case 5..<12:
            return LinearGradient(
                colors: [Color.orange, Color.yellow.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case 12..<17:
            return LinearGradient(
                colors: [Color.cyan, Color.green.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case 17..<19:
            return LinearGradient(
                colors: [Color.orange, Color.indigo],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        default:
            return LinearGradient(
                colors: [Color.black, Color.blue.opacity(0.9)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            
            ZStack {
                
                // Background
                dynamicGradient
                    .ignoresSafeArea()
                
                // Clock
                VStack {
                    
                    Spacer()
                    
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        
                        Text(timeFormatter.string(from: date).dropLast(3))
                            .font(.system(
                                size: geo.size.width * 0.22, // 🔥 HUGE
                                weight: .ultraLight
                            ))
                            .monospacedDigit()
                            .minimumScaleFactor(0.5)
                        
                        Text(String(timeFormatter.string(from: date).suffix(2)))
                            .font(.system(
                                size: geo.size.width * 0.07
                            ))
                            .opacity(0.8)
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                }
            }
        }
    }
}