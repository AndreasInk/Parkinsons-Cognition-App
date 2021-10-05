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
    static let Light = LinearGradient(colors: [.Light, .Light], startPoint: .topLeading, endPoint: .bottom)
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
