//
//  CardView.swift
//  YoliFlashZilla
//
//  Created by Yolanda on 20/04/2021.
//

import SwiftUI

struct CardView: View {
    
//    @Binding var right: Int?
    
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    let card: Card
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    var removal: ((Bool) -> Void)? = nil//if the last property in a Struct is a closure SwiftUI will enable trailing closure syntax automatically

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                            .opacity(1 - Double(abs(offset.width / 50)))

                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(offset.width > 0 ? Color.green : Color.red)
                )
                .shadow(radius: 10)

            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))//divided otherwise it would spin like crazy
        .offset(x: offset.width * 5, y: 0)//multiplied so user can swipe with small gestures
        .opacity(2 - Double(abs(offset.width / 50)))//gives him headroom to make sure it’s not fading out straight away when dragged.
        .accessibility(addTraits: .isButton)//means blind users know what it is
        .gesture(
            DragGesture()
                .onChanged { offset in
                    self.offset = offset.translation
                    self.feedback.prepare()
                }//warms up taptic engine each time the user drags

                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        if self.offset.width > 0 {
                            self.feedback.notificationOccurred(.success)
                            self.removal?(true)
                          //  card.correct = true
                        } else {
                            self.feedback.notificationOccurred(.error)
                            self.removal?(false)
                        }

                        
                    } else {
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: Card.example)
//    }
//}
