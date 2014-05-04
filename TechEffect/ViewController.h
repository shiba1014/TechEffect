//
//  ViewController.h
//  TechEffect
//
//  Created by Paul McCartney on 2014/05/04.
//  Copyright (c) 2014年 羽柴彩月. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreImage/CoreImage.h> //CoreImage.flameの導入

@interface ViewController : UIViewController{
    
    UIImage *originImage; //処理前の画像
    
    CIImage *filteredImage; //処理中の画像
    
    UIImage *outputImage; //処理後の画像
    
    IBOutlet UIImageView *imageView; //画像を表示するためのImageView
    
    IBOutlet UISlider *slider; //フィルタの強度を調整するためのSlider
    
    IBOutlet UILabel *label; //Sliderの値を表示するためのLabel
}

-(IBAction)convertImage; //画像を処理するメソッド

-(IBAction)undone; //元に戻すメソッド

-(IBAction)valueChanged;

-(IBAction)showCameraSheet;

@end
