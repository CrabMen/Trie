//
//  Trie.h
//  Pods-Trie_Example
//
//  Created by 郭强 on 2020/4/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Trie : NSObject


- (NSInteger)size;

- (BOOL)isEmpty;

- (NSObject *)add:(NSString *)key value:(NSObject *)value;

-(NSObject *)remove:(NSString *)key;
- (NSObject *)get:(NSString *)key;

- (BOOL)contains:(NSString *)key;

- (BOOL)startsWith:(NSString *)prefix;

- (void)clear;


@end


@interface Node : NSObject

@property (nonatomic,strong) Node *parent;
@property (nonatomic,copy) NSMutableDictionary *children;
@property (nonatomic,strong) NSString *character;
@property (nonatomic,strong) NSObject *value;
@property (nonatomic,assign) BOOL word;

@end

NS_ASSUME_NONNULL_END
