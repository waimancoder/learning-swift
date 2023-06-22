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
    private let filemanager =  LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id
        
    }
    
    private func getCoinImage(){
        
        if let savedImage = filemanager.getImage(imageName: imageName , folderName: folderName ) {
             image = savedImage
            print("retrieved image for file manager")
        } else {
            downloadCoinImage()
            print("downloading images")
            
        }
        
    }
    
    private func downloadCoinImage() {
       
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnImage) in
                guard let self = self , let downloadedImage = returnImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.filemanager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
        
        
    }
}
