struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    var amount: Int
    var currency: String
    
    //create code that checks the currency (only specific types accepted)
    
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
        
        if (currency != "USD" || currency != "CAN" || currency != "GBP" || currency != "EUR"  ) {
            print("Unknown currency")
        }
    }
    
    func add (_ mon: Money) -> Money {
        
        var convertedMon = Money(amount: 0, currency: currency)
        
        if mon.currency != currency {
            convertedMon = mon.convert("\(currency)")
        }
        
        return Money(amount: convertedMon.amount + amount, currency: currency)
    }
    
    func subtract (_ mon: Money) -> Money {
        
        var convertedMon = Money(amount: 0, currency: currency)
        
        if mon.currency != currency {
            convertedMon = mon.convert("\(currency)")
        }
        
        return Money(amount: amount - convertedMon.amount, currency: currency)
    }
    

    
    
    func convert(_ cur: String) -> Money {
        if currency == "USD"{
            if cur == "GBP"{
                return Money(amount: amount/2, currency: "GDP")
            } else if cur == "CAN" {
                let amount1 = amount
                var amount2 = Double(amount1) * 1.25
                amount2.round(.toNearestOrAwayFromZero)
                return Money(amount: Int(amount2), currency: "CAN")
            } else {
                let amount1 = amount
                var amount2 = Double(amount1) * 1.5
                amount2.round(.toNearestOrAwayFromZero)
                return Money(amount: Int(amount2), currency: "EUR")
            }
            
        } else if currency == "GBP" {
            let amountUSD = amount * 2
            
            if cur == "USD" {
                return Money(amount: amountUSD, currency: "USD")
            } else if cur == "CAN" {
                var amount2 = Double(amountUSD) * 1.25
                amount2.round(.toNearestOrAwayFromZero)
                return Money(amount: Int(amount2), currency: "CAN")
            } else {
                var amount2 = Double(amountUSD) * 1.5
                amount2.round(.toNearestOrAwayFromZero)
                return Money(amount: Int(amount2), currency: "EUR")
            }
            
        } else if currency == "CAN" {
            let amount1 = amount
            let amountUSD = Double(amount1) / 1.25
            
            if cur == "USD" {
                return Money(amount: Int(amountUSD), currency: "USD")
            } else if cur == "GDP" {
                return Money(amount: Int(amountUSD)/2, currency: "GDP")
            } else {
                var amount2 = Double(amountUSD) * 1.5
                amount2.round(.toNearestOrAwayFromZero)
                return Money(amount: Int(amount2), currency: "EUR")
            }
            
        } else if currency == "EUR" {
            let amount1 = amount
            let amountUSD = Double(amount1) / 1.5
            
            if cur == "USD" {
                return Money(amount: Int(amountUSD), currency: "USD")
            } else if cur == "GDP" {
                return Money(amount: Int(amountUSD)/2, currency: "GDP")
            } else {
                var amount2 = Double(amountUSD) / 1.25
                amount2.round(.toNearestOrAwayFromZero)
                return Money(amount: Int(amount2), currency: "EUR")
            }
            
        } else {
            return Money(amount: 0, currency: "USD")
        }
        
    }
}

////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}
