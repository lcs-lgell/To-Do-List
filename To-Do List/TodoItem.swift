//
//  ToDoItem.swift
//  To-Do List
//
//  Created by Leon Gell on 2023-04-03.
//

import Blackbird
import SwiftUI

struct TodoItem: Identifiable {
   @BlackbirdColumn var id: Int
   @BlackbirdColumn var description: String
   @BlackbirdColumn var completed: Bool
}


