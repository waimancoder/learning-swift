//
//  HomeViewModel.swift
//  Cryptomanic
//
//  Created by Fakhruddin Aiman on 15/06/2023.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var allCoin: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubcribers()
    }
    
    func addSubcribers() {
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoin = returnedCoins
            }.store(in: &cancellables)
    }
    
    
}
