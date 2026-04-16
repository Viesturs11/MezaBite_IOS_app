//
//  HomeView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Uzņēmums")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("TextPrimary")) 
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .padding(.vertical)
                
                Text("Meža Bite")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color("TextPrimary"))
                
                Text("Biškopības uzņēmums ar vairāk nekā 20 gadu pieredzi.")
                    .foregroundColor(Color("TextSecondary"))
                
                Text("Mūsu misija")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                    .foregroundColor(Color("TextPrimary"))
                
                Text("Radīt dabīgus, kvalitatīvus un garšīgus produktus no Latvijas dravām — ar cieņu pret dabu, bitēm un cilvēkiem.")
                    .foregroundColor(Color("TextSecondary"))
                
                Text("Vēsture")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                    .foregroundColor(Color("TextPrimary"))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("• 2005: Radās pirmā drava nelielā lauku saimniecībā.")
                    Text("• 2023: Paplašināts sortiments — sukādes, sīrupi, radīti pirmie medus maisījumi ar liofilizētām ogām.")
                    Text("• 2025: Kopā ar bitēm un cilvēkiem veidojam dabisku nākotni.")
                }
                .foregroundColor(Color("TextSecondary"))
                
                Spacer()
            }
            .padding()
        }
        .background(Color("BackgroundColor").ignoresSafeArea())
    }
}
