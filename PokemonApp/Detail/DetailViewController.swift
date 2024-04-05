//
//  DetailViewController.swift
//  PokemonApp
//
//  Created by Sultan Rifaldy on 04/04/24.
//

import UIKit
import Moya

class DetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var result: Results!
    var imageUrl: String?
    var move: [Move] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
//        loadMove()
    }

    
    
    func setup() {
        title = result.name
        tableView.dataSource = self
//        tableView.delegate = self
    }
    
    func loadMove() {
        ApiServices.shared.loadMove(name: result.name) { result, error in
            if let error = error {
                print(error)
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            } else {
                self.move = result
                self.tableView.reloadData()
            }
        }
    }

}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail_cell", for: indexPath) as! DetailViewCell
        
//        let move = move[indexPath.row]
        if let imageUrl = result.imageUrl, let url = URL(string: imageUrl) {
            cell.detailImageView?.kf.setImage(with: url)
        }
//        cell.moveLabel.text = move.name
        cell.delegate = self
        
        return cell
    }
}


extension DetailViewController: DetailViewCellDelegate {
    func detailViewCellCatchButtonTapped(_ cell: DetailViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let pokemon = move[indexPath.row]
        }
        
        CoreDataStorage.shared.catchPokemon(result: result)
    }
    
}
