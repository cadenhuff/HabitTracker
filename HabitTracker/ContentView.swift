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
                Section(){
                    
                    ForEach(habits.items){item in
                        //want to order by urgency
                        Button(action: {
                            
                        }, label: {
                            HabitRowView(habit: item)
                                
                        })
                        //Dont' this is the best solve for the text color problem
                        .foregroundColor(.black)
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

struct HabitRowView: View{
    var habit: HabitItem
    
    var body: some View{
        HStack{
            Text("\(habit.name)")
            Spacer()
            Text("\(habit.urgency)")
            
            
        }
    }
    
    
}


struct HabitItem:Identifiable, Codable{
    let name:String
    let description:String
    let urgency:Int
    var id = UUID()
    
}
class Habits: ObservableObject{
    @Published var items = [HabitItem]()
    init(items: [HabitItem] = [HabitItem]()) {
        self.items = items
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
