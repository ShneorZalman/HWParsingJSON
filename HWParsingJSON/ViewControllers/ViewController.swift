//
//  ViewController.swift
//  HWParsingJSON
//
//  Created by Zalman Zoteev on 18/06/2023.
//

import UIKit

class ViewController: UIViewController {

    var url: URL = URL(string: "https://api.chucknorris.io/jokes/random")!
    
    var person: Person!
    
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPerson()
        fetchImage()
    }
    
    private func fetchImage() {
        URLSession.shared.dataTask(with: URL(string: "https://top-honderd.nl/content/lists/top-100-best-chuck-norris-feiten.jpg")!) { [weak self] data, response, error in
            guard let data, let response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            print(response)
            
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
            }
            
        }.resume()
    }
}

extension ViewController {
    
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
    
    private func fetchPerson() {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let person = try decoder.decode(Person.self, from: data)
                print(person)
                self?.showAlert(withStatus: .success)
            } catch {
                print(error.localizedDescription)
                self?.showAlert(withStatus: .failed)
            }
            
        }.resume()
    }
    
    
}
