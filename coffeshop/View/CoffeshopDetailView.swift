//
//  CoffeshopDetailView.swift
//  coffeshop
//
//  Created by Hamal Saefudin on 20/11/22.
//

import SwiftUI

struct CoffeshopDetailView: View {
    //    MARK: - PROPERTIES
    let coffeshopDetail:CoffeshopModel
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(
            stops: [
                .init(color: .white, location: 0.35),
                .init(color: .blue, location: 0.99)
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack{
                Image(coffeshopDetail.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 280,height: 280)
                    .clipped()
                    .clipShape(Circle())
                    .overlay{
                        ZStack{
                            Circle()
                                .opacity(0.5)
                            VStack{
                                Image(systemName: "person.crop.circle.fill.badge.plus")
                                    .renderingMode(.original)
                                    .font(.system(size: 60))
                                    .foregroundColor(.blue)
                                    .padding(.bottom,5)
                                Text(coffeshopDetail.name)
                                    .font(.system(.title,design: .rounded))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .lineLimit(2)
                                    .padding(.horizontal,8)
                                    .multilineTextAlignment(.center)
                                    
                            }
                        }
                    }
                    .padding(.bottom,28)
                Text(coffeshopDetail.review)
                    .font(.system(size:20,design: .rounded))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .lineSpacing(2)
                    .foregroundColor(.blue)
                    .padding(.horizontal,20)
                HStack {
                    Image(systemName: "pin")
                        .font(.system(size: 20))
                        .foregroundColor(.pink)
                        .background(
                        Circle()
                            .frame(width: 44,height: 44)
                            .foregroundColor(.pink)
                            .opacity(0.25)
                        )
                    Text(coffeshopDetail.location)
                        .font(.system(size:18,design: .rounded))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                        .foregroundColor(.pink)
                        .padding(.leading,20)
                }
                .padding(.top,40)
                Spacer()
            }
            
        }
    }
}

struct CoffeshopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeshopDetailView(coffeshopDetail:CoffeshopModel(image: "bojaeatery", name: "Lotu Coffee & Eatery", location: "Jl. Sumatera No. 21, Kota Bandung", review: "The food is delicious, cooked just right.  Friendly service.  Cozy atmosphere with floral decorations.  There is a ~robot~ that sends the dish.  Prices are reasonable for a restaurant of its class")
        )
    }
}
