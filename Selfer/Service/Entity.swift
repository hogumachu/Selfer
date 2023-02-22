//
//  Entity.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import Foundation
import RealmSwift

protocol Entity {
    
    associatedtype ObjectType = Object
    func toObject() -> ObjectType
    
}
