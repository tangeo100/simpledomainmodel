//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String

  public func convert(_ to: String) -> Money {
    var fromUS : [String: Double] = ["GBP": 1/2, "EUR": 1.5, "CAN": 1.25]
    if currency == "USD" {
        return Money(amount: Int(Double(amount) * fromUS[to]!), currency: to)
    } else if to == "USD"{
        return Money(amount: Int(Double(amount) / fromUS[currency]!), currency: to)
    } else {
        return convert("USD").convert(to)
    }
  }

  public func add(_ to: Money) -> Money {
    if(to.currency == currency){
        return Money(amount: amount + to.amount, currency: to.currency)
    }
    if currency == "USD" {
        let muns : Money = convert(to.currency)
        return Money(amount: muns.amount + to.amount, currency: to.currency)
    } else {
        let muns: Money = convert("USD").convert(to.currency)
        return Money(amount: muns.amount + to.amount, currency: to.currency)
    }
  }
    
  public func subtract(_ from: Money) -> Money {
    if(from.currency == currency){
        return Money(amount: from.amount - amount, currency: from.currency)
    }
    if currency == "USD" {
        let muns : Money = convert(from.currency)
        return Money(amount: from.amount - muns.amount, currency: from.currency)
    } else {
        let muns: Money = convert("USD").convert(from.currency)
        return Money(amount: from.amount - muns.amount, currency: from.currency)
    }
  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }

  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }

  open func calculateIncome(_ hours: Int) -> Int {
    switch type {
    case .Salary(let muns):
        return muns
    case .Hourly(let muns):
        return Int(muns * Double(hours))
    default:
        return 0
    }
  }

  open func raise(_ amt : Double) {
    switch type {
    case .Salary(let muns):
        self.type = Job.JobType.Salary(Int(Double(muns)  + amt))
    case .Hourly(let muns):
        self.type = Job.JobType.Hourly(muns  + amt)
    default:
        print("nothing happened")
    }
  }
}

////////////////////////////////////
// Person
//
//open class Person {
//  open var firstName : String = ""
//  open var lastName : String = ""
//  open var age : Int = 0
//
//  fileprivate var _job : Job? = nil
//  open var job : Job? {
//    get { }
//    set(value) {
//    }
//  }
//
//  fileprivate var _spouse : Person? = nil
//  open var spouse : Person? {
//    get { }
//    set(value) {
//    }
//  }
//
//  public init(firstName : String, lastName: String, age : Int) {
//    self.firstName = firstName
//    self.lastName = lastName
//    self.age = age
//  }
//
//  open func toString() -> String {
//  }
//}

////////////////////////////////////
// Family
//
//open class Family {
//  fileprivate var members : [Person] = []
//  
//  public init(spouse1: Person, spouse2: Person) {
//  }
//  
//  open func haveChild(_ child: Person) -> Bool {
//  }
//  
//  open func householdIncome() -> Int {
//  }
//}





