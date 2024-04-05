//
//  HomeViewController.swift
//  PokemonApp
//
//  Created by Sultan Rifaldy on 03/04/24.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    var pokemonList: [Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        loadPokemon()
    }
    
    func setup () {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadPokemon() {
        ApiServices.shared.loadPokemon(name: "") { result, error in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            } else {
                self.pokemonList = result
                self.tableView.reloadData()
            }
        }
    }

    func reloadData() {
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "home_cell", for: indexPath) as! HomeViewCell
        
        let pokemon = pokemonList[indexPath.row]
        cell.nameLabel.text = pokemon.name
        
        if let imageUrl = pokemon.imageUrl, let url = URL(string: imageUrl) {
            cell.thumbImageView?.kf.setImage(with: url)
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let pokemon = pokemonList[indexPath.row]
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewController.result = pokemon
        viewController.imageUrl = pokemon.imageUrl
        navigationController?.pushViewController(viewController, animated: true)

    }
}
