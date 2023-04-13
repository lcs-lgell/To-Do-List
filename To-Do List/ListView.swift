//
//  ListView.swift
//  To-Do List
//
//  Created by Leon Gell on 2023-04-03.
//
import Blackbird
import SwiftUI

struct ListView: View {
    //MARK: Stored Properties
    
    // access the connection to the dataas
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    
    // the item currently being added
    @State var newItemDescription: String = ""
    
    //The current search text
    @State var searchText = ""
    
    //MARK: Computed Properties
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                
                HStack{
                    
                    TextField("Enter a to-do item", text: $newItemDescription)
                    
                    Button(action: {
                        Task {
                         //write to database
                            try await db!.transaction { core in
                                try core.query("INSERT INTO TodoItem (description) VALUES(?)", newItemDescription)
                            }
                        }
                        
                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    })
                    
                    
                }
                .padding(20)
                
                ListItemsView(filteredOn: searchText)
                .searchable(text: $searchText)
                
                
            }
            .navigationTitle("To do")
            
        }
       
    }
 
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
        //make the database available to all other views
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
