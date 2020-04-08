//
//  Trie.m
//  Pods-Trie_Example
//
//  Created by 郭强 on 2020/4/7.
//

#import "Trie.h"

@interface Trie ()

@property (nonatomic,assign) NSInteger size;
@property (nonatomic,strong) Node *root;


@end

@implementation Trie

- (BOOL)isEmpty {
    return  self.size == 0;
}

- (void)clear {
    self.size = 0;
    self.root = nil;
    
}

- (NSObject *)get:(NSString *)key {
    Node *node = [self node:key];
    return node != nil && node.word ? node.value : nil;
}


- (BOOL)contains:(NSString *)key {
    Node *node = [self node:key];
    return node != nil && node.word;
}


- (Node *)node:(NSString *)key {
    [self keyCheck:key];
    Node *node = self.root;
    NSInteger len = key.length;
    for (int i = 0; i < len; i++) {
        if (node == nil || node.children == nil ) return nil;
        NSString * c = [NSString stringWithFormat:@"%d",[key characterAtIndex:i]] ;
        node = [node.children valueForKey:c];
    }
    return node;
}

- (NSObject *)add:(NSString *)key value:(NSObject *)value{
    [self keyCheck:key];
    
    if (self.root == nil) {
        self.root = [Node new];
    }
    
    Node *node = self.root;
    NSUInteger len = key.length;
    for (NSInteger i = 0; i < len; i++) {
        NSString * c = [NSString stringWithFormat:@"%d",[key characterAtIndex:i]] ;
        BOOL emptyChildren = node.children == nil;
        Node *childNode = emptyChildren ? nil : [node.children valueForKey:c];
        if (childNode == nil) {
            childNode = [Node new];
            childNode.character = c;
            node.children = emptyChildren ? [NSMutableDictionary dictionary] : node.children;
            [node.children setValue:childNode forKey:c];
        }
        node = childNode;
    }
    
    if (node.word) { // 已经存在这个单词
        NSObject *oldValue = node.value;
        node.value = value;
        return oldValue;
    }
    
    // 新增一个单词
    node.word = true;
    node.value = value;
    self.size++;
    return nil;
}

-(NSObject *)remove:(NSString *)key {
    // 找到最后一个节点
    Node *node = [self node:key];
    // 如果不是单词结尾，不用作任何处理
    if (node == nil || !node.word) return nil;
    self.size--;
    NSObject *oldValue = node.value;
    
    // 如果还有子节点
    if (node.children != nil ) {
        node.word = false;
        node.value = nil;
        return oldValue;
    }
    
    // 如果没有子节点
    Node *parent = nil;
    while ((parent = node.parent) != nil) {
        [parent.children removeObjectForKey:node.character];
        if (parent.word || [parent.children allKeys]) break;
        node = parent;
    }
    
    return oldValue;
}

- (BOOL)startsWith:(NSString *)prefix {
    return   [self node:prefix] != nil;
}

- (void)keyCheck:(NSString *)key {
    if (key == nil || key.length == 0) {
        @throw [NSException exceptionWithName:@"" reason:@"key must not be empty" userInfo:nil];
    }
}


@end



@interface Node ()

@end


@implementation Node

@end
