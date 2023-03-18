//
//  String.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/14/23.
//

import Foundation
import SwiftUI
extension String {
    func formatPhoneNumber() -> String {
        // Remove any character that is not a number
        let numbersOnly = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let length = numbersOnly.count
    
        // Check for supported phone number length
        if length > 11 {
            return String(numbersOnly.prefix(11)).formatPhoneNumber()
        } else if length < 10 {
            return numbersOnly
        }
    
        var sourceIndex = 0
    
        // Leading Number
        var leadingNumber = ""
        if length == 11, let leadChar = numbersOnly.first {
            leadingNumber = String(leadChar) + " "
            sourceIndex += 1
        }
    
        // Area code
        var areaCode = ""
        let areaCodeLength = 3
        guard let areaCodeSubstring = numbersOnly.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
            return numbersOnly
        }
        areaCode = String(format: "(%@) ", areaCodeSubstring)
        sourceIndex += areaCodeLength
    
        // Prefix, 3 characters
        let prefixLength = 3
        guard let prefix = numbersOnly.substring(start: sourceIndex, offsetBy: prefixLength) else {
            return numbersOnly
        }
        sourceIndex += prefixLength
    
        // Suffix, 4 characters
        let suffixLength = 4
        guard let suffix = numbersOnly.substring(start: sourceIndex, offsetBy: suffixLength) else {
            return numbersOnly
        }
    
        return leadingNumber + areaCode + prefix + "-" + suffix
    }
    
    func substring(start: Int, offsetBy: Int) -> String? {
            guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
                return nil
            }
        
            guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
                return nil
            }
        
            return String(self[substringStartIndex ..< substringEndIndex])
        }
    
    
}
