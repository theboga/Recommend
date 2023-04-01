//
//  SettingsView.swift
//  Recommend
//
//  Created by Ignacio Bogarin on 10/05/22.
//

import SwiftUI

struct SettingsView: View {
    @State var progreso:Float = 6.0
    
    var body: some View {
        MyProgressBar(progress: $progreso)
            .frame(width: 50, height: 50, alignment: .center)
    }
}

struct MyProgressBar: View {
    @Binding var progress: Float
    let colores: [Color] = [Color.green, Color.yellow, Color.red]
    var myColor: Color {
        if progress >= 5.6{
            return Color.green
        } else if progress > 3.7 && progress < 5.6 {
            return Color.yellow
        } else {
            return Color.red
        }
    }
    var body: some View{
        ZStack{
            Circle()
                .stroke(lineWidth: 5.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress / 10,1.0)))
                .stroke(style: StrokeStyle(lineWidth: 7.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(myColor)
                .rotationEffect(Angle(degrees: 270))
            Text(String(format: "%.1f", progress) + " %")
                .font(.caption)

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
}
