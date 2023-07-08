//
//  PrincipalViewModel.swift
//  PruebaPractica_Erika
//
//  Created by MacBookMBA1 on 06/07/23.
//

import CoreMotion
import Foundation

class PrincipalViewModel{
    
    static func timeString(time : TimeInterval, reloj : Reloj) -> String {
        let hours = Cero(dato: reloj.Horas)
        let minutes = Cero(dato: reloj.Minutos)
        let seconds = Cero(dato: reloj.Segundos)
        
        return String(format: "\(hours):\(minutes):\(seconds)", hours, minutes, seconds)
    }
    
    static func Cero(dato : Int)-> String {
        var CeroString : String = ""
        
        if dato < 10 {
            CeroString = "0\(dato)"
        }else{
            CeroString = "\(dato)"
        }
        return CeroString
    }
}
