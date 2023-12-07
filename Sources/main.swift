// The Swift Programming Language
// https://docs.swift.org/swift-book

print("Hello, world!")

import Foundation

func percentageMatch(text: String, pattern: String) -> Double? {
    guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
        return nil
    }
    
    let range = NSRange(location: 0, length: text.utf16.count)
    if let match = regex.firstMatch(in: text, options: [], range: range) {
        let matchLength = match.range.length
        let textLength = text.utf16.count
        let matchPercentage = Double(matchLength) / Double(textLength) * 100.0
        print("\(pattern) Match Percentage: \(matchPercentage)%")
        return matchPercentage
    }
    
    return 0.0
}

let streetPattern = "[\\-öÖäÄüÜß.a-zA-Z\\s]{8,50}[\\d]{1,3}"
let postcodePattern = "([A-Za-z]{2}[-\\s])?[0-9]{5}[-öÖäÄüÜßA-Za-z\\s]{5,35}"
let namePattern = "[\\-öÖäÄüÜß()&.,A-Za-z\\s]{8,35}"
let beforeNamePattern = "[\\W&&[^\\s()&.,]]|^[tza][oun][\\s.:]|^[s][h][i][p][to][\\s.:]|^[f][oü][r][\\s.:]|herr|frau"
let nextNamePattern = "[\\W&&[^\\s,]]"
let removePattern = "delivery|adress|Empf[aä]nger|Consignee|R[üu][e]?cksendung"
let phonePattern = "(\\+?[0-9]+([\\s-][0-9]+)*)"
// let phonePattern = "[\\d]{4,}[\\s]?[\\d]{3,}|[+][\\d]{2}[\\s]?[\\d]{2}"

let testStreetText = "Musterstraße 123"
let testStreetMatchPercentage = percentageMatch(text: testStreetText, pattern: streetPattern)

let testPostcodeText = "DE-12345 Musterstadt"
let testPostcodeMatchPercentage = percentageMatch(text: testPostcodeText, pattern: postcodePattern)

let testNameText = "Max Mustermann"
let testNameMatchPercentage = percentageMatch(text: testNameText, pattern: namePattern)

let testPhoneText = "+49 123 456789"
let testPhoneMatchPercentage = percentageMatch(text: testPhoneText, pattern: phonePattern)

let minimumMatchPercentage = 60.0

var mismatchedPatterns: [String] = []

if let streetMatchPercentage = testStreetMatchPercentage, streetMatchPercentage < minimumMatchPercentage {
    mismatchedPatterns.append("Street Pattern (\(streetMatchPercentage)%)")
}

if let postcodeMatchPercentage = testPostcodeMatchPercentage, postcodeMatchPercentage < minimumMatchPercentage {
    mismatchedPatterns.append("Postcode Pattern (\(postcodeMatchPercentage)%)")
}

if let nameMatchPercentage = testNameMatchPercentage, nameMatchPercentage < minimumMatchPercentage {
    mismatchedPatterns.append("Name Pattern (\(nameMatchPercentage)%)")
}

if let phoneMatchPercentage = testPhoneMatchPercentage, phoneMatchPercentage < minimumMatchPercentage {
    mismatchedPatterns.append("Phone Pattern (\(phoneMatchPercentage)%)")
}

if mismatchedPatterns.isEmpty {
    print("All patterns match at least \(minimumMatchPercentage)%.")
} else {
    print("Patterns not meeting the minimum match percentage:")
    for pattern in mismatchedPatterns {
        print(pattern)
    }
}