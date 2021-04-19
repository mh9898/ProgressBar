//
//  FileCell.swift
//  ProgressBarTest
//
//  Created by MiciH on 4/18/21.
//

import UIKit

class FileCell: UITableViewCell {
    
    static let reuseID = "FileCell"
    
    let fileTitle = PBTitleLabel(textAlignment: .left, fontSize: 18, weight: .bold, color: .label)
    let fileSizeTitle = PBTitleLabel(textAlignment: .left, fontSize: 16, weight: .regular, color: .secondaryLabel)
    
    let progressView = PBProgressView()
    private var progress = Progress()
    private var timer = Timer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        addSubview(fileTitle)
        addSubview(fileSizeTitle)
        addSubview(progressView)
        
        NSLayoutConstraint.activate([
            fileTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            fileTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            fileTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            fileSizeTitle.topAnchor.constraint(equalTo: fileTitle.bottomAnchor, constant: 6),
            fileSizeTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            fileSizeTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            progressView.topAnchor.constraint(equalTo: fileSizeTitle.bottomAnchor, constant: 12),
            progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
        ])
    }
    
    func set(file: File, isButtonPressed: Bool){
        
        fileTitle.text = file.title
        progressView.setProgress(0, animated: true)
        progress.totalUnitCount = Int64(file.fileSize / 10)
        var progressFloat = Float(self.progress.fractionCompleted)
        
        if isButtonPressed == false{
            timer.invalidate()
            DispatchQueue.main.async {
                self.progressView.setProgress(progressFloat, animated: true)
            }
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ [weak self] (time) in
            
            if isButtonPressed == true{
                guard let self = self else { return }
                
                guard self.progress.isFinished == false else{
                    time.invalidate()
                    DispatchQueue.main.async {
                        self.fileSizeTitle.text = "DONe"
                        self.progressView.isHidden = true
                    }
                    return
                }
                
                self.progress.completedUnitCount += 1
                
                progressFloat = Float(self.progress.fractionCompleted)
                DispatchQueue.main.async {
                    self.progressView.setProgress(progressFloat, animated: true)
                    self.fileSizeTitle.text = String(format: "%.2f", progressFloat * 10)
                }
                
            }
        }
    }
    
}
