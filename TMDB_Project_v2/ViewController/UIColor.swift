////
////  UIColor.swift
////  TMDB_Project_v2
////
////  Created by Oleksandr Sushchenko on 06.03.2023.
////
//
//
//import UIKit
//
//extension UIColor {
//    convenience init?(hex: String) {
//        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
//        hexString = hexString.replacingOccurrences(of: "#", with: "")
//
//        var rgbValue: UInt64 = 0
//        Scanner(string: hexString).scanHexInt64(&rgbValue)
//
//        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
//        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
//        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
//
//        self.init(red: red, green: green, blue: blue, alpha: 1.0)
//    }
//}
//
//
//
//
//extension UIView {
//    func addGradientBackground(color1: UIColor, color2: UIColor, color3: UIColor) {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.bounds
//        gradientLayer.colors = [color1.cgColor, color2.cgColor, color3.cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
//        self.layer.insertSublayer(gradientLayer, at: 0)
//    }
//}
