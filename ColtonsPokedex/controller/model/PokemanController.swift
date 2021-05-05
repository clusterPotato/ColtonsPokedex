//
//  PokemanController.swift
//  ColtonsPokedex
//
//  Created by Gavin Craft on 5/4/21.
//

import UIKit
class PokemanController{
    static let shared = PokemanController()
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    let pokemonPathConponent = "pokemon"
    var pokemans: [StoredPokeman] = []
    init(){
        loadFromPersistenceStore()
    }
    
    //MARK: - api
    func downloadPoke(identifier: String, completion: @escaping (Result<Pokeman, Error>) -> Void){
        guard let baseURL = baseURL else {return completion(.failure(NSError()))}
        let tier2URL = baseURL.appendingPathComponent(pokemonPathConponent)
        let finalURL = tier2URL.appendingPathComponent(identifier)
        //jeez fine
        print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { data, _, err in
            if let error = err{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return(completion(.failure(NSError())))
            }
            guard let data = data else {return completion(.failure(NSError()))}
            do{
                let poke = try JSONDecoder().decode(Pokeman.self, from: data)
                completion(.success(poke))
            }catch{
                completion(.failure(NSError()))
            }
        }.resume()
    }
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void){
        let url = url
        URLSession.shared.dataTask(with: url) { data, _, err in
            if let error = err{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(nil)
            }
            guard let data = data else {return completion(nil)}
            guard let image = UIImage(data: data) else {return completion(nil)}
            return completion(image)
        }.resume()
    }
    //MARK: - crud
    func addPokemanToStore(poke: StoredPokeman){
        pokemans.append(poke)
        saveToPersistenceStore()
    }
    func deletePokeFromArray(poke:StoredPokeman){
        guard let index = pokemans.firstIndex(of: poke) else {return}
        pokemans.remove(at: index)
        saveToPersistenceStore()
    }
    
    //MARK: -  persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("pokemans.json")
        return fileURL
    }
    func saveToPersistenceStore(){
        do{
            let data = try JSONEncoder().encode(pokemans)
            try data.write(to: createPersistenceStore())
        }catch{
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    func loadFromPersistenceStore(){
        do{
            let data = try Data(contentsOf: createPersistenceStore())
            pokemans = try JSONDecoder().decode([StoredPokeman].self, from: data)
        }catch{
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}
