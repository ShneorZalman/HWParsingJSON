//
//  ViewController.swift
//  HWParsingJSON
//
//  Created by Zalman Zoteev on 18/06/2023.
//

import UIKit

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug area"
        }
    }
}

final class ViewController: UIViewController {

    var url = URL(string: "https://api.chucknorris.io/jokes/random")!
    var person: Person!
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPerson()
        fetchImage()
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
    
    private func fetchImage() {
        URLSession.shared.dataTask(with: URL(string: person.icon_url)!) { [weak self] data, response, error in
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
    
    private func fetchPerson() {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let person = try decoder.decode(Person.self, from: data)
                print(person.icon_url)
                self?.showAlert(withStatus: .success)
            } catch {
                print(error.localizedDescription)
                self?.showAlert(withStatus: .failed)
            }
            
        }.resume()
    }
    
    
}
