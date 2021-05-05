//
//  myPokemansController.swift
//  ColtonsPokedex
//
//  Created by Gavin Craft on 5/4/21.
//

import UIKit
class MyPokemansViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //MARK: - iboutlets
    @IBOutlet var pokemanTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemanTable.delegate = self
        pokemanTable.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pokemanTable.reloadData()
        print(pokemanTable.numberOfRows(inSection: 0))
    }
    //MARK: - data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokemanController.shared.pokemans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell") as? PokeTableViewCell else {return UITableViewCell()}
        cell.poke = PokemanController.shared.pokemans[indexPath.row]
        cell.loadData()
        print(cell.poke)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            PokemanController.shared.deletePokeFromArray(poke: PokemanController.shared.pokemans[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
