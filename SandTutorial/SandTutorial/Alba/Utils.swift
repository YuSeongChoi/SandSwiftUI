//
//  Util.swift
//
//  Created by Yeongseong Seo on 2016. 8. 12..
//  Copyright © 2016년 dqnetworks. All rights reserved.
//

import UIKit

extension Date {

    func addWeek(n: Int) -> Date {
        let cal = Calendar.current
        return cal.date(byAdding: .weekOfMonth, value: n, to: self)!
    }
    
    func addYear(n: Int) -> Date {
        Calendar.current.date(byAdding: .year, value: n, to: self)!
    }
    
    func addMonth(n: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .month, value: n, to: self)!
    }
    
    func addDay(n: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .day, value: n, to: self)!
    }
    
    func string(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .KOR
        dateFormatter.calendar = .init(identifier: .gregorian)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func date(_ target:String, format:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .KOR
        dateFormatter.calendar = .init(identifier: .gregorian)
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: target)
    }
    
}

class Util {

    public static func decimalStyleString(num:Int) -> String? {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        return fmt.string(from: NSNumber(value: num))
    }

}
