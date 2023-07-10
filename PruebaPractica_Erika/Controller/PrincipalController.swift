//
//  PrincipalController.swift
//  PruebaPractica_Erika
//
//  Created by MacBookMBA1 on 05/07/23.
//

import UIKit
import CoreMotion

class PrincipalController: UIViewController {
    
    @IBOutlet weak var lblConfigurada: UILabel!
    @IBOutlet weak var btnPausarOutlet: UIButton!
    @IBOutlet weak var btnCancelarOutlet: UIButton!
    @IBOutlet weak var lblTemporizador: UILabel!
    
    let userDefault = UserDefaults.standard
    let motionManager = CMMotionManager()
    var timer = Timer()
    var timer2 = Timer()
    var isTimeRunning = false
    var resumeTapped = false
    var reloj = Reloj()
    var menuController : SideController?
    var principal : PrincipalController?
    override func viewDidLoad() {
        super.viewDidLoad()
        btnPausarOutlet.setTitle("Aceptar", for: .normal)
        btnCancelarOutlet.isHidden = true
        lblConfigurada.isHidden = true
        motionManager.startAccelerometerUpdates()
        menuController = SideController()
        menuController?.delegate = self
        if let menuController = menuController?.view {
            view.addSubview(menuController)
        }
    }

    @objc func update() {
        if let accelerometerData = motionManager.accelerometerData {
            let x = accelerometerData.acceleration.x
            let y = accelerometerData.acceleration.y
            let z = accelerometerData.acceleration.z
            
            if Double(x.redondear(numeroDeDecimales: 0)) == 0 && Double(y.redondear(numeroDeDecimales: 0)) == -0 && Double(z.redondear(numeroDeDecimales: 0)) == -1{
                timer2.invalidate()
                runTime()
                resumeTapped = true
                btnPausarOutlet.isHidden = false
                lblConfigurada.isHidden = true
                btnPausarOutlet.setTitle("Pausar", for: .normal)
                isTimeRunning = true
            }else{
                btnPausarOutlet.setTitle("Renudar", for: .normal)
            }
        }
    }
    
    func runCoordenadas(){
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
    }
    func runTime(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func btnMenu() {
        menuController?.view.isHidden = !(menuController?.view.isHidden)!
    }
    
    @IBAction func btnPausar(_ sender: UIButton) {
        
        
        let btnSeleccionado = sender.titleLabel?.text
        
        if btnSeleccionado == "Aceptar"{
            reloj.Horas = 10
            reloj.Minutos = 59
            reloj.Segundos = 60
            
            btnPausarOutlet.setTitle("Pausar", for: .normal)
            lblConfigurada.isHidden = false
            btnCancelarOutlet.isHidden = false
            btnPausarOutlet.isHidden = true
            runCoordenadas()
        }else{
            if self.resumeTapped == true {
                timer.invalidate()
                btnPausarOutlet.setTitle("Renudar", for: .normal)
                self.resumeTapped = false
            } else {
                runTime()
                btnPausarOutlet.setTitle("Pausar", for: .normal)
                self.resumeTapped = true
            }
        }
        
    }
    
    @IBAction func btnCancelar(_ sender: UIButton) {
        timer.invalidate()
        resumeTapped = false
        reloj.Horas = 10
        reloj.Minutos = 59
        reloj.Segundos = 60
        lblTemporizador.text = "10:00:00"
        btnCancelarOutlet.isHidden = true
        btnPausarOutlet.isHidden = false
        btnPausarOutlet.setTitle("Aceptar", for: .normal)
        lblConfigurada.isHidden = true
        let opcion = userDefault.string(forKey: "option")
        print(opcion)
    }
    
    
    @objc func UpdateTime(){
        
        reloj.Segundos -= 1
        
        lblTemporizador.text = PrincipalViewModel.timeString(time: TimeInterval(reloj.Segundos), reloj: reloj)
        print(TimeInterval(reloj.Segundos))
        if TimeInterval(reloj.Segundos) == 0 {
            reloj.Minutos -= 1
            reloj.Segundos = 60
            if reloj.Minutos == -1 {
                reloj.Horas -= 1
                reloj.Minutos = 60
                reloj.Segundos = 60
                if reloj.Horas == -1 {
                    timer.invalidate()
                    let opcion = userDefault.string(forKey: "option")
                    print(opcion)
                    print("Termino")
                }
            }
        }
    }

}


extension PrincipalController : SideMenuViewControllerDelegate{
    func selectedCell(_ btn: String) {
        print(btn)
        if btn == "Configuración" {
            self.show(ConfiguracionesController().self, sender: "Configuracion")
        }else{
            self.show(ComentariosController().self, sender: "Comentarios")
        }
    }
    
    
}
