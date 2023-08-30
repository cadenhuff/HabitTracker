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
    @State private var completedHabits = [HabitItem]()
    var body: some View {
        NavigationStack{
            List{
                Section(header:
                    habits.items.isEmpty ? Text("") :
                            Text("Habits")
                ){
                    
                    ForEach(habits.items){item in
                        //want to order by urgency
                        Button(action: {
                            HabitView()
                        }, label: {
                            HabitRowView(habit: item)
                                
                        })
                        //Dont' this is the best solve for the text color problem
                        .foregroundColor(.black)
                    }
                    .onDelete(perform: removeItems)
                }
                Section(header:
                    completedHabits.isEmpty ? Text("") : Text("Completed")
                ) {
                    ForEach(completedHabits) { habit in
                        /*@START_MENU_TOKEN@*/Text(habit.name)/*@END_MENU_TOKEN@*/
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
    func removeItems(at offsets: IndexSet){
        let removedItems = offsets.lazy.map { habits.items[$0] }
        completedHabits.append(contentsOf: removedItems)
        habits.items.remove(atOffsets: offsets)
        
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
    @Published var items = [HabitItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
