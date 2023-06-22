//
//  HomeView.swift
//  Cryptomanic
//
//  Created by Fakhruddin Aiman on 14/06/2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var notShowPortfolio: Bool = true
   
    var body: some View {
        ZStack{
            //Background Layer
            Color.theme.background.ignoresSafeArea()
        
            //Content Layer
            VStack{
                //Home Header
                
                homeHeader
                
                ColumnHeader
                
                if !notShowPortfolio {
                   allCoinList
                    .transition(.move(edge: .leading))
                }
                
                if notShowPortfolio {
                    porfolioCoinList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 3.0)
                
            }
            
        }
    }
}


extension HomeView {
    private var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: notShowPortfolio ? "plus" : "info" )
                .animation(.none, value: notShowPortfolio)
                .background(
                    CircleButtonAnimationView(animate: $notShowPortfolio)
                )
            Spacer()
            Text(notShowPortfolio ? "Portfolio" :"Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none,value: notShowPortfolio)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: notShowPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        notShowPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
        
    }
    
    private var allCoinList: some View {
        List {
            ForEach(vm.allCoin){ coin in
                CoinRowView(coin: coin, showHoldingColum: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var porfolioCoinList: some View {
        List {
            ForEach(vm.allCoin){ coin in
                CoinRowView(coin: coin, showHoldingColum: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var ColumnHeader: some View {
        HStack() {
            Text("Coin")
            Spacer()
            if notShowPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homevm)
        
    }
}
