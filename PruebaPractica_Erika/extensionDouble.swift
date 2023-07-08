//
//  extensionDouble.swift
//  PruebaPractica_Erika
//
//  Created by MacBookMBA1 on 06/07/23.
//

import Foundation
extension Double {
    func redondear(numeroDeDecimales: Int) -> String {
        let formateador = NumberFormatter()
        formateador.maximumFractionDigits = numeroDeDecimales
        formateador.roundingMode = .down
        return formateador.string(from: NSNumber(value: self)) ?? ""
    }
}
