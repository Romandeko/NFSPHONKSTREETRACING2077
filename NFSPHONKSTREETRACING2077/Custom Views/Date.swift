//
//  Data.swift
//  NFSPHONKSTREETRACING2077
//
//  Created by Роман Денисенко on 11.11.22.
//

import Foundation
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
