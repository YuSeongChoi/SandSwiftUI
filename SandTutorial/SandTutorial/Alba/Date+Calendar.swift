//
//  Date+Calendar.swift
//  HowMuch
//
//  Created by pbk on 2021/12/16.
//

import Foundation

extension Date {
    
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    public var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    public var monthString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter.string(from: self)
    }
    
    var ISOcriterionThursday:Date {
        let cal = Calendar.iso
        return cal.date(bySetting: .weekday, value: 5, of: isoWeek.start)!
    }
    
    var GregCriterionWednesday:Date {
        let cal = Calendar.greg
        return cal.date(bySetting: .weekday, value: 4, of: gregWeek.start)!
    }
    
    var ISOweekCount:Int {
        return Calendar.iso.component(.weekOfMonth, from: ISOcriterionThursday)
    }
    
    var GregWeekCount:Int {
        return Calendar.greg.component(.weekOfMonth, from: GregCriterionWednesday)
    }
    
    var dayInterval:DateInterval {
        let cal = Calendar.iso
        var interval = cal.dateInterval(of: .day, for: self)!
        interval.duration -= 1
        return interval
    }
    
    var isoWeek:DateInterval {
        let cal = Calendar.iso
        var interval = cal.dateInterval(of: .weekOfMonth, for: self)!
        interval.duration -= 1
        return interval
    }
    
    var gregWeek:DateInterval {
        let cal = Calendar.greg
        var interval = cal.dateInterval(of: .weekOfMonth, for: self)!
        interval.duration -= 1
        return interval
    }
    
    var monthInterval:DateInterval {
        let cal = Calendar.iso
        var interval = cal.dateInterval(of: .month, for: self)!
        interval.duration -= 1
        return interval
    }
    
    var yearInterval:DateInterval {
        let cal = Calendar.iso
        var interval = cal.dateInterval(of: .year, for: self)!
        interval.duration -= 1
        return interval
    }
    
    var FirstHalf:DateInterval {
        let year = yearInterval
        let duration = (year.duration / 2).rounded()
        let _end = year.start.addingTimeInterval(duration)
        let end = _end.monthInterval.start.addingTimeInterval(-1)
        return .init(start: year.start, end: end)
    }
    
    var LastHalf:DateInterval {
        let year = yearInterval
        let duration = (year.duration / 2).rounded()
        let _start = year.end.addingTimeInterval(-duration)
        let start = _start.monthInterval.start
        return .init(start: start, end: year.end)
    }
}

extension Date {
    var startOfDay: Date {
        return Calendar.iso.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var startOfMonth: Date {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }

    var startOfYear: Date {
        let cal = Calendar.iso
        var comp = cal.dateComponents([.year], from: self)
        comp.calendar = cal
        comp.month = 1
        comp.day = 1
        return cal.startOfDay(for: comp.date!)
    }

    var startOfWeek: Date
    {
        let date = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        let dslTimeOffset = NSTimeZone.local.daylightSavingTimeOffset(for: date)
        return date.addingTimeInterval(dslTimeOffset)
    }
    
    var endOfWeek: Date
    {
        return Calendar.current.date(byAdding: .second, value: 604799, to: self.startOfWeek)!
    }
}

extension Calendar {
    static var iso:Self {
        var cal = Calendar(identifier: .iso8601)
        cal.locale = .current
        cal.timeZone = .current
        return cal
    }
    static var greg:Self {
        var cal = Calendar(identifier: .gregorian)
        cal.locale = .current
        cal.timeZone = .current
        return cal
    }
}

extension Locale {
    /// Locale for Korea
    static var KOR:Locale {
        .init(identifier: "ko-Kore_KR")
    }
}
