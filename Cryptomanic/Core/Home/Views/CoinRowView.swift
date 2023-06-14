//
//  CoinRowView.swift
//  Cryptomanic
//
//  Created by Fakhruddin Aiman on 14/06/2023.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingColum: Bool
    
    var body: some View {
        
            
            HStack(spacing: 0) {
                // Left Column
                
                leftColumn
                Spacer()
                if showHoldingColum {
                    // Center Column
                    centerColumn
                }
                
                rightColumn
                
            }
            .font(.subheadline)
            
            
            
        
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingColum: true)
            .previewLayout(.sizeThatFits)
       
    }
}


extension CoinRowView{
    
    private var leftColumn: some View {
        HStack (spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .padding(.leading)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
    }
    
    private var rightColumn: some View {
        VStack (alignment: .trailing){
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    
}
