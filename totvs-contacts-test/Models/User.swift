//
//  User.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 30/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import RealmSwift
import ObjectMapper
import Foundation

class User: Object,Mappable {
	dynamic var homePage: String?
	var address = List<Address>()
	dynamic var imageUrl: String?
	var emails = List<Email>()
	var phone = List<Phone>()
	dynamic var companyDetails: CompanyDetails?
	dynamic var age: Int = 0
	dynamic var position: String?
	dynamic var name: String?

	// MARK: Mappable

	required convenience init?(_ map: Map) {
		self.init()
	}

	func mapping(map: Map) {
		homePage <- map["homePage"]
		address <- (map["address"], ArrayTransform<Address>())
		imageUrl <- map["imageUrl"]
		emails <- (map["emails"], ArrayTransform<Email>())
		phone <- (map["phone"], ArrayTransform<Phone>())
		companyDetails <- map["companyDetails"]
		age <- map["age"]
		position <- map["position"]
		name <- map["name"]
	}
}

class Address: Object,Mappable {
    dynamic var city: String?
    dynamic var address3: String?
    dynamic var country: String?
    dynamic var address1: String?
    dynamic var address2: String?
    dynamic var zipcode: Int = 0
    dynamic var state: String?
    
    // MARK: Mappable
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        city <- map["city"]
        address3 <- map["address3"]
        country <- map["country"]
        address1 <- map["address1"]
        address2 <- map["address2"]
        zipcode <- map["zipcode"]
        state <- map["state"]
    }
}

class CompanyDetails: Object,Mappable {
    dynamic var location: String?
    dynamic var name: String?
    
    // MARK: Mappable
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        location <- map["location"]
        name <- map["name"]
    }
}

class Email: Object,Mappable {
    dynamic var email: String?
    dynamic var label: String?
    
    // MARK: Mappable
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        email <- map["email"]
        label <- map["label"]
    }
}

class Phone: Object,Mappable {
    dynamic var number: String?
    dynamic var type: String?    
    
    // MARK: Mappable
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        number <- map["number"]
        type <- map["type"]
    }
}