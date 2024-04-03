#import "YakTongCollectionViewController.h"

@interface YakTongCollectionViewController ()
{
    NSMutableArray<MediItems *> * yakTongList;
}

@property (weak, nonatomic) IBOutlet UICollectionView *yakTongCollectionView;

@property (weak, nonatomic, nullable) FIRFirestore *db;

@end

@implementation YakTongCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initialSetting];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"yakTongDataReLoad" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"yakTongDataReLoad" object:nil];
}

-(void)initialSetting
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    
    [self setCollectionView];
    
    _db = [FIRFirestore firestore];
    
    [self getYakTongs];
}

#pragma mark InstanceMethods
- (void)getYakTongs
{
    [[[self.db collectionWithPath:@"yakTong"] queryOrderedByField:@"itemName" descending:(NO)]
     getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError *error) {
        if (error != nil) {
            NSLog(@"Error getting documents: %@", error);
            
        } else {
            NSMutableArray<MediItems *> * tempYakTongList = [NSMutableArray new];
            for (FIRDocumentSnapshot *document in snapshot.documents) {
                MediItems * tempMediItem = [[MediItems alloc] initWithSnapshot:document];
                [tempYakTongList addObject: tempMediItem];
            }
            
            self->yakTongList = tempYakTongList;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_yakTongCollectionView reloadData];
            });
        }
    }];
}

- (void)setCollectionView {
    _yakTongCollectionView.dataSource = self;
    _yakTongCollectionView.delegate = self;
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    [_yakTongCollectionView setCollectionViewLayout:flowLayout];
    [_yakTongCollectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_yakTongCollectionView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    UINib *cellNib = [UINib nibWithNibName:@"YakTongCollectionViewCell" bundle:nil];
    
    [_yakTongCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"YakTongCollectionViewCell"];
}

#pragma mark Selector Actions
- (void)handleNotification:(NSNotification *)notification
{
    NSLog(@"%s, line: %d, %@",__func__, __LINE__, @"");
    [self getYakTongs];
}



#pragma mark UICollectionView FlowLayout Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = UIScreen.mainScreen.bounds.size.width / 2 - (20);
    CGFloat height = width * 0.7;
    
    return CGSizeMake(width, height);
}
#pragma mark UICollectionViewDelegate
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MediInfoViewController" bundle:nil];
    
    MediInfoViewController * mediInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"MediInfoViewController"];
    
    mediInfoVC.mediItem = yakTongList[indexPath.item];
    
    [[self navigationController] pushViewController:mediInfoVC animated:YES];

}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return yakTongList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MediItems *cellData = [yakTongList objectAtIndex:indexPath.item];
    
    YakTongCollectionViewCell *cell = (YakTongCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"YakTongCollectionViewCell" forIndexPath:indexPath];
    
    [cell configureCellData:cellData];
    
    return cell;
}

@end
