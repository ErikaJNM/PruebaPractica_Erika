//
//  PrincipalController.swift
//  PruebaPractica_Erika
//
//  Created by MacBookMBA1 on 05/07/23.
//

import UIKit
import CoreMotion
import AVFAudio

class PrincipalController: UIViewController {
    
    @IBOutlet weak var picker: UIPickerView!
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
        picker.delegate = self
        picker.dataSource = self
        lblTemporizador.isHidden = true
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
            var horas = picker.selectedRow(inComponent: 0)
            var minutos = picker.selectedRow(inComponent: 1)
            var segundos = picker.selectedRow(inComponent: 2)
            
            if horas == 0 && minutos == 0 && segundos == 0 {
                return
            }
            
            if picker.selectedRow(inComponent: 1) == 0 {
                minutos = 59
                //horas -= 1
            }else{
                minutos = picker.selectedRow(inComponent: 1)
            }
            
            if picker.selectedRow(inComponent: 2) == 0 {
                segundos = 60
                //minutos -= 1
            }else{
                segundos = picker.selectedRow(inComponent: 2)
            }
            
            let lblHora = PrincipalViewModel.Cero(dato: horas)
            var lblMinutos : String = ""
            var lblSegundos : String = ""
            if segundos == 60 {
                lblSegundos = PrincipalViewModel.Cero(dato: 00)
            }else{
                lblSegundos = PrincipalViewModel.Cero(dato: segundos)
            }
            
            if minutos == 59{
                lblMinutos = PrincipalViewModel.Cero(dato: 00)
            }else{
                lblMinutos = PrincipalViewModel.Cero(dato: minutos)
            }
            lblTemporizador.text = "\(lblHora):\(lblMinutos):\(lblSegundos)"
            lblTemporizador.isHidden = false
            reloj.Horas = horas
            reloj.Minutos = minutos
            reloj.Segundos = segundos
            picker.isHidden = true
            
            btnPausarOutlet.setTitle("Pausar", for: .normal)
            lblConfigurada.isHidden = false
            btnCancelarOutlet.isHidden = false
            btnPausarOutlet.isHidden = false
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
        lblTemporizador.isHidden = true
        picker.selectRow(0, inComponent: 0, animated: false)
        picker.selectRow(0, inComponent: 1, animated: false)
        picker.selectRow(0, inComponent: 2, animated: false)
        picker.isHidden = false
        resumeTapped = false
        reloj.Horas = 00
        reloj.Minutos = 00
        reloj.Segundos = 00
        lblTemporizador.text = "00:00:00"
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
                reloj.Minutos = 59
                reloj.Segundos = 60
                if reloj.Horas == -1 {
                    timer.invalidate()
                    var opcion = userDefault.string(forKey: "opcion") ?? "Vibración y Sonido"
                    var sonido  = userDefault.string(forKey: "Sonido") ?? "Sonido 1"
                    var vibracion = userDefault.string(forKey: "Vibracion") ?? "Vibración 1"
                    switch opcion {
                        case "Vibración y Sonido":
                            Sonidos(sonido: sonido)
                            Vibraciones(vibracion: vibracion)
                            print(sonido, vibracion)
                            break
                        case "Sólo Sonido":
                            Sonidos(sonido: sonido)
                            print(sonido)
                            break
                        case "Solo Vibración":
                            Vibraciones(vibracion: vibracion)
                            print(vibracion)
                            break
                        default:
                            break
                    }
                }
            }
        }
    }

    func Sonidos(sonido : String){
        var player = Sounds().player
        
        if sonido == "Sonido 1"{
            do{
                let url = Bundle.main.url(forResource: "alarma-morning-mix", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }catch{
                print(error)
            }
        }else{
            do{
                let url = Bundle.main.url(forResource: "alarm-clock", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }catch{
                print(error)
            }
        }
    }
    
    func Vibraciones(vibracion : String){
        if vibracion == "Vibración 1"{
            let sequence: [VibrationMode] = [.light, .medium, .heavy, .medium, .light]
            var currentIndex = 0
            
            let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                if currentIndex < sequence.count {
                    Settings.vibrate(mode: sequence[currentIndex])
                    currentIndex += 1
                } else {
                    timer.invalidate()
                }
            }
        }else{
            let sequence: [VibrationMode] = [.heavy, .heavy, .heavy]
            var currentIndex = 0
            
            let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                if currentIndex < sequence.count {
                    Settings.vibrate(mode: sequence[currentIndex])
                    currentIndex += 1
                } else {
                    timer.invalidate()
                }
            }
        }
    }
}


extension PrincipalController : SideMenuViewControllerDelegate{
    func selectedCell(_ btn: String) {
        print(btn)
        if btn == "Configuración" {
            self.performSegue(withIdentifier: "conf", sender: self)
        }else{
            self.performSegue(withIdentifier: "com", sender: self)
        }
    }
    
    
}

extension PrincipalController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 24
        } else {
            if component == 1{
                return 60
            }else{
                return 60
            }
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        if component == 0 {
            return NSAttributedString(string: "\(row) horas", attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica", size: 17.0)!,NSAttributedString.Key.foregroundColor:UIColor.white])
        } else {
            if component == 1 {
                return NSAttributedString(string: "\(row) minutos", attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica", size: 17.0)!,NSAttributedString.Key.foregroundColor:UIColor.white])
            } else {
                return NSAttributedString(string: "\(row) s", attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica", size: 17.0)!,NSAttributedString.Key.foregroundColor:UIColor.white])
            }
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
            case 0 :
                print(row)
                break
            case 1 :
                print(row)
                break
            case 2 :
                print(row)
                break
            default:
                break
        }
    }
    
}
