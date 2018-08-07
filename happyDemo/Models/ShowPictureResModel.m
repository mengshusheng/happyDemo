//
//  ShowPictureResModel.m
//  happyDemo
//
//  Created by 刘汉琳 on 2018/8/4.
//  Copyright © 2018年 刘汉琳. All rights reserved.
//

#import "ShowPictureResModel.h"
#import "GDataXMLNode.h"

@implementation ShowPictureResModel

- (id)initWithRSSString:(NSString *)rssString
{
    if (self = [super init]) {
        // 使用 GDataXML 解析字符串
        GDataXMLDocument *XMLDocument = [[GDataXMLDocument alloc] initWithXMLString:rssString options:0 error:nil];
        GDataXMLElement *rssEle  = [XMLDocument rootElement];
        GDataXMLElement *rootEle = [[rssEle elementsForName:@"channel"] firstObject];
        self.title = [[[rootEle elementsForName:@"title"] objectAtIndex:0] stringValue];
        self.desc = [[[rootEle elementsForName:@"description"] objectAtIndex:0] stringValue];
        self.link = [[[rootEle elementsForName:@"link"] objectAtIndex:0] stringValue];
        self.atom = [[[rootEle elementsForName:@"atom"] objectAtIndex:0] stringValue];
        self.language = [[[rootEle elementsForName:@"language"] objectAtIndex:0] stringValue];
        self.managingEditor = [[[rootEle elementsForName:@"managingEditor"] objectAtIndex:0] stringValue];
        self.webMaster = [[[rootEle elementsForName:@"webMaster"] objectAtIndex:0] stringValue];
        self.docs = [[[rootEle elementsForName:@"docs"] objectAtIndex:0] stringValue];
        
        //2.拿到XML文件中根元素下需要解析的子元素数组
        NSArray *elements = [rootEle elementsForName:@"item"];
        self.items = [[NSMutableArray alloc] init];

        //3.对子元素数组中所有数据进行解析
        [elements enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            GDataXMLElement *XMLElement = (GDataXMLElement *)obj;
            ShowPictureItemModel *model = [[ShowPictureItemModel alloc] init];
            model.title = [[[XMLElement elementsForName:@"title"] objectAtIndex:0] stringValue];
            model.link = [[[XMLElement elementsForName:@"link"] objectAtIndex:0] stringValue];
            model.desc =  [[[XMLElement elementsForName:@"description"] objectAtIndex:0] stringValue];
            model.enclosure =  [[[[[[XMLElement elementsForName:@"enclosure"] objectAtIndex:0] attributeForName:@"url"] stringValue] stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
            model.guid =  [[[XMLElement elementsForName:@"guid"] objectAtIndex:0] stringValue];
            model.pubDate =  [[[XMLElement elementsForName:@"pubDate"] objectAtIndex:0] stringValue];
            model.source =  [[[XMLElement elementsForName:@"source"] objectAtIndex:0] stringValue];
            [self.items addObject:model];
        }];
        
    }
    
    return self;
}

@end

@implementation ShowPictureItemModel

@end
