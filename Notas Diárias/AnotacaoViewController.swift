//
//  AnotacaoViewController.swift
//  Notas Diárias
//
//  Created by LEANDRO RAINHA on 21/02/23.
//

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {

    @IBOutlet weak var texto: UITextView!
    var context: NSManagedObjectContext!
    var anotacao: NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.texto.becomeFirstResponder()
        if anotacao != nil{
            if let textoRecuperado = anotacao.value(forKey: "texto"){
                self.texto.text = String(describing: textoRecuperado)
            }
        }else{
            self.texto.text = ""
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
    
    @IBAction func salvar(_ sender: UIBarButtonItem) {
        
        if anotacao != nil{
            self.atualizarAnotacao()
        }else{
            self.salvarAnotacao()
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func atualizarAnotacao(){
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do{
            try context.save()
            print("Sucesso ao atualizar anotação!")
        }catch let erro {
            print("Erro ao atualizar anotação: \(erro.localizedDescription)")
        }
    }
    
    func salvarAnotacao(){
        
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        
        novaAnotacao.setValue(self.texto.text, forKey: "texto")
        novaAnotacao.setValue(Date(), forKey: "data")
        
        do{
            try context.save()
            print("Sucesso ao salvar anotação!")
        }catch let erro {
            print("Erro ao salvar anotação: \(erro.localizedDescription)")
        }
        
    }
    
}
