//
//  ContentView.swift
//  HabitTracker
//
//  Created by Caden Huffman on 8/22/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showingAdd = false

    var body: some View {
        NavigationStack{
            List{
                Section("Habits"){
                    ForEach(habits.items){item in
                        Text("\(item.name)")
                    }
                }
            }
            .navigationTitle("Tracker")
            .toolbar{
                Button{
                    showingAdd = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAdd, content: {
                AddView(habits: habits)
            })
        }
    }
}

struct Habit:Identifiable, Codable{
    let name:String
    let description:String
    let urgency:Int
    var id = UUID()
    
}
class Habits: ObservableObject{
    @Published var items = [Habit]()
    init(items: [Habit] = [Habit]()) {
        self.items = items
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
