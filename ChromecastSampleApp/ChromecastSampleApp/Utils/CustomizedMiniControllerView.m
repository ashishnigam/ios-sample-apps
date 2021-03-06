//
//  CustomizedMiniControllerView.m
//  OoyalaChromecastSampleApp
//
//  Created by Liusha Huang on 9/25/14.
//  Copyright (c) 2014 Liusha Huang. All rights reserved.
//

#import "CustomizedMiniControllerView.h"
#import <OoyalaCastSDK/OOChromecastPlugin.h>
#import <OoyalaCastSDK/OOChromecastPlayer.h>

@interface CustomizedMiniControllerView()

@property(nonatomic, strong) OOChromecastPlugin *castPlugin;

@property(nonatomic, strong) UIImage *playImage;
@property(nonatomic, strong) UIImage *pauseImage;
@end

@implementation CustomizedMiniControllerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame castPlugin:(OOChromecastPlugin *)castPlugin
{
  self = [super initWithFrame:frame];
  if (self) {
    self.castPlugin = castPlugin;
    self.cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    self.cell.backgroundColor = [UIColor lightGrayColor];
    self.cell.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.cell.textLabel.text = self.castPlugin.castPlayer.castItemTitle;
    self.cell.detailTextLabel.text = self.castPlugin.castPlayer.castItemTitle;
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Accessory is the play/pause button.
    self.pauseImage = [UIImage imageNamed:@"pause.png"];
    self.playImage = [UIImage imageNamed:@"play.png"];
    BOOL playing = (self.castPlugin.castPlayer.state == OOOoyalaPlayerStatePlaying ||
                    self.castPlugin.castPlayer.state == OOOoyalaPlayerStateLoading);
    UIImage *buttonImage = (playing ? self.pauseImage : self.playImage);
    CGRect buttonFrame = CGRectMake(0, 0,  self.frame.size.height * 2 / 3, self.frame.size.height * 2 / 3);
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(playPausePressed:)
     forControlEvents:UIControlEventTouchUpInside];
    self.cell.accessoryView = button;


    UIImageView *mediaThumb = self.cell.imageView;
    [mediaThumb setImage:[UIImage imageNamed:@"ooyala_logo.png"]];
    [self.cell setNeedsLayout];
    [self addSubview:self.cell];
  }
  return self;
}

- (void)playPausePressed:(id)sender {
  if (self.castPlugin.castPlayer.state == OOOoyalaPlayerStatePlaying) {
    [self.castPlugin.castPlayer pause];
  } else {
    [self.castPlugin.castPlayer play];
  }

}

- (void)updatePlayState:(BOOL)isPlaying {
  UIImage *buttonImage;
  if (isPlaying) {
    buttonImage = self.pauseImage;
  } else {
    buttonImage = self.playImage;
  }
  // change the icon.
  [((UIButton *)self.cell.accessoryView) setBackgroundImage:buttonImage forState:UIControlStateNormal];
}


@end
