//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Arturo Lee on 9/11/16.
//  Copyright © 2016 futw. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon! //Set with Segueue
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var pokedexId: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var baseAttack: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalized
        pokedexId.text = "\(pokemon.pokdexId)"
        
        let img = UIImage(named: "\(pokemon.pokdexId)")
        mainImg.image = img
        currentEvoImg.image = img
        
        pokemon.downloadPokemonDetail {
            //Whatever we write will only be called after the network call is complete
            self.updateUI()
        }
    }
    
    func updateUI() {
        baseAttack.text = pokemon.attack
        defense.text = pokemon.defense
        height.text = pokemon.height
        weight.text = pokemon.weight
        type.text = pokemon.type
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
