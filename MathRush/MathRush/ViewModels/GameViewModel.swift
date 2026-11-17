//
//  GameViewModel.swift
//  MathRush
//
//  Created by Ege Kaygisizer on 19.04.2025.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var score = 0
    @Published var highScore = UserDefaults.standard.integer(forKey: "HighScore")
    @Published var bestTime: TimeInterval = UserDefaults.standard.double(forKey: "BestTime")
    @Published var timeRemaining = 60
    @Published var elapsedSeconds = 0
    @Published var elapsedTimeFormatted: String = "0.00s"
    @Published var isGameOver = false
    @Published var isStarted = false
    @Published var currentQuestion = ""
    @Published var answerChoices: [Int] = []
    @Published var questionsRemaining = 10
    @Published var timeTaken: Int = 0
    
    var correctAnswer = 0
    var timer: Timer?
    var mode = "classic"
    var startTime: Date?
    private var gameStartTime: Date?
    private var timeUpdateTimer: Timer?

    func startGame(mode: String, difficulty: String) {
        self.mode = mode
        isGameOver = false
        score = 0
        questionsRemaining = mode == "timeattack" ? 10 : 0
        correctAnswer = 0
        currentQuestion = ""
        answerChoices = []
        elapsedSeconds = 0
        elapsedTimeFormatted = "0.00s"

        if mode == "classic" {
            timeRemaining = 60
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                self.timeRemaining -= 1
                if self.timeRemaining <= 0 {
                    self.endGame()
                }
            }
        } else if mode == "timeattack" {
            gameStartTime = Date()
            timeUpdateTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                guard let start = self.gameStartTime else { return }
                let elapsed = Date().timeIntervalSince(start)
                self.elapsedTimeFormatted = String(format: "%.2fs", elapsed)
            }
        }

        generateQuestion(for: difficulty)
    }

    func startClassicTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.timeRemaining -= 1
            if self.timeRemaining <= 0 {
                self.endGame()
            }
        }
    }

    func checkAnswer(_ selected: Int, difficulty: String) {
        if selected == correctAnswer {
            if mode == "classic" {
                score += 5
            }

            if mode == "timeattack" {
                questionsRemaining -= 1
                if questionsRemaining == 0 {
                    endGame()
                    return
                }
            }

            generateQuestion(for: difficulty)
        } else {
            if mode == "classic" {
                score = max(0, score - 2)
                generateQuestion(for: difficulty)
            } else if mode == "timeattack" {
                endGame()
            }
        }
    }

    func endGame() {
        timer?.invalidate()
        timer = nil

        timeUpdateTimer?.invalidate()
        timeUpdateTimer = nil

        isGameOver = true

        if mode == "classic" {
            highScore = max(score, highScore)
            UserDefaults.standard.set(highScore, forKey: "HighScore")
        } else if mode == "timeattack" {
            if let start = gameStartTime {
                let finalTime = Date().timeIntervalSince(start)

                // Eğer tüm sorular doğru çözüldüyse ve süresi eski rekordan daha iyiyse:
                if questionsRemaining == 0 && (bestTime == 0 || finalTime < bestTime) {
                    bestTime = finalTime
                    UserDefaults.standard.set(bestTime, forKey: "BestTime")
                }
            }
        }
    }

    func generateQuestion(for difficulty: String) {
        var a = 0, b = 0
        var operation = "+"
        
        switch difficulty {
        case "Easy":
            a = Int.random(in: 1...25)
            b = Int.random(in: 1...25)
            operation = Bool.random() ? "+" : "-"
            if operation == "-" && b > a {
                swap(&a, &b)
            }
        case "Medium":
            operation = ["+", "-", "x"].randomElement()!
            if operation == "x" {
                a = Int.random(in: 1...9)
                b = Int.random(in: 1...9)
            } else {
                a = Int.random(in: 10...99)
                b = Int.random(in: 10...99)
            }
        case "Hard":
            operation = ["+", "-", "x", "/"].randomElement()!
            if operation == "x" {
                a = Int.random(in: 1...20)
                b = Int.random(in: 1...20)
            } else if operation == "/" {
                b = Int.random(in: 1...20)
                correctAnswer = Int.random(in: 1...10)
                a = b * correctAnswer
            } else {
                a = Int.random(in: 100...999)
                b = Int.random(in: 100...999)
                if operation == "-" && b > a {
                    swap(&a, &b)
                }
            }
        default:
            break
        }
        
        switch operation {
        case "+": correctAnswer = a + b
        case "-": correctAnswer = a - b
        case "x": correctAnswer = a * b
        case "/": correctAnswer = a / b
        default: correctAnswer = 0
        }

        currentQuestion = "\(a) \(operation) \(b) = ?"
        generateChoices(correctAnswer: correctAnswer)
    }

    func generateChoices(correctAnswer: Int) {
        var choices = Set<Int>()
        choices.insert(correctAnswer)

        while choices.count < 4 {
            let offset = Int.random(in: -10...10)
            if offset != 0 {
                choices.insert(correctAnswer + offset)
            }
        }

        answerChoices = Array(choices).shuffled()
    }
}
