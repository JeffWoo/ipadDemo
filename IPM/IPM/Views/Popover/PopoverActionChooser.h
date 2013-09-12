//
//  PopoverActionChooser.h
//  Namecard
//
//  Created by Vincent Tam on 12-9-9.
//  Copyright (c) 2012年 Neon Studio. All rights reserved.
//

#ifdef __BLOCKS__
typedef void(^buttonClicked)(NSString *title, BOOL *dismiss);
#endif

@interface PopoverActionButton : NSObject {}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, assign) BOOL enabled;
#ifdef __BLOCKS__
@property (nonatomic, copy) buttonClicked block;
+ (id)buttonWithTitle:(NSString*)t image:(UIImage*)i enabled:(BOOL)en block:(buttonClicked)b;
+ (id)buttonWithTitle:(NSString*)t imageName:(NSString*)n enabled:(BOOL)en block:(buttonClicked)b;
#endif
+ (id)buttonWithTitle:(NSString*)t image:(UIImage*)i enabled:(BOOL)en;
+ (id)buttonWithTitle:(NSString*)t imageName:(NSString*)n enabled:(BOOL)en;
@end

@protocol PopoverActionChooserDelegate; 

@interface PopoverActionChooser : UIView <UIScrollViewDelegate>
@property (nonatomic, assign) id<PopoverActionChooserDelegate> delegate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, retain) UIColor *backgroundColor; // r17 g25 b68 a0.8
@property (nonatomic) BOOL shouldDrawShadow; // YES
@property (nonatomic) BOOL dismissAfterwards; // NO

+ (id)actionChooserWithDelegate:(id<PopoverActionChooserDelegate>)dlg;
- (void)setButtonsWithArray:(NSArray*)buttons;
- (void)presentInView:(UIView*)parentview;
- (void)dismiss;
@end

@protocol PopoverActionChooserDelegate <NSObject>
@optional
- (void)actionChooser:(PopoverActionChooser *)ac buttonPressedWithIndex:(NSInteger)index;
- (void)actionChooserFinished:(PopoverActionChooser *)ac;
@end
