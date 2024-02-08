//
//  CoreMotionService.swift
//  DogRun
//
//
import CoreMotion

final class CoreMotionService {
    
    static let shared = CoreMotionService()
    private var pedoMeter = CMPedometer()
    private var timer: Timer?
    var startTime: Date?
    
     
    var stepUpdateHandler: ((Int) -> Void)?
    
    func startScheduler() {
        startTime = Date()
        timer = Timer.scheduledTimer(timeInterval: 10.0,
                                      target: self,
                                      selector: #selector(checkSteps),
                                      userInfo: nil,
                                      repeats: true)
    }
    
    func stopScheduler() {
        timer?.invalidate() // 타이머 종료
        timer = nil
    }
    
    @objc private func checkSteps() {
        let nowDate = Date()
        
        guard let todayStartDate = startTime else { return }
        
        print("todayStartDate : \(todayStartDate) / nowDate : \(nowDate)")
        
        pedoMeter.queryPedometerData(from: todayStartDate, to: nowDate) { data, error in
            if let error {
                print("CoreMotionService.queryPedometerData Error: \(error)")
                return
            }
            
            if let steps = data?.numberOfSteps {
                print("steps : \(steps)")
                self.stepUpdateHandler?(Int(steps))
            }
        }
    }
}

