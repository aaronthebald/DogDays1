//
//  WeatherModel.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/28/23.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
/*
 URL:
 https://api.open-meteo.com/v1/forecast?latitude=33.99&longitude=-81.07&daily=weathercode,temperature_2m_max&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=auto
 */
/*
 {"latitude":33.993935,"longitude":-81.068756,"generationtime_ms":0.9579658508300781,"utc_offset_seconds":-14400,"timezone":"America/New_York","timezone_abbreviation":"EDT","elevation":85.0,"daily_units":{"time":"iso8601","weathercode":"wmo code","temperature_2m_max":"°F"},"daily":{"time":["2023-03-28","2023-03-29","2023-03-30","2023-03-31","2023-04-01","2023-04-02","2023-04-03"],"weathercode":[45,3,0,3,80,3,53],"temperature_2m_max":[74.5,59.1,68.6,76.9,77.1,74.5,81.2]}}
 */

import Foundation

// MARK: - Welcome
struct WeatherData: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let dailyUnits: DailyUnits
    let daily: Daily

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case dailyUnits = "daily_units"
        case daily
    }
}

// MARK: - Daily
struct Daily: Codable {
    let time: [String]
    let weathercode: [Int]
    let temperature2MMax: [Double]

    enum CodingKeys: String, CodingKey {
        case time, weathercode
        case temperature2MMax = "temperature_2m_max"
    }
}

// MARK: - DailyUnits
struct DailyUnits: Identifiable, Codable {
    let time, weathercode, id, temperature2MMax: String

    enum CodingKeys: String, CodingKey {
        case time, weathercode, id
        case temperature2MMax = "temperature_2m_max"
    }
}




//// MARK: - Daily
//struct WeatherModel: Identifiable, Codable {
//    let time: [String]
//    let weathercode: [Int]
//    let temperature2MMax: [Double]
//    let id: String
//
//    enum CodingKeys: String, CodingKey {
//        case time, weathercode, id
//        case temperature2MMax = "temperature_2m_max"
//    }
//}



