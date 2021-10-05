//
//  Extensions.swift
//  Parkv2
//
//  Created by Andreas on 10/5/21.
//

import SwiftUI

extension Color {
    static let Primary = Color("Primary")
    static let Secondary = Color("Secondary")
    static let Dark = Color("Dark")
    static let Light = Color("Light")
    static let Card = Color("Card")
    static let Black = Color("Black")
}

extension LinearGradient: Equatable {
    public static func == (lhs: LinearGradient, rhs: LinearGradient) -> Bool {
        return false
    }
    
    static let Primary = LinearGradient(colors: [.Secondary, .Primary], startPoint: .topLeading, endPoint: .bottom)
    static let Secondary = LinearGradient(colors: [.Primary, .Secondary], startPoint: .topLeading, endPoint: .bottom)
    static let Light = LinearGradient(colors: [.Light, .Light.opacity(0.6)], startPoint: .topLeading, endPoint: .bottom)
    static let Dark = LinearGradient(colors: [.Black, .Black], startPoint: .topLeading, endPoint: .bottom)
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

extension UserDefaults {
    func codable<T: Decodable>(forKey key: String) -> T? {
        guard let data = data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func setEncode<T: Encodable>(_ value: T, forKey defaultName: String) {
        guard let data = try? JSONEncoder().encode(value) else { return }
        set(data, forKey: defaultName)
    }
}

#if os(iOS)
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
#endif
extension Character {
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
        
    }
    
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }
    
    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
    
    
}

extension String {
    var isSingleEmoji: Bool { count == 1 && containsEmoji }
    
    var containsEmoji: Bool { contains { $0.isEmoji } }
    
    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }
    
    var emojiString: String { emojis.map { String($0) }.reduce("", +) }
    
    var emojis: [Character] { filter { $0.isEmoji } }
    
    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
}
extension Array where Element: BinaryInteger {

    /// The average value of all the items in the array
    var average: Double {
        if self.isEmpty {
            return 0.0
        } else {
            let sum = self.reduce(0, +)
            return Double(sum) / Double(self.count)
        }
    }

}
