//
//  ContentView.swift
//  coffeshop
//
//  Created by Hamal Saefudin on 19/11/22.
//

import SwiftUI

struct ContentView: View {
    //    MARK: - PROPERTIES
    @State private var search:String = "";
    
    private var coffeshopSearchResult:[CoffeshopModel]{
        let result =  CoffeshopModel.CoffeshopModelProvider.getAll()
        if search.isEmpty{
            return result;
        }
        
        return result.filter{
            $0.name.lowercased().contains(search.lowercased())
        }
    }
    
    private var suggestedResult:[CoffeshopModel]{
        let res = CoffeshopModel.CoffeshopModelProvider.getAll();
        
        if search.isEmpty{
            return []
        }
        
        return coffeshopSearchResult;
    }
    var body: some View {
        NavigationStack{
            List(coffeshopSearchResult) {
                result in
                NavigationLink(destination:{
                    CoffeshopDetailView(coffeshopDetail:result)
                }){
                    HStack{
                        Image(result.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width:120,height: 120)
                            .clipped()
                            .cornerRadius(20)
                        VStack(alignment:.leading){
                            Text(result.name)
                                .font(.system(size: 22,design: .rounded).bold())
                                .truncationMode(.tail)
                            Spacer()
                            Text(result.location)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.system(.body,design: .rounded))
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Rating: 4/5")
                                .font(.system(size:14,design: .rounded))
                                .foregroundColor(.gray)
                        }.padding()
                    }
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Search coffeshop")
            .searchable(
                text: $search,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search coffeshops"
            ){
                ForEach(suggestedResult) { result in
                    Text("Looking for \(result.name) ?")
                        .searchCompletion(result.name)
                }
            }
            
        }//:NAV
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
