//
//  AYTextHelper.m
//  AYCommon
//
//  Created by 张书孟 on 2018/5/17.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "AYTextHelper.h"

@interface AYTextHelper()

@property (nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong) NSLayoutManager *layoutManager;
@property (nonatomic, strong) NSTextContainer *textContainer;

@end

@implementation AYTextHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textStorage = [NSTextStorage new];
        self.layoutManager = [NSLayoutManager new];
        self.textContainer = [NSTextContainer new];
        [self.textStorage addLayoutManager:self.layoutManager];
        [self.layoutManager addTextContainer:self.textContainer];
    }
    return self;
}

- (void)selectorLocation:(CGPoint)location label:(UILabel *)label selectedBlock:(void (^)(NSInteger index, NSAttributedString *charAttributedString))selectedBlock
{
    self.textContainer.size = label.bounds.size;
    self.textContainer.lineFragmentPadding = 0;
    self.textContainer.maximumNumberOfLines = label.numberOfLines;
    self.textContainer.lineBreakMode = label.lineBreakMode;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]  initWithAttributedString:label.attributedText];
    NSRange textRange = NSMakeRange(0, attributedText.length);
    [attributedText addAttribute:NSFontAttributeName value:label.font range:textRange];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = label.textAlignment;
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    [self.textStorage setAttributedString:attributedText];
    
    CGSize textSize = [self.layoutManager usedRectForTextContainer:self.textContainer].size;
    location.y -= (CGRectGetHeight(label.frame) - textSize.height) / 2;
    
    NSUInteger glyphIndex = [self.layoutManager glyphIndexForPoint:location inTextContainer:self.textContainer];
    CGFloat fontPointSize = label.font.pointSize;
    [self.layoutManager setAttachmentSize:CGSizeMake(fontPointSize, fontPointSize) forGlyphRange:NSMakeRange(label.text.length - 1, 1)];
    
    NSAttributedString *attributedSubstring = [label.attributedText attributedSubstringFromRange:NSMakeRange(glyphIndex, 1)];
    CGRect glyphRect = [self.layoutManager boundingRectForGlyphRange:NSMakeRange(glyphIndex, 1) inTextContainer:self.textContainer];
    
    if (!CGRectContainsPoint(glyphRect, location)) {
        if (CGRectContainsPoint(CGRectMake(0, 0, textSize.width, textSize.height), location)) {
        }
        selectedBlock(-1,nil);
        return;
    }
    selectedBlock(glyphIndex,attributedSubstring);
}

@end
