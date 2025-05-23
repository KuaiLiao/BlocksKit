//
//  UIView+BlocksKit.m
//  BlocksKit
//

#import "UIView+BlocksKit.h"
#import "UIGestureRecognizer+BlocksKit.h"
#import "NSObject+BKAssociatedObjects.h"

@implementation UIView (BlocksKit)

- (void)setBk_beginGestureRecognizerState:(UIGestureRecognizerState)bk_beginGestureRecognizerState {
    [self bk_associateValue:@(bk_beginGestureRecognizerState) withKey:_cmd];
}

- (UIGestureRecognizerState)bk_beginGestureRecognizerState {
    NSNumber *value = [self bk_associatedValueForKey:@selector(setBk_beginGestureRecognizerState:)];
    if (value) {
        return value.integerValue;
    }
    return UIGestureRecognizerStateRecognized;
}

- (void)bk_whenTouches:(NSUInteger)numberOfTouches tapped:(NSUInteger)numberOfTaps handler:(void (^)(void))block
{
	if (!block) return;
    self.userInteractionEnabled = YES;
	UITapGestureRecognizer *gesture = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
		if (state == self.bk_beginGestureRecognizerState) block();
	}];
	
	gesture.numberOfTouchesRequired = numberOfTouches;
	gesture.numberOfTapsRequired = numberOfTaps;

	[self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		if (![obj isKindOfClass:[UITapGestureRecognizer class]]) return;

		UITapGestureRecognizer *tap = obj;
		BOOL rightTouches = (tap.numberOfTouchesRequired == numberOfTouches);
		BOOL rightTaps = (tap.numberOfTapsRequired == numberOfTaps);
		if (rightTouches && rightTaps) {
			[gesture requireGestureRecognizerToFail:tap];
		}
	}];

	[self addGestureRecognizer:gesture];
}

- (void)bk_whenTapped:(void (^)(void))block
{
    self.bk_beginGestureRecognizerState = UIGestureRecognizerStatePossible;
	[self bk_whenTouches:1 tapped:1 handler:block];
}

- (void)bk_whenDoubleTapped:(void (^)(void))block
{
	[self bk_whenTouches:1 tapped:2 handler:block];
}

- (void)bk_eachSubview:(void (^)(UIView *subview))block
{
	NSParameterAssert(block != nil);

	[self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
		block(subview);
	}];
}

@end
