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

    var body: some View {
        NavigationStack{
            Form{
                TextField("Name", text: $name)
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
