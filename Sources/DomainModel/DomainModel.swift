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
        
        
        if (currency != "USD" && currency != "CAN" && currency != "GBP" && currency != "EUR"  ) {
            self.currency = ""
        } else {
            self.currency = currency
        }
        

    }
    
    func add (_ mon: Money) -> Money {
        
        var convertedMon = Money(amount: amount, currency: currency)
        
        if mon.currency != currency {
            convertedMon = self.convert("\(mon.currency)")
        }
        

        
        return Money(amount: convertedMon.amount + mon.amount, currency: mon.currency)
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
                return Money(amount: amount/2, currency: "GBP")
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
            } else if cur == "GBP" {
                return Money(amount: Int(amountUSD)/2, currency: "GBP")
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
            } else if cur == "GBP" {
                return Money(amount: Int(amountUSD)/2, currency: "GBP")
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
    
    public var title: String
    public var job: JobType
    
    init(title: String, type: JobType) {
        self.title = title
        self.job = type
    }
    
    func calculateIncome(_ value:Int) -> Int {
        switch self.job {
        case .Hourly(let rate):
            let total = rate * Double(value)
            return Int(total)
        case .Salary (let salary):
            return Int(salary)
        }
    }
    
    
    func raise (byAmount: Double){
        switch self.job {
        case .Hourly(let rate):
            self.job = .Hourly(rate + byAmount)
        case .Salary(let rate):
            self.job = .Salary(UInt(Int(Double(rate) + byAmount)))
        }
    }
    
    func raise (byPercent: Double){
        switch self.job {
        case .Hourly(let rate):
            self.job = .Hourly(rate + (rate * byPercent))
        case .Salary(let rate):
            self.job = .Salary(rate + UInt(Int(Double(rate) * byPercent)))
        }
        
    }
    

}

////////////////////////////////////
// Person
//
public class Person {
    var firstName: String?
    var lastName: String?
    var age: Int
    private var job1: Job?
    
    var job:Job? {
        get {
            return job1
        }
        set (value) {
            if self.age < 18 {
                return
            } else {
                self.job1 = value
            }
        }
    }
    
    private var spouse1: Person?
    
    var spouse:Person? {
        get {
            return spouse1
        }
        set (value){
            if self.age < 21 {
                return
            } else {
                self.spouse1 = value
            }
        }
    }
    
    
    init(firstName: String? = nil, lastName: String? = nil, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    //change job part and nil part
    func toString() -> String {
                
        return "[Person: firstName:\(firstName ??  "nil") lastName:\(lastName ?? "nil") age:\(age) job:\(job?.title ?? "nil") spouse:\(spouse?.firstName ?? "nil")]"
        
        
    }
    
    
}

////////////////////////////////////
// Family
//
public class Family {
    var members: [Person]
    
    init(spouse1: Person, spouse2: Person){
        if (spouse1.spouse == nil && spouse2.spouse == nil) {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            self.members = [spouse1, spouse2]
        } else {
            self.members = []
        }
    }
    
    func haveChild(_ child: Person) -> Bool {
        if (self.members[0].age >= 21 || self.members[1].age >= 21) {
            self.members.append(child)
            return true
        }
        return false
    }
    
    func householdIncome() -> Int {
        var totalIncome: Int = 0
        
        for member in self.members {
            totalIncome += (member.job?.calculateIncome(2000)) ?? 0
        }
        
        return totalIncome
    }
}
