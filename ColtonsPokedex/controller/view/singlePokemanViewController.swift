//
//  singlePokemanViewController.swift
//  ColtonsPokedex
//
//  Created by Gavin Craft on 5/4/21.
//

import UIKit
class SinglePokemanViewController: UIViewController, UISearchBarDelegate{
    //MARK: - iboutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - properties
    var pokeman: Pokeman?
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    //MARK: - ibactions
    @IBAction func cathButtonPressed(_ sender: Any) {
        guard let poke = pokeman else {return}
        var storedPoke = StoredPokeman(poke: poke, image: imageView.image!.pngData()!)
        PokemanController.shared.addPokemanToStore(poke: storedPoke)
        //print(PokemanController.shared.pokemans)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        if(searchBar.text == ""){
            self.imageView.image = UIImage(named: "na")
        }
        guard let text = searchBar.text, !text.isEmpty else {return}
        PokemanController.shared.downloadPoke(identifier: text.lowercased()) { result in
            DispatchQueue.main.async {
                switch result{
                case .failure(let err):
                    self.imageView.image = UIImage(named: "na")
                    
                case .success(let poke):
                    self.nameLabel.text = poke.name
                    self.pokeman = poke
                    PokemanController.shared.downloadImage(url: poke.sprites.classic!) { image in
                        guard let image = image else {self.imageView.image = UIImage(named: "na");return}
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                }
            }
        }
    }
}
extension UIViewController {
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
