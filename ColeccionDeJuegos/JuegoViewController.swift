//
//  JuegoViewController.swift
//  ColeccionDeJuegos
//
//  Created by Juan Carlos Guillén Castro on 4/25/18.
//  Copyright © 2018 Juan Carlos Guillén. All rights reserved.
//

import UIKit

class JuegoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var juegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    @IBOutlet weak var eliminarBoton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var juego: Juego? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        configureContent()
        loadContent()
    }
    
    func configureContent() {
        imagePicker.delegate = self
        juegoImageView.layer.cornerRadius = 12.5
        if juego != nil {
            eliminarBoton.isHidden = false
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }
    }
    
    func loadContent() {
        if juego != nil {
            juegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
        }
    }
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        if juego != nil {
            juego!.titulo = tituloTextField.text!
            juego!.imagen = UIImagePNGRepresentation(juegoImageView.image!) as Data?
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text!
            juego.imagen = UIImagePNGRepresentation(juegoImageView.image!) as Data?
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        juegoImageView.image = selectedImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
