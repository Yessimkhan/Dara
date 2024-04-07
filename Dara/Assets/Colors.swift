//
//  Colors.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 04.04.2024.
//

import SwiftUI

enum Colors {
    static let alphabet = Color(hex: "FF3131")
    static let alphabetConsonant = Color(hex: "004AAD")
    static let brandPrimary = Color(hex: "00A6C8")
    static let brandSecondary = Color(hex: "FFED40")
    static let brandTertiary = Color(hex: "65D0E3")
    static let buttonInactive = Color(hex: "919399")
    static let brandAdditional = Color(hex: "F7F8F3")
    static let correctAnswer = Color(hex: "5DEF46")
    static let wrongAnswer = Color(hex: "FE2C16")
    static let white = Color(hex: "FFFFFF")
    static let black = Color(hex: "000000")
    static let textFieldBackground = Color(hex: "080E1E").opacity(0.05)
    static let gradient = LinearGradient(colors: [white, brandPrimary], startPoint: .topLeading, endPoint: .bottomTrailing)
}

extension Color {
    init(hex: String, a: Double = 1) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue, opacity: a)
    }
}
