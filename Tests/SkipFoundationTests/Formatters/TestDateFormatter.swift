// Copyright 2023–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
import Foundation
import XCTest

// These tests are adapted from https://github.com/apple/swift-corelibs-foundation/blob/main/Tests/Foundation/Tests which have the following license:

// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2016 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//

#if os(iOS)
// iOS uses a special time separator character
let useModernFoundationFormatting = true
#else
let useModernFoundationFormatting: Bool = {
    if #available(macOS 14, *) {
        // macOS 14 (Sonoma) changes their time sepator character to align with the iOS separator
        return true
    } else {
        // older macOS use a plain space
        return false
    }
}()
#endif

// not a space!
let modernTimeSeparator = " " // 0x202F NARROW NO-BREAK SPACE, like: 1/1/38, 12:00 AM
let ts = useModernFoundationFormatting ? modernTimeSeparator : " " // use the character or a plain space

class TestDateFormatter: XCTestCase {
    
    let DEFAULT_LOCALE = "en_US_POSIX"
    let DEFAULT_TIMEZONE = "GMT"
    


    func test_BasicConstruction() {
        #if SKIP
        throw XCTSkip("TODO")
        #else
        
        let symbolDictionaryOne = ["eraSymbols" : ["BC", "AD"],
                             "monthSymbols" : ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
                             "shortMonthSymbols" : ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                             "weekdaySymbols" : ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
                             "shortWeekdaySymbols" : ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
                             "longEraSymbols" : ["Before Christ", "Anno Domini"],
                             "veryShortMonthSymbols" : ["J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"],
                            "standaloneMonthSymbols" : ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
                            "shortStandaloneMonthSymbols" : ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                            "veryShortStandaloneMonthSymbols" : ["J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"]]
        
        let symbolDictionaryTwo = ["veryShortWeekdaySymbols" : ["S", "M", "T", "W", "T", "F", "S"],
                            "standaloneWeekdaySymbols" : ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
                            "shortStandaloneWeekdaySymbols" : ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
                            "veryShortStandaloneWeekdaySymbols" : ["S", "M", "T", "W", "T", "F", "S"],
                            "quarterSymbols" : ["1st quarter", "2nd quarter", "3rd quarter", "4th quarter"],
                            "shortQuarterSymbols" : ["Q1", "Q2", "Q3", "Q4"],
                            "standaloneQuarterSymbols" : ["1st quarter", "2nd quarter", "3rd quarter", "4th quarter"],
                            "shortStandaloneQuarterSymbols" : ["Q1", "Q2", "Q3", "Q4"]]
        
        let f = DateFormatter()
        XCTAssertNotNil(f.timeZone)
        XCTAssertNotNil(f.locale)
        
        f.timeZone = TimeZone(identifier: DEFAULT_TIMEZONE)
        f.locale = Locale(identifier: DEFAULT_LOCALE)

        // Assert default values are set properly
        XCTAssertFalse(f.generatesCalendarDates)
        XCTAssertNotNil(f.calendar)
        XCTAssertFalse(f.isLenient)
        XCTAssertEqual(f.twoDigitStartDate!, Date(timeIntervalSince1970: -631152000))
        XCTAssertNil(f.defaultDate)
        XCTAssertEqual(f.eraSymbols, symbolDictionaryOne["eraSymbols"]!)
        XCTAssertEqual(f.monthSymbols, symbolDictionaryOne["monthSymbols"]!)
        XCTAssertEqual(f.shortMonthSymbols, symbolDictionaryOne["shortMonthSymbols"]!)
        XCTAssertEqual(f.weekdaySymbols, symbolDictionaryOne["weekdaySymbols"]!)
        XCTAssertEqual(f.shortWeekdaySymbols, symbolDictionaryOne["shortWeekdaySymbols"]!)
        XCTAssertEqual(f.amSymbol, "AM")
        XCTAssertEqual(f.pmSymbol, "PM")
        XCTAssertEqual(f.longEraSymbols, symbolDictionaryOne["longEraSymbols"]!)
        XCTAssertEqual(f.veryShortMonthSymbols, symbolDictionaryOne["veryShortMonthSymbols"]!)
        XCTAssertEqual(f.standaloneMonthSymbols, symbolDictionaryOne["standaloneMonthSymbols"]!)
        XCTAssertEqual(f.shortStandaloneMonthSymbols, symbolDictionaryOne["shortStandaloneMonthSymbols"]!)
        XCTAssertEqual(f.veryShortStandaloneMonthSymbols, symbolDictionaryOne["veryShortStandaloneMonthSymbols"]!)
        XCTAssertEqual(f.veryShortWeekdaySymbols, symbolDictionaryTwo["veryShortWeekdaySymbols"]!)
        XCTAssertEqual(f.standaloneWeekdaySymbols, symbolDictionaryTwo["standaloneWeekdaySymbols"]!)
        XCTAssertEqual(f.shortStandaloneWeekdaySymbols, symbolDictionaryTwo["shortStandaloneWeekdaySymbols"]!)
        XCTAssertEqual(f.veryShortStandaloneWeekdaySymbols, symbolDictionaryTwo["veryShortStandaloneWeekdaySymbols"]!)
        XCTAssertEqual(f.quarterSymbols, symbolDictionaryTwo["quarterSymbols"]!)
        XCTAssertEqual(f.shortQuarterSymbols, symbolDictionaryTwo["shortQuarterSymbols"]!)
        XCTAssertEqual(f.standaloneQuarterSymbols, symbolDictionaryTwo["standaloneQuarterSymbols"]!)
        XCTAssertEqual(f.shortStandaloneQuarterSymbols, symbolDictionaryTwo["shortStandaloneQuarterSymbols"]!)
        XCTAssertEqual(f.gregorianStartDate, Date(timeIntervalSince1970: -12219292800))
        XCTAssertFalse(f.doesRelativeDateFormatting)
        
        #endif // !SKIP
    }
    
    // ShortStyle
    // locale  stringFromDate  example
    // ------  --------------  --------
    // en_US   M/d/yy h:mm a   12/25/15 12:00 AM
    func test_dateStyleShort() {
        #if SKIP
        throw XCTSkip("TODO")
        #else

        let timestamps = [
            -31536000 : "1/1/69, 12:00\(ts)AM" , 0.0 : "1/1/70, 12:00\(ts)AM", 31536000 : "1/1/71, 12:00\(ts)AM",
            2145916800 : "1/1/38, 12:00\(ts)AM", 1456272000 : "2/24/16, 12:00\(ts)AM", 1456358399 : "2/24/16, 11:59\(ts)PM",
            1452574638 : "1/12/16, 4:57\(ts)AM", 1455685038 : "2/17/16, 4:57\(ts)AM", 1458622638 : "3/22/16, 4:57\(ts)AM",
            1459745838 : "4/4/16, 4:57\(ts)AM", 1462597038 : "5/7/16, 4:57\(ts)AM", 1465534638 : "6/10/16, 4:57\(ts)AM",
            1469854638 : "7/30/16, 4:57\(ts)AM", 1470718638 : "8/9/16, 4:57\(ts)AM", 1473915438 : "9/15/16, 4:57\(ts)AM",
            1477285038 : "10/24/16, 4:57\(ts)AM", 1478062638 : "11/2/16, 4:57\(ts)AM", 1482641838 : "12/25/16, 4:57\(ts)AM"
        ]
        
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .short
        
        // ensure tests give consistent results by setting specific timeZone and locale
        f.timeZone = TimeZone(identifier: DEFAULT_TIMEZONE)
        f.locale = Locale(identifier: DEFAULT_LOCALE)
        
        for (timestamp, stringResult) in timestamps {
            
            let testDate = Date(timeIntervalSince1970: timestamp)
            let sf = f.string(from: testDate)
            
            XCTAssertEqual(sf, stringResult)
        }
        
        #endif // !SKIP
    }
    
    // MediumStyle
    // locale  stringFromDate        example
    // ------  --------------        ------------
    // en_US   MMM d, y, h:mm:ss a   Dec 25, 2015, 12:00:00 AM
    func test_dateStyleMedium() {
        let timestamps = [
            -31536000 : "Jan 1, 1969 at 12:00:00\(ts)AM" , 0.0 : "Jan 1, 1970 at 12:00:00\(ts)AM", 31536000 : "Jan 1, 1971 at 12:00:00\(ts)AM",
            2145916800 : "Jan 1, 2038 at 12:00:00\(ts)AM", 1456272000 : "Feb 24, 2016 at 12:00:00\(ts)AM", 1456358399 : "Feb 24, 2016 at 11:59:59\(ts)PM",
            1452574638 : "Jan 12, 2016 at 4:57:18\(ts)AM", 1455685038 : "Feb 17, 2016 at 4:57:18\(ts)AM", 1458622638 : "Mar 22, 2016 at 4:57:18\(ts)AM",
            1459745838 : "Apr 4, 2016 at 4:57:18\(ts)AM", 1462597038 : "May 7, 2016 at 4:57:18\(ts)AM", 1465534638 : "Jun 10, 2016 at 4:57:18\(ts)AM",
            1469854638 : "Jul 30, 2016 at 4:57:18\(ts)AM", 1470718638 : "Aug 9, 2016 at 4:57:18\(ts)AM", 1473915438 : "Sep 15, 2016 at 4:57:18\(ts)AM",
            1477285038 : "Oct 24, 2016 at 4:57:18\(ts)AM", 1478062638 : "Nov 2, 2016 at 4:57:18\(ts)AM", 1482641838 : "Dec 25, 2016 at 4:57:18\(ts)AM"
        ]
        
        let f = DateFormatter()

        #if SKIP
        throw XCTSkip("TODO")
        #else
        f.dateStyle = .medium
        f.timeStyle = .medium
        f.timeZone = TimeZone(identifier: DEFAULT_TIMEZONE)
        f.locale = Locale(identifier: DEFAULT_LOCALE)
        
        for (timestamp, stringResult) in timestamps {
            
            let testDate = Date(timeIntervalSince1970: timestamp)
            let sf = f.string(from: testDate)
            
            XCTAssertEqual(sf, stringResult)
        }
        
        #endif // !SKIP
    }
    
    
    // LongStyle
    // locale  stringFromDate                 example
    // ------  --------------                 -----------------
    // en_US   MMMM d, y 'at' h:mm:ss a zzz   December 25, 2015 at 12:00:00 AM GMT
    func test_dateStyleLong() {
        let timestamps = [
            -31536000 : "January 1, 1969 at 12:00:00\(ts)AM GMT" , 0.0 : "January 1, 1970 at 12:00:00\(ts)AM GMT", 31536000 : "January 1, 1971 at 12:00:00\(ts)AM GMT",
            2145916800 : "January 1, 2038 at 12:00:00\(ts)AM GMT", 1456272000 : "February 24, 2016 at 12:00:00\(ts)AM GMT", 1456358399 : "February 24, 2016 at 11:59:59\(ts)PM GMT",
            1452574638 : "January 12, 2016 at 4:57:18\(ts)AM GMT", 1455685038 : "February 17, 2016 at 4:57:18\(ts)AM GMT", 1458622638 : "March 22, 2016 at 4:57:18\(ts)AM GMT",
            1459745838 : "April 4, 2016 at 4:57:18\(ts)AM GMT", 1462597038 : "May 7, 2016 at 4:57:18\(ts)AM GMT", 1465534638 : "June 10, 2016 at 4:57:18\(ts)AM GMT",
            1469854638 : "July 30, 2016 at 4:57:18\(ts)AM GMT", 1470718638 : "August 9, 2016 at 4:57:18\(ts)AM GMT", 1473915438 : "September 15, 2016 at 4:57:18\(ts)AM GMT",
            1477285038 : "October 24, 2016 at 4:57:18\(ts)AM GMT", 1478062638 : "November 2, 2016 at 4:57:18\(ts)AM GMT", 1482641838 : "December 25, 2016 at 4:57:18\(ts)AM GMT"
        ]
        
        let f = DateFormatter()
        #if SKIP
        throw XCTSkip("TODO")
        #else

        f.dateStyle = .long
        f.timeStyle = .long
        f.timeZone = TimeZone(identifier: DEFAULT_TIMEZONE)
        f.locale = Locale(identifier: DEFAULT_LOCALE)
        
        for (timestamp, stringResult) in timestamps {
            
            let testDate = Date(timeIntervalSince1970: timestamp)
            let sf = f.string(from: testDate)
            
            XCTAssertEqual(sf, stringResult)
        }
        
        #endif // !SKIP
    }
    
    // FullStyle
    // locale  stringFromDate                       example
    // ------  --------------                       -------------------------
    // en_US   EEEE, MMMM d, y 'at' h:mm:ss a zzzz  Friday, December 25, 2015 at 12:00:00 AM Greenwich Mean Time
    func test_dateStyleFull() {
        #if SKIP
        throw XCTSkip("TODO")
        #else

#if os(macOS) // timestyle .full is currently broken on Linux, the timezone should be 'Greenwich Mean Time' not 'GMT'
        let timestamps: [TimeInterval:String] = [
            // Negative time offsets are still buggy on macOS
            -31536000 : "Wednesday, January 1, 1969 at 12:00:00\(ts)AM GMT", 0.0 : "Thursday, January 1, 1970 at 12:00:00\(ts)AM Greenwich Mean Time",
            31536000 : "Friday, January 1, 1971 at 12:00:00\(ts)AM Greenwich Mean Time", 2145916800 : "Friday, January 1, 2038 at 12:00:00\(ts)AM Greenwich Mean Time",
            1456272000 : "Wednesday, February 24, 2016 at 12:00:00\(ts)AM Greenwich Mean Time", 1456358399 : "Wednesday, February 24, 2016 at 11:59:59\(ts)PM Greenwich Mean Time",
            1452574638 : "Tuesday, January 12, 2016 at 4:57:18\(ts)AM Greenwich Mean Time", 1455685038 : "Wednesday, February 17, 2016 at 4:57:18\(ts)AM Greenwich Mean Time",
            1458622638 : "Tuesday, March 22, 2016 at 4:57:18\(ts)AM Greenwich Mean Time", 1459745838 : "Monday, April 4, 2016 at 4:57:18\(ts)AM Greenwich Mean Time",
            1462597038 : "Saturday, May 7, 2016 at 4:57:18\(ts)AM Greenwich Mean Time", 1465534638 : "Friday, June 10, 2016 at 4:57:18\(ts)AM Greenwich Mean Time",
            1469854638 : "Saturday, July 30, 2016 at 4:57:18\(ts)AM Greenwich Mean Time", 1470718638 : "Tuesday, August 9, 2016 at 4:57:18\(ts)AM Greenwich Mean Time",
            1473915438 : "Thursday, September 15, 2016 at 4:57:18\(ts)AM Greenwich Mean Time", 1477285038 : "Monday, October 24, 2016 at 4:57:18\(ts)AM Greenwich Mean Time",
            1478062638 : "Wednesday, November 2, 2016 at 4:57:18\(ts)AM Greenwich Mean Time", 1482641838 : "Sunday, December 25, 2016 at 4:57:18\(ts)AM Greenwich Mean Time"
        ]
        
        let f = DateFormatter()
        f.dateStyle = .full
        f.timeStyle = .full
        f.timeZone = TimeZone(identifier: DEFAULT_TIMEZONE)
        f.locale = Locale(identifier: DEFAULT_LOCALE)
        
        for (timestamp, stringResult) in timestamps {
            
            let testDate = Date(timeIntervalSince1970: timestamp)
            let sf = f.string(from: testDate)

            XCTAssertEqual(sf, stringResult)
        }
#endif
        #endif // !SKIP
    }
    
    // Custom Style
    // locale  stringFromDate                        example
    // ------  --------------                        -------------------------
    // en_US   EEEE, MMMM d, y 'at' hh:mm:ss a zzzz  Friday, December 25, 2015 at 12:00:00 AM Greenwich Mean Time
    func test_customDateFormat() {
        let timestamps = [
             // Negative time offsets are still buggy on macOS
             //-31536000.0 : "Wednesday, January 1, 1969 at 12:00:00 AM GMT",
             0.0 : "Thursday, January 1, 1970 at 12:00:00 AM Greenwich Mean Time",
             31536000.0 : "Friday, January 1, 1971 at 12:00:00 AM Greenwich Mean Time",
             2145916800.0 : "Friday, January 1, 2038 at 12:00:00 AM Greenwich Mean Time",
             1456272000.0 : "Wednesday, February 24, 2016 at 12:00:00 AM Greenwich Mean Time",
             1456358399.0 : "Wednesday, February 24, 2016 at 11:59:59 PM Greenwich Mean Time",
             1452574638.0 : "Tuesday, January 12, 2016 at 04:57:18 AM Greenwich Mean Time",
             1455685038.0 : "Wednesday, February 17, 2016 at 04:57:18 AM Greenwich Mean Time",
             1458622638.0 : "Tuesday, March 22, 2016 at 04:57:18 AM Greenwich Mean Time",
             1459745838.0 : "Monday, April 4, 2016 at 04:57:18 AM Greenwich Mean Time",
             1462597038.0 : "Saturday, May 7, 2016 at 04:57:18 AM Greenwich Mean Time",
             1465534638.0 : "Friday, June 10, 2016 at 04:57:18 AM Greenwich Mean Time",
             1469854638.0 : "Saturday, July 30, 2016 at 04:57:18 AM Greenwich Mean Time",
             1470718638.0 : "Tuesday, August 9, 2016 at 04:57:18 AM Greenwich Mean Time",
             1473915438.0 : "Thursday, September 15, 2016 at 04:57:18 AM Greenwich Mean Time",
             1477285038.0 : "Monday, October 24, 2016 at 04:57:18 AM Greenwich Mean Time",
             1478062638.0 : "Wednesday, November 2, 2016 at 04:57:18 AM Greenwich Mean Time",
             1482641838.0 : "Sunday, December 25, 2016 at 04:57:18 AM Greenwich Mean Time",
        ]
        
        let f = DateFormatter()
        f.timeZone = TimeZone(identifier: DEFAULT_TIMEZONE)
        f.locale = Locale(identifier: DEFAULT_LOCALE)

        f.dateFormat = "EEEE, MMMM d, y 'at' hh:mm:ss a zzzz"
        for (timestamp, stringResult) in timestamps {
            
            let testDate = Date(timeIntervalSince1970: timestamp)
            let sf = f.string(from: testDate)
            
            XCTAssertEqual(sf, stringResult)
        }

        // Check .dateFormat resets when style changes
        let testDate = Date(timeIntervalSince1970: 1457738454)

        // Fails on High Sierra
        //f.dateStyle = .medium
        //f.timeStyle = .medium
        //XCTAssertEqual(f.string(from: testDate), "Mar 11, 2016, 11:20:54 PM")
        //XCTAssertEqual(f.dateFormat, "MMM d, y, h:mm:ss a")

        f.dateFormat = "dd-MM-yyyy"
        XCTAssertEqual(f.string(from: testDate), "11-03-2016")

        #if SKIP
        throw XCTSkip("Skip: no support for DateFormatter.Quarter")
        #endif

        let quarterTimestamps: [Double : String] = [
            1451679712.0 : "1", 1459542112.0 : "2", 1467404512.0 : "3", 1475353312.0 : "4"
        ]

        f.dateFormat = "Q"
        
        for (timestamp, stringResult) in quarterTimestamps {
            let testDate = Date(timeIntervalSince1970: timestamp)
            let sf = f.string(from: testDate)
            
            XCTAssertEqual(sf, stringResult)
        }
    }

    func test_setLocalizedDateFormatFromTemplate() {
        let locale = Locale(identifier: DEFAULT_LOCALE)
        let template = "EEEE MMMM d y hhmmss a zzzz"

        let f = DateFormatter()
        f.locale = locale
        f.setLocalizedDateFormatFromTemplate(template)

        let dateFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale)
        XCTAssertEqual(f.dateFormat, dateFormat)
    }

    func test_dateFormatString() {
        let f = DateFormatter()
        f.locale = Locale(identifier: DEFAULT_LOCALE)

        #if SKIP
        throw XCTSkip("TODO")
        #else
        f.timeZone = TimeZone(abbreviation: DEFAULT_TIMEZONE)
        // .medium cases fail for the date part on Linux and so have been commented out.
        let formats: [String: (DateFormatter.Style, DateFormatter.Style)] = [
            "": (.none, .none),
            "h:mm\(ts)a": (.none, .short),
            "h:mm:ss\(ts)a": (.none, .medium),
            "h:mm:ss\(ts)a z": (.none, .long),
            "h:mm:ss\(ts)a zzzz": (.none, .full),
            "M/d/yy": (.short, .none),
            "M/d/yy, h:mm\(ts)a": (.short, .short),
            "M/d/yy, h:mm:ss\(ts)a": (.short, .medium),
            "M/d/yy, h:mm:ss\(ts)a z": (.short, .long),
            "M/d/yy, h:mm:ss\(ts)a zzzz": (.short, .full),
            "MMM d, y": (.medium, .none),
            //"MMM d, y 'at' h:mm\(ts)a": (.medium, .short),
            //"MMM d, y 'at' h:mm:ss\(ts)a": (.medium, .medium),
            //"MMM d, y 'at' h:mm:ss\(ts)a z": (.medium, .long),
            //"MMM d, y 'at' h:mm:ss\(ts)a zzzz": (.medium, .full),
            "MMMM d, y": (.long, .none),
            "MMMM d, y 'at' h:mm\(ts)a": (.long, .short),
            "MMMM d, y 'at' h:mm:ss\(ts)a": (.long, .medium),
            "MMMM d, y 'at' h:mm:ss\(ts)a z": (.long, .long),
            "MMMM d, y 'at' h:mm:ss\(ts)a zzzz": (.long, .full),
            "EEEE, MMMM d, y": (.full, .none),
            "EEEE, MMMM d, y 'at' h:mm\(ts)a": (.full, .short),
            "EEEE, MMMM d, y 'at' h:mm:ss\(ts)a": (.full, .medium),
            "EEEE, MMMM d, y 'at' h:mm:ss\(ts)a z": (.full, .long),
            "EEEE, MMMM d, y 'at' h:mm:ss\(ts)a zzzz": (.full, .full),
        ]
        
        for (dateFormat, styles) in formats {
            f.dateStyle = styles.0
            f.timeStyle = styles.1
            
            XCTAssertEqual(f.dateFormat, dateFormat)
        }
        #endif // !SKIP
    }

    func test_setLocaleToNil() {
        let f = DateFormatter()
        // Locale should be the current one by default
        XCTAssertEqual(f.locale, Locale.current)

        f.locale = nil

        // Locale should go back to current.
        XCTAssertEqual(f.locale, Locale.current)

        // A nil locale should not crash a subsequent operation
        let result: String? = f.string(from: Date())
        XCTAssertNotNil(result)
    }

    func test_setTimeZoneToNil() {
        let f = DateFormatter()
        // Time zone should be the system one by default.
        XCTAssertEqual(f.timeZone, NSTimeZone.system)
        f.timeZone = nil
        // Time zone should go back to the system one.
        XCTAssertEqual(f.timeZone, NSTimeZone.system)
    }

    func test_setTimeZone() {
        // Test two different time zones. Should ensure that if one
        // happens to be TimeZone.current, we still get a valid test.
        let newYork = TimeZone(identifier: "America/New_York")!
        let losAngeles = TimeZone(identifier: "America/Los_Angeles")!

        XCTAssertNotEqual(newYork, losAngeles)

        // Case 1: New York
        let f = DateFormatter()
        f.timeZone = newYork
        XCTAssertEqual(f.timeZone, newYork)

        // Case 2: Los Angeles
        f.timeZone = losAngeles
        XCTAssertEqual(f.timeZone, losAngeles)
    }

    func test_expectedTimeZone() throws {
        let newYork = TimeZone(identifier: "America/New_York")!
        let losAngeles = TimeZone(identifier: "America/Los_Angeles")!

        XCTAssertNotEqual(newYork, losAngeles)
 
        let now = Date()

        let f = DateFormatter()
        f.dateFormat = "z"
        f.locale = Locale(identifier: "en_US_POSIX")

        // Case 1: TimeZone.current
        // This case can catch some issues that cause TimeZone.current to be
        // treated like GMT, but it doesn't work if TimeZone.current is GMT.
        // If you do find an issue like this caused by this first case,
        // it would benefit from a more specific test that fails when
        // TimeZone.current is GMT as well.
        // (ex. TestTimeZone.test_systemTimeZoneName)

        #if SKIP
        throw XCTSkip("TODO: fix DST and TZ abbreviation")
        //try failOnAndroid() // java.lang.AssertionError: GMT != GMT+00:00
        #endif

        f.timeZone = TimeZone.current
        XCTAssertEqual(f.string(from: now), TimeZone.current.abbreviation())

        // Case 2: New York
        f.timeZone = newYork
        XCTAssertEqual(f.string(from: now), newYork.abbreviation())

        // Case 3: Los Angeles
        f.timeZone = losAngeles
        XCTAssertEqual(f.string(from: now), losAngeles.abbreviation())
    }

    func test_dateFrom() throws {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd"

        #if !SKIP // SimpleDateFormatter is lenient by default
        XCTAssertNil(formatter.date(from: "2018-03-09T10:25:16+01:00"))
        #endif
        let d1 = try XCTUnwrap(formatter.date(from: "2018-03-09"))
        XCTAssertEqual(d1.description, "2018-03-09 00:00:00 +0000")

        // DateFormatter should allow any kind of whitespace before and after parsed content
        #if SKIP
        let whitespaces = " \t" // SKIP WARN: no support for unicode literals
        #else
        let whitespaces = " \t\u{00a0}\u{1680}\u{2000}\u{2001}\u{2002}\u{2003}\u{2004}\u{2005}\u{2006}\u{2007}\u{2008}\u{2009}\u{200a}\u{202f}\u{205f}\u{3000}"
        #endif
        let d1Prefix = try XCTUnwrap(formatter.date(from: "\(whitespaces)2018-03-09"))
        XCTAssertEqual(d1.description, d1Prefix.description)
        let d1PrefixSuffix = try XCTUnwrap(formatter.date(from: "\(whitespaces)2018-03-09\(whitespaces)"))
        XCTAssertEqual(d1.description, d1PrefixSuffix.description)
        let d1Suffix = try XCTUnwrap(formatter.date(from: "2018-03-09\(whitespaces)"))
        XCTAssertEqual(d1.description, d1Suffix.description)
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        XCTAssertNil(formatter.date(from: "2018-03-09"))
        #if SKIP
        throw XCTSkip("Skip: differences in date format string") // the below date does not parse
        #endif
        let d2 = try XCTUnwrap(formatter.date(from: "2018-03-09T10:25:16+01:00"))
        XCTAssertEqual(d2.description, "2018-03-09 09:25:16 +0000")
    }
    
    func test_dateParseAndFormatWithJapaneseCalendar() throws {
        #if SKIP
        throw XCTSkip("Skip: no support for JapeneseCalendar")
        #else
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.calendar = Calendar(identifier: .japanese)
        formatter.dateFormat = "Gy年M月d日 HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "JST")
        
        do {
            // Parse test
            #if os(macOS) // fails on iOS for unknown reasons
            let parsed = formatter.date(from: "平成31年4月30日 23:10")
            XCTAssertEqual(parsed?.timeIntervalSince1970, 1556633400) // April 30, 2019, 11:10 PM (JST)
            #endif

            // Format test
            let dateString = formatter.string(from: Date(timeIntervalSince1970: 1556633400)) // April 30, 2019, 11:10 PM (JST)
            XCTAssertEqual(dateString, "平成31年4月30日 23:10")
        }
        
        // Test for new Japanese era (starting from May 1, 2019)
        do {
            // Parse test
            let parsed = formatter.date(from: "令和1年5月1日 23:10")
            XCTAssertEqual(parsed?.timeIntervalSince1970, 1556719800) // May 1st, 2019, 11:10 PM (JST)
            
            // Test for 元年(Gannen) representation of 1st year
            let parsedAlt = formatter.date(from: "令和元年5月1日 23:10")
            XCTAssertEqual(parsedAlt?.timeIntervalSince1970, 1556719800) // May 1st, 2019, 11:10 PM (JST)

            // Format test
            let dateString = formatter.string(from: Date(timeIntervalSince1970: 1556719800)) // May 1st, 2019, 11:10 PM (JST)
            XCTAssertEqual(dateString, "令和元年5月1日 23:10")
        }
        #endif // !SKIP
    }

    func test_orderOfPropertySetters() throws {
        #if SKIP
        throw XCTSkip("TODO")
        #else

        // This produces a .count factorial number of arrays
        func combinations<T>(of a: [T]) -> [[T]] {
            precondition(!a.isEmpty)
            if a.count == 1 { return [a] }
            if a.count == 2 { return [ [a[0], a[1]], [ a[1], a[0]] ] }

            var result: [[T]] = []

            for idx in a.startIndex..<a.endIndex {
                let x = a[idx]
                var b: [T] = a
                b.remove(at: idx)

                for var c in combinations(of: b) {
                    c.append(x)
                    result.append(c)
                }
            }
            return result
        }

        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "CET")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = try XCTUnwrap(formatter.date(from: "2019-05-05T12:52:10"))

        let applySettings: [(String, (DateFormatter) -> Void)] =
            [(".timeZone", {
                $0.timeZone = TimeZone(identifier: "Europe/Oslo")
            }),
             (".calendar", {
                $0.calendar = Calendar(identifier: .gregorian)
             }),
             (".locale", {
                $0.locale = Locale(identifier: "nb")
             }),
             (".dateStyle", {
                $0.dateStyle = .medium
             }),
             (".timeStyle", {
                $0.timeStyle = .medium
             })
        ]

        // Test all of the combinations of setting the properties produces the same output
        let expected = "5. mai 2019, 12:52:10"
        for settings in combinations(of: applySettings) {
            let f = DateFormatter()
            settings.forEach { $0.1(f) }
            XCTAssertEqual(f.dateFormat, "d. MMM y, HH:mm:ss")
            let formattedString = f.string(from: date)
            if formattedString != expected {
                let applied = settings.map { $0.0 }.joined(separator: ",")
                XCTFail("\(formattedString) != \(expected) using settings applied in order \(applied)")
            }
        }
        #endif // !SKIP
    }

    // Confirm that https://bugs.swift.org/browse/SR-14108 is fixed.
    func test_copy_sr14108() throws {
        let date = Date(timeIntervalSinceReferenceDate: 0)

        let original = DateFormatter()
        original.timeZone = TimeZone(identifier: DEFAULT_TIMEZONE)
        original.locale = Locale(identifier: DEFAULT_LOCALE)
        original.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        XCTAssertEqual(original.string(from: date), "2001-01-01 00:00:00 GMT")

        #if SKIP
        throw XCTSkip("TODO")
        #else
        let copied = try XCTUnwrap(original.copy() as? DateFormatter)
        XCTAssertEqual(original.timeZone, copied.timeZone)
        XCTAssertEqual(original.locale, copied.locale)
        XCTAssertEqual(copied.string(from: date), "2001-01-01 00:00:00 GMT")

        copied.timeZone = TimeZone(abbreviation: "JST")
        copied.locale = Locale(identifier: "ja_JP")
        copied.dateFormat = "yyyy/MM/dd hh:mm:ssxxxxx"

        XCTAssertNotEqual(original.timeZone, copied.timeZone)
        XCTAssertNotEqual(original.locale, copied.locale)
        XCTAssertEqual(original.string(from: date), "2001-01-01 00:00:00 GMT")
        XCTAssertEqual(copied.string(from: date), "2001/01/01 09:00:00+09:00")
        #endif // !SKIP
    }
}


