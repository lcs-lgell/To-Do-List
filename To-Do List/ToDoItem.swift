//
//  ToDoItem.swift
//  To-Do List
//
//  Created by Leon Gell on 2023-04-03.
//

import SwiftUI

struct ToDoItem: Identifiable {
    var id: Int
    var description: String
    var completed: Bool
}

var existingTodoItems = [

    
    ToDoItem(id: 1, description: "Study for Physics quiz", completed: false),
    
    ToDoItem(id: 2, description: "Finish computer science assignment", completed: true),
    
    ToDoItem(id: 3, description: "Go for a run", completed: false),


]



