//
//  String+Extensions.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import UIKit


extension String {
    
    func withColor(_ color: UIColor, for substring: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        
        let range = (self as NSString).range(of: substring)
        
        if range.location != NSNotFound {
            attributedString.addAttribute(.foregroundColor, value: color, range: range)
        }
        
        return attributedString
    }
    
    func toBrazilianDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        guard let date = formatter.date(from: self) else { return self }

        let output = DateFormatter()
        output.locale = Locale(identifier: "pt_BR")
        output.dateFormat = "dd/MM/yyyy"
        return output.string(from: date)
    }
}
