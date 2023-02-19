//
//  Warranty+CoreDataProperties.swift
//  Save It Right
//
//  Created by Shouq Turki Bin Tuwaym on 12/02/2023.
//
//

import Foundation
import CoreData


extension Warranty {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Warranty> {
        return NSFetchRequest<Warranty>(entityName: "Warranty")
    }

    @NSManaged public var category: String?
    @NSManaged public var companyName: String
    @NSManaged public var deviceName: String
    @NSManaged public var durationDays: Int32
    @NSManaged public var durationMonths: Int32
    @NSManaged public var durationYears: Int32
    @NSManaged public var note: String?
    @NSManaged public var photo: Data?
    @NSManaged public var remainderBeforeDays: Int32
    @NSManaged public var shopName: String?
    @NSManaged public var startDate: Date

}

extension Warranty : Identifiable {

}
