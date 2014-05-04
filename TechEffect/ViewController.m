//
//  ViewController.m
//  TechEffect
//
//  Created by Paul McCartney on 2014/05/04.
//  Copyright (c) 2014年 羽柴彩月. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //元の画像を表示させる
    [imageView setImage:[UIImage imageNamed:@"photoshiba.png"]];
    
    slider.maximumValue = 1.0f; //最大値
    slider.minimumValue = 0.0f; //最小値
    slider.value = 0.0f; //初期値
    
    //Sliderの値（float型）をLabelに表示する（小数点以下1桁を表示）
    label.text = [NSString stringWithFormat:@"%.1f", slider.value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)convertImage{
    
    //元画像を取得
    originImage = [UIImage imageNamed:@"photoshiba.png"];
    NSLog(@"取得したよ");
    
    //UIImageをCIImageに変換
    filteredImage = [[CIImage alloc] initWithCGImage:originImage.CGImage];
    NSLog(@"変換したよ");
    
    //CIFilterを作成（今回は、モノクロ風のフィルタを設定）
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"];
    [filter setValue:filteredImage forKey:@"inputImage"];
    NSLog(@"設定したよ");
    
    //Sliderの値に応じてフィルタの強度が設定される
    [filter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputIntensity"];
    NSLog(@"設定されたよ");
    
    //フィルタ後の画像を取得
    filteredImage = filter.outputImage;
    NSLog(@"また取得したよ");
    
    //CIImageをUIImageに変換する
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [ciContext createCGImage:filteredImage
                                          fromRect:[filteredImage extent]];

    
    outputImage = [UIImage imageWithCGImage:imageRef
                                      scale:1.0f
                                orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    
    //画像を表示する
    [imageView setImage:outputImage];
}

-(IBAction)undone{
    //元の画像を表示させる
    [imageView setImage:[UIImage imageNamed:@"photoshiba.png"]];
    slider.value = 0.0f;
    label.text = [NSString stringWithFormat:@"%.1f", slider.value];
}

-(IBAction)valueChanged{
    
    //Sliderの値（float型）をLabelに表示する（小数点以下1桁を表示）
    label.text = [NSString stringWithFormat:@"%.1f", slider.value];
    
    //convertImageメソッドを呼び出す
    [self performSelector:@selector(convertImage) withObject:nil];
}

-(IBAction)showCameraSheet{
    //アクションシートを作る
    UIActionSheet* sheet;
    sheet=[[UIActionSheet alloc]
           initWithTitle:@"Select Soruce Type"
           delegate:self
           cancelButtonTitle:@"Cancel"
           destructiveButtonTitle:nil
           otherButtonTitles:@"Photo Librare",@"Camera",@"Saved Photos",nil];
    
    //アクションシートを表示する
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}
@end
