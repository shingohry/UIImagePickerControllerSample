//
//  ViewController.m
//  UIImagePickerControllerSample
//
//  Created by hiraya.shingo on 2014/10/03.
//  Copyright (c) 2014年 hiraya.shingo. All rights reserved.
//

#import "ViewController.h"

@import Photos;
@import CoreLocation;

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/**
 撮影日を表示するラベル
 */
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

/**
 お気に入り設定情報を表示するラベル
 */
@property (weak, nonatomic) IBOutlet UILabel *favoritelabel;

/**
 取得した写真を表示するImageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)selectImageButtonDidTouch:(id)sender
{
    // PhotoLibraryから写真を選択するためのUIImagePickerControllerを作成し、表示する
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // UIImagePickerControllerで選択された写真を取得する
    self.imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Assets Library frameworkによって提供されるURLを取得する
    NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    // 取得したURLを使用して、PHAssetを取得する
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithALAssetURLs:@[url,] options:nil];
    PHAsset *asset = fetchResult.firstObject;
    
    // ラベルのテキストを更新する
    self.dateLabel.text = asset.creationDate.description;
    self.favoritelabel.text = (asset.favorite ? @"registered Favorites" : @"not registered Favorites");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
     
@end
