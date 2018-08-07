//
//  ViewController.m
//  happyDemo
//
//  Created by 刘汉琳 on 2018/8/4.
//  Copyright © 2018年 刘汉琳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ShowPictureResModel *dataModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"浏览页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupContentView];
//    [[RequestManager sharedInstance] requestRssDataSuccess:^(ShowPictureResModel *resModel) {
//        self.dataModel = resModel;
//        [self.collectionView reloadData];
//    } handleFailure:^(NSError *error) {
//
//    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData:)   name:@"SUCCESS" object:nil];
    
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)requestData:(NSNotification *)notifcation {
    self.dataModel = [notifcation object];
    [self.collectionView reloadData];

}

- (void)setupContentView {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark collectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        //flow
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //简单的写了个间隔数值，可根据需求调整
        flowLayout.itemSize = CGSizeMake((kscreenWidth - 36) / 2, (kscreenWidth - 36) / 2);
        flowLayout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight - 64) collectionViewLayout:flowLayout];
        _collectionView.collectionViewLayout = flowLayout;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = NO;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[ShowPictureCollectionViewCell class]  forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

#pragma mark UICollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataModel.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShowPictureCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ShowPictureItemModel *model = _dataModel.items[indexPath.row];
    BOOL preRequest = NO;
    ShowPictureItemModel *preModel = [ShowPictureItemModel new];

    if ([_dataModel.items count] - 10 > indexPath.row) {
        preRequest = YES;
        preModel = _dataModel.items[indexPath.row + 10]; //预加载当前后面的第十个
    }
    [cell bindDataWithModel:model needPreRequest:preRequest preModel:preModel];
    
    return cell;
}

#pragma mark CollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    ShowPictureCollectionViewCell *cell = (ShowPictureCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    ShowPrePictureView *preView = [[ShowPrePictureView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    ShowPictureItemModel *model = _dataModel.items[indexPath.row];
    preView.showImage = cell.imageView.image;
    preView.titleStr = model.title;
    preView.descStr = model.desc;
    [preView show];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
