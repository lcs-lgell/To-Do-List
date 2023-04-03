//
//  ListView.swift
//  To-Do List
//
//  Created by Leon Gell on 2023-04-03.
//

import SwiftUI

struct ListView: View {
    //MARK: Stored Properties
    
    // the list of items to be completed
    @State var todoItems: [ToDoItem] = existingTodoItems
    
    // the item currently being added
    @State var newItemDescription: String = ""
    
    //MARK: Computed Properties
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                
                HStack{
                    
                    TextField("Enter a to-do item", text: $newItemDescription)
                    
                    Button(action: {
                    // get last todo item id
                        let lastId = todoItems.last!.id
                        
                    // create new todo item id
                        let newId = lastId + 1
                        
                    // creat the new todo Item
                        let newTodoItem = ToDoItem(id: newId, description: newItemDescription, completed: false)
                    // add the new todo item to the list
                        todoItems.append(newTodoItem)
                        
                    // Clear the input field
                        newItemDescription = ""
                        
                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    })
                    
                    
                }
                .padding(20)
                
                List(todoItems) { currentItem in
                    
                    Label(title: {
                        Text(currentItem.description)
                    }, icon: {
                        if currentItem.completed == true {
                            Image(systemName: "checkmark.cricle")
                        } else {
                            Image(systemName: "circle")
                        }
                        
                    })
                    
                    
                }
                
            }
            .navigationTitle("To do")
            
        }
       
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
