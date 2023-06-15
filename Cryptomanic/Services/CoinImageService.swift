//
//  CoinImageService.swift
//  Cryptomanic
//
//  Created by Fakhruddin Aiman on 16/06/2023.
//

import Foundation
import SwiftUI
import Combine


class CoinImageService {
    
    @Published var image: UIImage? = nil
    var imageSubscription: AnyCancellable?
    
    private let coin: CoinModel
    
    
    init(coin: CoinModel){
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnImage) in
                self?.image = returnImage
                self?.imageSubscription?.cancel()
            })
        
        
    }
}
