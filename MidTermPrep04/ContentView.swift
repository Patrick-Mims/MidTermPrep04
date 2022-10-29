//
//  ContentView.swift
//  MidTermPrep04
//
//  Created by JPL-ST-SPRING2022 on 10/28/22.
//

import SwiftUI

struct Menu {
    var dish: String
    var img: String
    var price: Double
}

struct Order {
    var dish: Menu
    var unit: Int
}

struct ContentView: View {
    @State private var index = 0
    @State private var unitStr = "1"
    @State private var totalAmt = 0.0
    @State private var receipt = "Total Payment: $0.0"
    @State private var orders: [Order] = []
    
    private let menu = [
        Menu(dish: "Hamburger", img: "Hamburger", price: 1.99),
        Menu(dish: "Sushi", img: "Sushi", price: 2.99),
        Menu(dish: "Pizza", img: "Pizza", price: 3.99),
        Menu(dish: "Crepes", img: "Crepes", price: 4.99),
        Menu(dish: "Fries", img: "Fries", price: 5.99)
    ]
    
    var body: some View {
        Text("How May I Take Your Order?")
            .padding()
        ZStack {
            Color.orange.ignoresSafeArea()
            VStack {
                Image(menu[index].img)
                    .resizable()
                    .scaledToFit()
                    .padding()
                Text("\(menu[index].dish) Price: $\(menu[index].price.formatted())")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                HStack {
                    Text("Quantity: ")
                        .padding(.leading, 50.0)
                    TextField("1", text: $unitStr)
                }
                Button("Next Menu Item") {
                    if index < menu.count - 1 {
                        index = index + 1
                        print(index)
                    } else {
                        index = 0
                    }
                    unitStr = "1"
                }
                .font(.caption)
                .buttonStyle(.borderedProminent)
                .padding()
                
                Button("Order") {
                    let unit = Int(unitStr)
                    let menu = menu[index]
                    let order = Order(dish: menu, unit: unit!)
                    orders.append(order)
                    receipt = ""
                    totalAmt = 0.0
                    
                    for item in orders {
                        totalAmt = totalAmt + item.dish.price * Double(item.unit)
                        receipt = receipt + "\n \(item.dish.dish) x \(item.unit): $\(item.dish.price * Double(item.unit))"
                    }
                    receipt = receipt + "\n Total Amount: $\(totalAmt.formatted())"
                }
                .font(.caption)
                .buttonStyle(.borderedProminent)
                .padding()
                Text(receipt)
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
