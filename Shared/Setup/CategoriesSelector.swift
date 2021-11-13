//
//  CategoriesSelector.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/13/21.
//

import SwiftUI

struct CategoriesSelector: View {
    @State var SelectedCategories: [String] = []
    @Binding var didSetup: Bool
    @State var isLoading: Bool = true
    
    @EnvironmentObject var comms: OrganizationsController
    
    var body: some View {
        VStack {
            Text("Select up to 3 club categories")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding()
                .navigationBarBackButtonHidden(true)
            if !isLoading {
            ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 25, maximum: 300), spacing: 0), GridItem(.flexible(minimum: 25, maximum: 300), spacing: 0)]) {
                ForEach($comms.categories, id: \.self) { category in
                    CategoryBox(title: category.wrappedValue)
                }
            }
            }
            .frame(minHeight: 200)
            .padding()
            Spacer()
            
            NavigationLink(destination: FavoriteClubsSelector()) {
                Text("Contiunue")
                    .font(.system(size: 25))
                    .frame(minWidth: 150)
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(20)
            .padding(.bottom, 300)
        } else {
            ProgressView()
        }
        }
        .onAppear() {
            comms.getCategories()
        }
    }
}

struct CategoryBox: View {
    var title: String
    @State var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .foregroundColor(isSelected ? .white : .primary)
            .padding()
            .frame(minWidth: 100, minHeight: 100)
            //.border(.primary)
            .background(isSelected ? Color.accentColor : Color.clear)
            .onTapGesture {
                isSelected.toggle()
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.primary)
            )
            
    }
}

struct CategoriesSelector_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesSelector(SelectedCategories: [], didSetup: .constant(false), isLoading: false)
    }
}
