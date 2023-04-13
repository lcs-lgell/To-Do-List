//
//  ListItemsView.swift
//  To-Do List
//
//  Created by Leon Gell on 2023-04-12.
//
import Blackbird
import SwiftUI

struct ListItemsView: View {
    
    //MARK: STORED PROPERTIES
    
    //needed to query database
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    // the list of items to be completed
    @BlackbirdLiveModels var todoItems: Blackbird.LiveResults<TodoItem>
    
    //MARK: COMPUTED PROPERTIES
    var body: some View {
        List {
            
            ForEach(todoItems.results) { currentItem in
                
                Label(title: {
                    Text(currentItem.description)
                }, icon: {
                    if currentItem.completed == true {
                        Image(systemName: "checkmark.circle")
                    } else {
                        Image(systemName: "circle")
                    }
                    
                })
                .onTapGesture {
                    Task{
                        try await db!.transaction { core in
                            //Change the status to the opposite
                            try core.query("UPDATE TodoItem set completed = (?) WHERE id = (?)", !currentItem.completed, currentItem.id)
                            
                            
                        }
                    }
                }
            }
            .onDelete(perform: removeRows)
        }
        }
    
    //MARK: Initalizer
    init(filteredOn searchText: String) {
        
        // Initialize
        _todoItems = BlackbirdLiveModels({ db in
            try await TodoItem.read(from: db, sqlWhere: "description LIKE ?", "%\(searchText)%")
        })
        
        
    }
    
    
    
    
    //MARK: functions
    func removeRows(at offsets: IndexSet) {
        
        Task {
            
            try await db!.transaction { core in
                
                // Get the id of the item to be deleted
                var idList = ""
                for offset in offsets {
                    idList += "\(todoItems.results[offset].id),"
                }
                
                // remove the final comma
                print(idList)
                idList.removeLast()
                print(idList)
                
                //Delete the row from the database
                try core.query("DELETE FROM TodoItem WHERE id IN (?)", idList)
                print("Finished deleting")
                
            }
            
            
        }
    }
    
}

struct ListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemsView(filteredOn: "testing")
        // make the database available to all other views through the enviornment
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
