//
//  AddView.swift
//  HabitTracker
//
//  Created by Caden Huffman on 8/24/23.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var habits: Habits
    @State private var name = ""
    @State private var description = ""
    @State private var urgency = 0
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Name", text: $name)
                    TextField("Description", text: $description,  axis: .vertical)
                        .lineLimit(5...10)
                }
                Section{
                    Picker("Urgency", selection: $urgency){
                        ForEach(1...5,id: \.self){
                            Text("\($0)")
                        }
                        
                    }
                    .pickerStyle(.segmented)
                }
                
                Section{
                    //Want to put something here, too much empty space
                    
                    
                    //Want to put something taht shows how often this has been done.
                    //Maybe like showing the previous week and highlight the days
                }
                    
            }

            
            
            .navigationTitle("Add Habit")
            .toolbar(content: {
                Button("Save"){
                    let item = HabitItem(name: name, description: description, urgency: urgency)
                    habits.items.append(item)
                    dismiss()
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
