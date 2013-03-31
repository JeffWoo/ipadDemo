//
//  PopoverActionChooser.m
//  Namecard
//
//  Created by Vincent Tam on 12-9-9.
//  Copyright (c) 2012年 Neon Studio. All rights reserved.
//

#import "PopoverActionChooser.h"

#define ScrollViewEdgePadding 10
#define ActionButtonPaddingX 4
#define ActionButtonPaddingY 4
#define ActionButtonSizeX 240
#define ActionButtonSizeY 144
#define maxColumns 3
#define maxRows 2


typedef struct { char page; char column; char row; } ActionIndexPath;
static ActionIndexPath actionIndexPathMake(char page, char column, char row) {
	ActionIndexPath aip;
	aip.page = page; aip.column = column; aip.row = row;
	return aip;
}


@interface PopoverCloseButton : UIButton
@end

@interface PopoverAlertSheetBackground : UIView
@property (nonatomic,retain) UIColor* fillColor;
@end

@interface PopoverActionChooserButton : UIButton
@property (nonatomic, retain) PopoverActionButton *dataSource;
- (id)initWithActionButton:(PopoverActionButton *)btn;
@end


@interface PopoverActionChooser ()
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIScrollView *buttonScroll;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) PopoverAlertSheetBackground *background;

- (void)actionButtonTapped:(PopoverActionChooserButton *)sender;
- (CGPoint)buttonCenterPoint:(ActionIndexPath)pos;
- (void)finishCloseAnimation;
@end


#pragma mark - Main Controller

@implementation PopoverActionChooser
@synthesize delegate = _delegate, title = _title, backgroundColor = _backgroundColor, shouldDrawShadow = _shouldDrawShadow, dismissAfterwards = _dismissAfterwards;
@synthesize buttonScroll = _buttonScroll, pageControl = _pageControl, titleLabel = _titleLabel, background = _background;

- (id)init
{
	self = [super initWithFrame:CGRectMake(0,0,299,262)];
	if (self) {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.opaque = NO;
		
		UIView *chooserView = [[UIView alloc]initWithFrame:CGRectMake(0,0,299,262)];
		chooserView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
		UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
		
		
		self.background = [[PopoverAlertSheetBackground alloc]initWithFrame:CGRectMake(0,7,299,255)];
		_background.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_background.backgroundColor = [UIColor clearColor];
		[chooserView addSubview:_background];
		[_background release];
		
		self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(24,12,252,22)];
		_titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
		_titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0f];
		_titleLabel.textAlignment = UITextAlignmentCenter;
		_titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
		_titleLabel.textColor = [UIColor whiteColor];
		_titleLabel.backgroundColor = [UIColor clearColor];
		[chooserView addSubview:_titleLabel];
		[_titleLabel release];
		
		self.buttonScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(10,39,279,193)];
		_buttonScroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_buttonScroll.backgroundColor = [UIColor clearColor];
		_buttonScroll.pagingEnabled = YES;
		_buttonScroll.showsHorizontalScrollIndicator = NO;
		_buttonScroll.delegate = self;
		[chooserView addSubview:_buttonScroll];
		[_buttonScroll release];
		
		self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(20,224,260,36)];
		_pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
		[_pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
		_pageControl.hidesForSinglePage = YES;
		[chooserView addSubview:_pageControl];
		[_pageControl release];
		
        
		PopoverCloseButton *closeButton = [[PopoverCloseButton alloc]initWithFrame:CGRectMake(0,0,25,25)];
		closeButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
		[closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
		[chooserView addSubview:closeButton];
		[closeButton release];
		
		
		[self addSubview:chooserView];
		[chooserView release];
		
		self.shouldDrawShadow = YES;
		self.dismissAfterwards = NO;
		
	}
	return self;
}

+ (id)actionChooserWithDelegate:(id<PopoverActionChooserDelegate>)dlg
{
	PopoverActionChooser *ogac = [[PopoverActionChooser alloc]init];
	ogac.delegate = dlg;
	[ogac setButtonsWithArray:nil];
	
	return [ogac autorelease];
}

- (void)dealloc
{
	[_titleLabel release];
	[_buttonScroll release];
	[_pageControl release];
	[_title release];
	[_background release];
	[super dealloc];
}

#pragma mark - Opening and Closing

- (void)presentInView:(UIView *)parentview
{
	self.frame = parentview.bounds;
	self.alpha = 0.0f;
	
	[parentview addSubview:self];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.15f];
	self.alpha = 1.0f;
	[UIView commitAnimations];
}

- (void)dismiss
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3f];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(finishCloseAnimation)];
	self.alpha = 0.0f;
	[UIView commitAnimations];
}

- (void)finishCloseAnimation
{
	if ([_delegate respondsToSelector:@selector(actionChooserFinished:)])
		[_delegate actionChooserFinished:self];
	[self removeFromSuperview];
}

#pragma mark - Getter / Setter

- (void)setTitle:(NSString *)aTitle { _titleLabel.text = aTitle; }

- (NSString *)title { return _titleLabel.text; }

- (UIColor *)backgroundColor { return _background.fillColor; }

- (void)setBackgroundColor:(UIColor *)bg { _background.fillColor = bg; }

- (void)setShouldDrawShadow:(BOOL)value
{
	if (_shouldDrawShadow != value) {
		_shouldDrawShadow = value;
		[self setNeedsDisplay];
	}
}

#pragma mark - Custom Methods

- (void)actionButtonTapped:(PopoverActionChooserButton *)sender
{
	int tg = sender.tag;
	ActionIndexPath indexPath = actionIndexPathMake(tg/100, (tg%100)/10, tg%10);
	int arrayIndex = indexPath.page*(maxColumns*maxRows)+(maxColumns*indexPath.row)+indexPath.column;
	
	BOOL _dismiss = _dismissAfterwards;
	
	#ifdef __BLOCKS__
	if ([sender.dataSource respondsToSelector:@selector(block)]) {
		if (sender.dataSource.block)
			sender.dataSource.block(sender.dataSource.title, &_dismiss);
	}
	#endif
	
	if (_delegate) {
		if ([_delegate respondsToSelector:@selector(actionChooser:buttonPressedWithIndex:)]) {
			[_delegate actionChooser:self buttonPressedWithIndex:arrayIndex];
		}
	}
	
	if (_dismiss) [self dismiss];
}

- (void)setButtonsWithArray:(NSArray*)buttons
{
	int numberOfButtons = buttons.count;
	int numberOfPages = ceilf((float)numberOfButtons/(maxColumns*maxRows));
	
	
	[_buttonScroll setContentSize:CGSizeMake(_buttonScroll.frame.size.width*numberOfPages, _buttonScroll.frame.size.height)];
	_pageControl.numberOfPages = numberOfPages;
	
	int page=-1, column=-1, row=-1;
	int i = 0;
	while (i<numberOfButtons) {
		
		column = ++column%3; //
		if (column == 0) {
			row = ++row%2;
			if (row == 0) {
				page++;
			}
		}
		PopoverActionButton *actBtn = [buttons objectAtIndex:i];
		
		if (actBtn && [actBtn isKindOfClass:[PopoverActionButton class]])
		{
			PopoverActionChooserButton *gacb = [[PopoverActionChooserButton alloc]initWithActionButton:actBtn];
			[gacb addTarget:self action:@selector(actionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
			
			gacb.center = [self buttonCenterPoint: actionIndexPathMake(page, column, row)];
			gacb.enabled = actBtn.enabled;
			gacb.tag = page*100 + column*10 + row;
			gacb.alpha = 0.9f;
			[_buttonScroll addSubview:gacb];
			[gacb release];
		}
		
		i++;
	}
}

- (CGPoint)buttonCenterPoint:(ActionIndexPath)pos
{ // first = 0,0,0
	// example: 10px + ((84+4)*column) + (84/2) + (scroll-width * page)
	float xpos = ScrollViewEdgePadding + ((ActionButtonSizeX+ActionButtonPaddingX)*pos.column) + (ActionButtonSizeX/2) + _buttonScroll.frame.size.width*pos.page;
	// example: ((94+4)*row) + (94/2)
	float ypos = ((ActionButtonSizeY+ActionButtonPaddingY)*pos.row) + (ActionButtonSizeY/2);
	
	return CGPointMake(xpos, ypos);
}

#pragma mark - Delegates and Page Control

- (void)pageControlChanged:(id)sender
{
	if (sender == _pageControl) {
		CGSize scrSize = _buttonScroll.frame.size;
		CGRect scrRect = CGRectMake(_pageControl.currentPage*scrSize.width, 0, scrSize.width, scrSize.height);
		[_buttonScroll scrollRectToVisible:scrRect animated:YES];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	if (_pageControl) {
		_pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
	}
}

#pragma mark - draw shadow / radial gradient

-(void)drawRect:(CGRect)rect
{
	if (!_shouldDrawShadow) return;
	
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	
	CGFloat colors[] = {
		0.1176f, 0.2235f, 0.3098f, 0.9f, // r30 g57 b79
		0.0f, 0.0f, 0.0f, 0.4f,
		0.0f, 0.0f, 0.0f, 0.0f
	};
	CGFloat locations[3] = {
		0.0f, 0.3f, 1.0f
	};
	CGGradientRef radGradient = CGGradientCreateWithColorComponents(rgb, colors, locations, 3);
	CGColorSpaceRelease(rgb);
	
	CGContextDrawRadialGradient(c, radGradient,
								CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)), 
								MAX(CGRectGetWidth(rect), CGRectGetHeight(rect)), 
								CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)), 
								0, 0);
	
	CGGradientRelease(radGradient);
}

@end



#pragma mark - ActionButton Object

@implementation PopoverActionButton
@synthesize title, image, enabled;

+ (id)buttonWithTitle:(NSString *)t imageName:(NSString *)n enabled:(BOOL)en
{
	return [PopoverActionButton buttonWithTitle:t image:[UIImage imageNamed:n] enabled:en];
}

+ (id)buttonWithTitle:(NSString *)t image:(UIImage *)i enabled:(BOOL)en
{
	PopoverActionButton *btn = [[super alloc]init];
	btn.title = t;
	btn.image = i;
	btn.enabled = en;
	return [btn autorelease];
}

#ifdef __BLOCKS__
@synthesize block;
+ (id)buttonWithTitle:(NSString *)t imageName:(NSString *)n enabled:(BOOL)en block:(buttonClicked)b
{
	PopoverActionButton *btn = [PopoverActionButton buttonWithTitle:t imageName:n enabled:en];
	btn.block = b;
	return btn;
}
+ (id)buttonWithTitle:(NSString *)t image:(UIImage *)i enabled:(BOOL)en block:(buttonClicked)b
{
	PopoverActionButton *btn = [PopoverActionButton buttonWithTitle:t image:i enabled:en];
	btn.block = b;
	return btn;
}
#endif

- (void)dealloc
{
	[title release];
	[image release];
	#ifdef __BLOCKS__
	[block release];
	#endif
	[super dealloc];
}
@end

#pragma mark - ActionChooserButton

@implementation PopoverActionChooserButton
@synthesize dataSource;
- (id)initWithActionButton:(PopoverActionButton*)btn
{
	self = [super initWithFrame:CGRectMake(0,0,ActionButtonSizeX,ActionButtonSizeY)];
	if (self) {
		self.dataSource = btn;
		
		[self setImage:dataSource.image forState:UIControlStateNormal];
		
//		UILabel *btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(2,83,ActionButtonSizeX-4,12)]; // 2px padding
//		btnLabel.textColor = [UIColor colorWithRed:0.0f green:0.25f blue:0.5f alpha:1.0f];
//		btnLabel.font = [UIFont fontWithName:@"Helvetica" size:10.0f];
//		btnLabel.textAlignment = UITextAlignmentCenter;
//		btnLabel.backgroundColor = [UIColor clearColor];
//		btnLabel.lineBreakMode = UILineBreakModeTailTruncation;
//		btnLabel.highlightedTextColor = [UIColor whiteColor];
//		btnLabel.text = dataSource.title;
//		[self addSubview:btnLabel];
//		[btnLabel release];
	}
	return self;
}
-(void)dealloc
{
	[dataSource release];
	[super dealloc];
}
@end


#pragma mark - Close-Button

@implementation PopoverCloseButton

- (void)drawRect:(CGRect)rect
{
	float radius = MIN(rect.size.width, rect.size.height)/2;
	float hWidth = CGRectGetMidX(rect);
	float hHeight = CGRectGetMidY(rect);
	float outerLineWidth = 1.0f;
	float x = radius*0.35;
	
	CGContextRef c = UIGraphicsGetCurrentContext();
	
	CGColorRef whiteColor = [(self.highlighted ? [UIColor lightGrayColor] : [UIColor whiteColor]) CGColor];
	CGColorRef blackColor = [[UIColor blackColor] CGColor];
	
	CGContextSetFillColorWithColor(c, whiteColor);
	CGContextSetStrokeColorWithColor(c, blackColor);
	CGContextSetLineWidth(c, outerLineWidth);
	CGContextMoveToPoint(c, hWidth + radius - outerLineWidth, hHeight);
	CGContextAddArc(c, hWidth, hHeight, radius - outerLineWidth, 0, 2*M_PI, false);
	CGContextDrawPath(c, kCGPathFillStroke);
	
	CGContextSetFillColorWithColor(c, blackColor);
	CGContextMoveToPoint(c, hWidth + (radius*0.75), hHeight);
	CGContextAddArc(c, hWidth, hHeight, radius*0.75, 0, 2*M_PI, false);
	CGContextDrawPath(c, kCGPathFill);
	
	CGContextSetStrokeColorWithColor(c, whiteColor);
	CGContextSetLineWidth(c, radius*0.2);
	CGContextMoveToPoint	(c, hWidth-x, hHeight-x); // x.
	CGContextAddLineToPoint	(c, hWidth+x, hHeight+x); // .x
	CGContextMoveToPoint	(c, hWidth+x, hHeight-x); // .x
	CGContextAddLineToPoint	(c, hWidth-x, hHeight+x); // x.	
	CGContextDrawPath(c, kCGPathStroke);
}

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
	[self setNeedsDisplay];
}

@end

#pragma mark - Alert Sheet Background

@implementation PopoverAlertSheetBackground

#define kEdgeRadius    16.0f
#define kEdgePadding   6.0f
#define kEdgeButtomPad 9.0f
#define kLineWidth     2.0f

@synthesize fillColor = _fillColor;

-(void)dealloc
{
	[_fillColor release];
	[super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.fillColor = [UIColor colorWithRed:17/255.0 green:25/255.0 blue:68/255.0 alpha:0.8];
    }
    return self;
}

-(void)setFillColor:(UIColor *)fillColor
{
	if (fillColor != _fillColor) {
		[_fillColor release];
		_fillColor = [fillColor retain];
		[self setNeedsDisplay];
	}
}

- (void)drawRect:(CGRect)rect
{
	float width = rect.size.width;
	float heigth = rect.size.height;
	float padEdge = kEdgeRadius+(kLineWidth/2);
	CGPoint p1 = CGPointMake(      kEdgePadding+padEdge, padEdge);// p1 p2
	CGPoint p2 = CGPointMake(width-kEdgePadding-padEdge, padEdge);// p4 p3
	CGPoint p3 = CGPointMake(width-kEdgePadding-padEdge, heigth-kEdgeButtomPad-padEdge);
	CGPoint p4 = CGPointMake(      kEdgePadding+padEdge, heigth-kEdgeButtomPad-padEdge);
	
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, p1.x, p1.y-kEdgeRadius);
	CGPathAddArcToPoint(path, NULL, p2.x+kEdgeRadius, p2.y-kEdgeRadius, p2.x+kEdgeRadius, p2.y, kEdgeRadius);
	CGPathAddArcToPoint(path, NULL, p3.x+kEdgeRadius, p3.y+kEdgeRadius, p3.x, p3.y+kEdgeRadius, kEdgeRadius);
	CGPathAddArcToPoint(path, NULL, p4.x-kEdgeRadius, p4.y+kEdgeRadius, p4.x-kEdgeRadius, p4.y, kEdgeRadius);
	CGPathAddArcToPoint(path, NULL, p1.x-kEdgeRadius, p1.y-kEdgeRadius, p1.x, p1.y-kEdgeRadius, kEdgeRadius);
	
	CGMutablePathRef glass = CGPathCreateMutable();
	CGPathMoveToPoint(glass, NULL, 0, 0);
	CGPathAddLineToPoint(glass, NULL, width, 0);
	CGPathAddLineToPoint(glass, NULL, width, heigth/12);
	CGPathAddQuadCurveToPoint(glass, NULL, width/2, heigth/6, 0, heigth/12);
	CGPathAddLineToPoint(glass, NULL, 0, 0);
	
	CGContextRef c = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(c);
	CGContextSetShadowWithColor(c, CGSizeMake(0, 5), 5.0, [[[UIColor blackColor] colorWithAlphaComponent:0.6]CGColor]);
	
	CGContextSetLineWidth(c, kLineWidth);
	CGContextSetStrokeColorWithColor(c, [[UIColor colorWithWhite:0.8f alpha:1.0] CGColor]);
	CGContextSetFillColorWithColor(c, [_fillColor CGColor]);
	
	CGContextBeginTransparencyLayer (c, NULL);
	CGContextAddPath(c, path);
	CGContextDrawPath(c, kCGPathFillStroke);
	CGContextEndTransparencyLayer(c);
	CGContextRestoreGState(c);
	
	CGContextAddPath(c, path);
	CGContextClip(c);
	CGContextAddPath(c, glass);
	CGContextClip(c);
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGFloat colors[] ={
		1.0, 1.0, 1.0, 0.4f,
		1.0, 1.0, 1.0, 0.15f
	};
	CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, 2);
	CGColorSpaceRelease(rgb);
	
	CGContextDrawLinearGradient(c, gradient, CGPointMake(0, 0), CGPointMake(0, heigth/8), kCGGradientDrawsAfterEndLocation);
	
	CGGradientRelease(gradient);
	CGPathRelease(path);
	CGPathRelease(glass);
}

@end
