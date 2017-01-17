//
//  ViewController.swift
//  Aula_001_VisualizadorDeImagens
//
//  Created by Swift on 16/01/17.
//
//

import UIKit
import QuickLook

class ViewController: UIViewController, QLPreviewControllerDataSource, QLPreviewControllerDelegate{
    
    //MARK: Outlets
    @IBOutlet weak var imagem: UIImageView!
    
    //MARK: Propriedades
    var arrayNomesFotos : [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...4 {
            let nomeFoto = "IMG_\(i)"
            self.arrayNomesFotos += [nomeFoto]
        }

    }
    
    //MARK: Actions
    @IBAction func escolher(_ sender: UIButton) {
        
        let quickLook = QLPreviewController()
        quickLook.delegate = self
        quickLook.dataSource = self
        
        quickLook.refreshCurrentPreviewItem()
        
        quickLook.currentPreviewItemIndex = 0
        
        self.present(quickLook, animated: true, completion: nil)
        
    }
    
    //MARK: Métodos de QLPreviewControllerDataSource
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return arrayNomesFotos.count
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        
        let nome = arrayNomesFotos[index]
        let ext = "JPG"
        let raizApp = Bundle.main
        let pathArquivo = raizApp.path(forResource: nome, ofType: ext)
        let urlArquivo = URL(fileURLWithPath: pathArquivo!)
        return urlArquivo as QLPreviewItem
        
        
    }
    
    
    //MARK: Métodos de QLPreviewControllerDelegate
    func previewControllerWillDismiss(_ controller: QLPreviewController) {
        let indice = controller.currentPreviewItemIndex
        let nomeCompleto = "\(arrayNomesFotos[indice]).JPG"
        imagem.image = UIImage(named: nomeCompleto)
    }




}

