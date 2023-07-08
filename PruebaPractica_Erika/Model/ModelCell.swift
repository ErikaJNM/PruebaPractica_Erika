//
//  ModelCell.swift
//  PruebaPractica_Erika
//
//  Created by MacBookMBA1 on 08/07/23.
//

import Foundation
class ModelCell{
    let name : String
    var isSelected : Bool
    
    init(name: String, isSelected: Bool) {
        self.name = name
        self.isSelected = isSelected
    }
    init(){
        self.name = ""
        self.isSelected = false
    }
}
