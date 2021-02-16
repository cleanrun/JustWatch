//
//  JWExtensions.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import Foundation
import SwiftUI

// MARK: View Extensions
extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
    
    func cornerRadiusWithEachCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// MARK: Rounded Corner Struct
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// MARK: Button Styles
struct WhiteRectangleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.custom("Arial", size: 18))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .contentShape(Rectangle())
            .foregroundColor(.black)
            .background(configuration.isPressed ? Color.gray.opacity(0.5) : Color.white)
            .cornerRadius(8)
            .shadow(radius: 5)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.custom("Arial", size: 18))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .contentShape(Rectangle())
            .foregroundColor(.white)
            //.background(configuration.isPressed ? Color(hex: Configs.BG_PRIMARY_2).opacity(0.5) : Color(hex: Configs.BG_PRIMARY_2))
            .cornerRadius(8)
            .shadow(radius: 3)
    }
}

// MARK: Color Extension
extension Color {
    static let SAPPHIRE = Color.init(hex: JWConfig.COLOR_SAPPHIRE)
    static let DANUBE = Color.init(hex: JWConfig.COLOR_DANUBE)
    static let LAVENDER_GRAY = Color.init(hex: JWConfig.COLOR_LAVENDER_GRAY)
    static let LIGHT_ORCHID = Color.init(hex: JWConfig.COLOR_LIGHT_ORCHID)
    static let STRIKEMASTER = Color.init(hex: JWConfig.COLOR_STRIKEMASTER)
    static let LIGHT_GRAY = Color.init(hex: JWConfig.COLOR_LIGHT_GRAY)
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: String Extension
extension String {
    public func toMovieGenre() -> String {
        switch self {
        case JWConfig.MOVIE_GENRE_ACTION:
            return "Action"
        case JWConfig.MOVIE_GENRE_ADVENTURE:
            return "Adventure"
        case JWConfig.MOVIE_GENRE_ANIMATION:
            return "Animation"
        case JWConfig.MOVIE_GENRE_COMEDY:
            return "Comedy"
        case JWConfig.MOVIE_GENRE_CRIME:
            return "Crime"
        case JWConfig.MOVIE_GENRE_DOCUMENTARY:
            return "Documentary"
        case JWConfig.MOVIE_GENRE_DRAMA:
            return "Drama"
        case JWConfig.MOVIE_GENRE_FAMILY:
            return "Family"
        case JWConfig.MOVIE_GENRE_FANTASY:
            return "Fantasy"
        case JWConfig.MOVIE_GENRE_HISTORY:
            return "History"
        case JWConfig.MOVIE_GENRE_HORROR:
            return "Horror"
        case JWConfig.MOVIE_GENRE_MUSIC:
            return "Music"
        case JWConfig.MOVIE_GENRE_MYSTERY:
            return "Mystery"
        case JWConfig.MOVIE_GENRE_ROMANCE:
            return "Romance"
        case JWConfig.MOVIE_GENRE_SCIFI:
            return "Science-Fiction"
        case JWConfig.MOVIE_GENRE_TV_MOVIE:
            return "TV Movie"
        case JWConfig.MOVIE_GENRE_THRILLER:
            return "Thriller"
        case JWConfig.MOVIE_GENRE_WAR:
            return "War"
        case JWConfig.MOVIE_GENRE_WESTERN:
            return "Western"
        default:
            return ""
        }
    }
    
    public func toTVGenre() -> String {
        switch self {
        case JWConfig.TV_GENRE_ACTION_ADVENTURE:
            return "Action Adventure"
        case JWConfig.TV_GENRE_ANIMATION:
            return "Animation"
        case JWConfig.TV_GENRE_COMEDY:
            return "Comedy"
        case JWConfig.TV_GENRE_CRIME:
            return "Crime"
        case JWConfig.TV_GENRE_DOCUMENTARY:
            return "Documentary"
        case JWConfig.TV_GENRE_DRAMA:
            return "Drama"
        case JWConfig.TV_GENRE_FAMILY:
            return "Family"
        case JWConfig.TV_GENRE_KIDS:
            return "Kids"
        case JWConfig.TV_GENRE_MYSTERY:
            return "Mystery"
        case JWConfig.TV_GENRE_NEWS:
            return "News"
        case JWConfig.TV_GENRE_REALITY:
            return "Reality"
        case JWConfig.TV_GENRE_SCIFI_FANTASY:
            return "Sci-Fi & Fantasy"
        case JWConfig.TV_GENRE_SOAP:
            return "Soap Opera"
        case JWConfig.TV_GENRE_TALK:
            return "Talkshow"
        case JWConfig.TV_GENRE_WAR_POLITICS:
            return "War and Politics"
        case JWConfig.TV_GENRE_WESTERN:
            return "Western"
        default:
            return ""
        }
    }
}

// MARK: UIScreen Extension
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

// MARK: Double Extension
extension Double {
    public static func random(lower: Double = 0, upper: Double = 100) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}
