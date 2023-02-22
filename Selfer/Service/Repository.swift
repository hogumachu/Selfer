//
//  Repository.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import Foundation
import RealmSwift

protocol Repository {
    
    associatedtype EntityType = Entity
    
    func getAll(where predicate: NSPredicate?) -> [EntityType]
    func insert(item: EntityType) throws
    func update(item: EntityType) throws
    func delete(item: EntityType) throws
    
}
