//
//  NSMutableDictionary+BlocksKit.h
//  BlocksKit
//

#import <Foundation/Foundation.h>
#if __has_include(<BlocksKit/BKDefines.h>)
#import <BlocksKit/BKDefines.h>
#else
#import "BKDefines.h"
#endif

NS_ASSUME_NONNULL_BEGIN

/** Block extensions for NSMutableDictionary.

 These utilities expound upon the BlocksKit additions to the immutable
 superclass by allowing certain utilities to work on an instance of the mutable
 class, saving memory by not creating an immutable copy of the results.

 Includes code by the following:

 - [Martin Schürrer](https://github.com/MSch)
 - [Zach Waldowski](https://github.com/zwaldowski)

 @see NSDictionary(BlocksKit)
 */
@interface __GENERICS(NSMutableDictionary, KeyType, ObjectType) (BlocksKit)

/** Filters a mutable dictionary to the key/value pairs matching the block.

 @param block A BOOL-returning code block for a key/value pair.
 @see <NSDictionary(BlocksKit)>bk_reject:
 */
- (void)bk_performSelect:(BOOL (^)(KeyType key, ObjectType obj))block;

/** Filters a mutable dictionary to the key/value pairs not matching the block,
 the logical inverse to bk_select:.

 @param block A BOOL-returning code block for a key/value pair.
 @see <NSDictionary(BlocksKit)>bk_select:
 */
- (void)bk_performReject:(BOOL (^)(KeyType key, ObjectType obj))block;

/** Transform each value of the dictionary to a new value, as returned by the
 block.

 @param block A block that returns a new value for a given key/value pair.
 @see <NSDictionary(BlocksKit)>bk_map:
 */
- (void)bk_performMap:(id (^)(KeyType key, ObjectType obj))block;

@end

NS_ASSUME_NONNULL_END
