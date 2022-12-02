//
//  ContentView.swift
//  coffeshop
//
//  Created by Hamal Saefudin on 19/11/22.
//

import SwiftUI
import ActivityView

struct CoffeshopListView: View {
    //    MARK: - PROPERTIES
    @State private var search:String = "";
    @State var isAlert:Bool = false
    
    
    
    private var coffeshopSearchResult:[CoffeshopModel]{
        let result =  CoffeshopModelProvider.getAll()
        if search.isEmpty{
            return result;
        }
        
        return result.filter{
            $0.name.lowercased().contains(search.lowercased())
        }
    }
    
    private var suggestedResult:[CoffeshopModel]{
        
        if search.isEmpty{
            return []
        }
        
        return coffeshopSearchResult;
    }
    private func showAlertOnPinPress()->Void{
        isAlert = true
    }
    var body: some View {
        NavigationStack{
            List {
                ForEach(coffeshopSearchResult){ result in
                    ZStack(alignment: .leading){
                        NavigationLink(destination: CoffeshopDetailView(coffeshopDetail: result),label: {
                            CoffeshopItem(result: result,onPinPress: showAlertOnPinPress)
                        })
                        
                    }
                }
                .onDelete{ indexSet in
                    
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
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
            .navigationTitle("Browse")
            
        }//:NAV
        .alert("Not Yet Available", isPresented: $isAlert){
            Button {
                
            } label: {
                Text("🆗Buddy👌🏻")
            }
        } message: {
            Text("Sorry, this feature is not available yet")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeshopListView()
    }
}

struct CoffeshopItem: View {
    @State var result:CoffeshopModel
    @State var onPinPress:()->Void
    @State private var item:ActivityItem?
    
    var body: some View {
        HStack{
            Image(result.image)
                .resizable()
                .scaledToFill()
                .frame(width:120,height: 120)
                .clipped()
                .cornerRadius(20)
            VStack(alignment:.leading){
                HStack {
                    Text(result.name)
                        .font(.system(size: 22,design: .rounded).bold())
                    .truncationMode(.tail)
                    
                    Spacer()
                    if result.isFavorit {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.pink)
                    }
                    
                }
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
        }//HStack
        .swipeActions(edge: .leading,allowsFullSwipe: false){
            Button {
                result.isFavorit.toggle()
            } label:{
                Image(systemName: result.isFavorit ? "heart.slash.fill" : "heart.fill")
            }.tint(.green)
            
            Button {
                item = ActivityItem(items: "Share information about \(result.name)")
            } label:{
                Image(systemName: "square.and.arrow.up")
            }.tint(.indigo)
        }
        .contextMenu{
            Button {
                onPinPress()
            } label:{
                HStack{
                    Image(systemName: "pin")
                    Text("Pin this location")
                }
            }
            
            Button {
                item = ActivityItem(items: "Share information about \(result.name)")
            } label:{
                HStack{
                    Image(systemName: "square.and.arrow.up")
                    Text("Share")
                }
            }
            
            
            Button {
                result.isFavorit.toggle()
            } label:{
                HStack{
                    Image(systemName: result.isFavorit ? "heart.slash" : "heart")
                    Text(result.isFavorit ? "Remove from favorit" : "Add to Favorit")
                }
            }
        }
        .activitySheet($item)
    }
}
