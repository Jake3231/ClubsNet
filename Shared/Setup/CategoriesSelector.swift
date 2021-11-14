//
//  CategoriesSelector.swift
//  MOCK-HackUTDVIII
//
//  Created by Jake Spann on 11/13/21.
//

import SwiftUI

struct CategoriesSelector: View {
    @Binding var SelectedCategories: [String]
    @Binding var didSetup: Bool
    @State var isLoading: Bool = false // For now
    @Binding var setupStage: SetupStage
    
    @EnvironmentObject var comms: OrganizationsController
    
    var body: some View {
        VStack {
            Text("Select up to 3 club categories")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding()
                .navigationBarBackButtonHidden(true)
            if !isLoading {
                ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 25, maximum: 300), spacing: 10), GridItem(.flexible(minimum: 25, maximum: 300), spacing: 10)]) {
                ForEach($comms.categories, id: \.self) { category in
                    CategoryBox(title: category.wrappedValue, selectedCategories: $SelectedCategories)
                }
            }
            }
            .frame(minHeight: 200)
            .padding()
            Spacer()
            
               // NavigationLink(destination: FavoriteClubsSelector(selectedCategories: SelectedCategories)) {
                Button("Contiunue") {
                    withAnimation() {
                        setupStage = .favoriteClubsSelector
                    }
                }
                    .font(.system(size: 25))
                    .frame(minWidth: 150)
            //}
            .buttonStyle(.borderedProminent)
            .cornerRadius(20)
            .padding(.bottom)
        } else {
            ProgressView()
        }
        }
    }
}

struct CategoryBox: View {
    var title: String
    @Binding var selectedCategories: [String]
    @State var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .foregroundColor(isSelected ? .white : .primary)
            .padding()
            //.frame(minWidth: 100, minHeight: 100)
            //.border(.primary)
            .background(isSelected ? Color.accentColor : Color.secondary)
            .onTapGesture {
                if isSelected {
                    selectedCategories.removeAll(where: {$0 == self.title})
                } else if selectedCategories.count < 3 {
                    selectedCategories.append(self.title)
                }
                isSelected.toggle()
            }
            .cornerRadius(10)
            /*.overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.primary)
            )*/
            
    }
}

struct CategoriesSelector_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesSelector(SelectedCategories: .constant([]), didSetup: .constant(false), isLoading: false, setupStage: .constant(.categorySelector))
    }
}
