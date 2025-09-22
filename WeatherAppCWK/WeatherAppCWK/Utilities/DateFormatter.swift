//
//  DateFormatter.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import Foundation


// utility class provides various static methods and closures for converting from JSON into human-readable date formats.

class DateFormatterUtils {
    // MARK: - Predefined DateFormatter Instances
    
    static let shared: DateFormatter = {
        // Returns a date formatter for the format "dd-MM-yyyy HH:mm:ss" (e.g., "21-12-2024 14:30:00").
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return dateFormatter
    }()

    static let shortDateFormat: DateFormatter = {
        // Returns a date formatter for the format "dd/MM/yyyy" (e.g., "21/12/2024").
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()

    static let timeFormat: DateFormatter = {
        // Returns a date formatter for the format "HH:mm:ss" (e.g., "14:30:00").
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter
    }()

    static let customFormat: DateFormatter = {
        // Returns a date formatter for the ISO 8601 format "yyyy-MM-dd'T'HH:mm:ssZ" (e.g., "2024-12-21T14:30:00Z").
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()

    // MARK: - Utility Methods
    
    //Converts a Unix timestamp into a formatted date string.(e.g., "21-12-2024 14:30:00"
    static func formattedDate(from timestamp: Int, format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))  // Convert Unix timestamp to a `Date` object.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format  // Apply the specified date format.
        return dateFormatter.string(from: date)
    }

    //Returns the current date formatted as a string.(e.g., "21-12-2024")
    static func formattedCurrentDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format  // Apply the specified format.
        return dateFormatter.string(from: Date())  // Format the current date.
    }

    
    static func formattedDateWithStyle(from timestamp: Int, style: DateFormatter.Style) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style  // Apply the desired style (e.g., full date).
        return dateFormatter.string(from: date)
    }

   
    static func formattedDate12Hour(from timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"  // 12-hour time format with AM/PM.
        return dateFormatter.string(from: date)
    }

    
    static func formattedDateWithDay(from timestamp: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh a E"  // Format: 12-hour time with AM/PM and abbreviated day of the week.
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: timestamp))
        return dateString
    }

   
    static func formattedDateWithWeekdayAndDay(from timestamp: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd"  // Format: full weekday name and day of the month.
        return dateFormatter.string(from: Date(timeIntervalSince1970: timestamp))
    }

    
    static func formattedDateTime(from timestamp: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy 'at' h a"  // Format: day, abbreviated month, year, and time.
        return dateFormatter.string(from: Date(timeIntervalSince1970: timestamp))
    }
}
