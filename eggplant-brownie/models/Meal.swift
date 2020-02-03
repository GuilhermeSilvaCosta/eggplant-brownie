//
//  Meal.swift
//  eggplant-brownie
//
//  Created by Guilherme Costa on 31/12/19.
//  Copyright © 2019 Guilherme Costa. All rights reserved.
//

class Meal {
    let name:String
    let happiness:Int
    var items = Array<Item>()
    
    init(name: String, happiness: Int) {
        self.name = name
        self.happiness = happiness
    }

    func allCalories() -> Double { print("calculating")
    var total = 0.0
    for i in items {
    total += i.calories }
        return total
    }
    
    func details() -> String {
        var message = "Happiness: \(self.happiness)"
        
        for item in self.items {
            message += "\n * \(item.name) - calories: \(item.calories)"
        }
        
        return message
    }
    
}


