//
//  CalendarViewController.m
//  waiter
//
//  Created by new on 2017/4/14.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarDataModel.h"
#import "CalendarCollectionCell.h"
#import "CalendarReusableViewCell.h"
static NSString * collectionCell = @"cell";
static NSString * collectionReusableCell = @"reusableCell";
@interface CalendarViewController ()
@property(nonatomic,assign)NSInteger selectYear;
@property(nonatomic,assign)NSInteger selecMonth;
@property(nonatomic,assign)NSInteger selectDay;
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self collectionViewLayout];
    [self getData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    
    NSDate * selectDate = nil;
    if (self.selectDateString == nil)
        selectDate = [NSDate date];
    else
        selectDate = [CalendarDataUtil dateFromString:self.selectDateString];
    
    self.selectYear = [CalendarDataUtil year:selectDate];
    self.selecMonth = [CalendarDataUtil month:selectDate];
    self.selectDay = [CalendarDataUtil day:selectDate];
    self.dataArray = [[NSMutableArray alloc]init];
}

- (void)getData {
    [CalendarDataModel getCalenderStartDate:[CalendarDataUtil dateFromString:@"2016-01-01"] WithEndDate:[NSDate date] block:^(NSMutableArray *result) {
        [self.dataArray addObjectsFromArray:result];
        [self.collectionView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
          [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height - self.collectionView.height)];
            
        });
    }];
    
    
}
#pragma mark - collectionView Constraints
-(void)updateViewConstraints{
    [super updateViewConstraints];
    //设置item的宽高
    self.collectionLayout.itemSize=CGSizeMake(kScreenWidth / 7, kScreenWidth / 7);
    self.collectionLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 40);
    
}

-(void)collectionViewLayout{
    
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[CalendarReusableViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionReusableCell];
    [self.collectionView registerClass:[CalendarCollectionCell class] forCellWithReuseIdentifier:collectionCell];
    
    
}

#pragma mark - collectionView Delegate DataSource

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == self.dataArray.count-1)
        return CGSizeMake(kScreenWidth, 50);
    else
       return CGSizeMake(0, 0);

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    CalendarDataModel * model = self.dataArray[section];
    return model.details.count + model.firstday;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
     CalendarCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    cell.dateLabel.text = @"";
    cell.isSelect = NO;
    CalendarDataModel * model = self.dataArray[indexPath.section];
    if (indexPath.row >= model.firstday) {
        NSInteger index = indexPath.item - model.firstday;
        CalenderDateSubModel * subModel = model.details[index];
        cell.dateLabel.text = [NSString stringWithFormat:@"%ld",(long)subModel.day];
        
        if ((model.year == self.selectYear) && (model.month == self.selecMonth) && (subModel.day == self.selectDay))  {
            cell.isSelect = YES;
        }
        cell.dateLabel.textColor = [UIColor blackColor];
        if (indexPath.section == self.dataArray.count - 1 && indexPath.row == model.details.count + model.firstday - 1) {
            cell.dateLabel.textColor = RGBA(42, 160, 235, 1);
        }
    }
    
    
    
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CalendarReusableViewCell * reusableCell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionReusableCell forIndexPath:indexPath];
    
    CalendarDataModel * model = self.dataArray[indexPath.section];
    reusableCell.dateLabel.text = [NSString stringWithFormat:@"%ld年%ld月",model.year, model.month];
    return reusableCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CalendarDataModel * model = self.dataArray[indexPath.section];
    
    
    if (indexPath.row >= model.firstday) {
        NSInteger index = indexPath.item - model.firstday;
        CalenderDateSubModel * subModel = model.details[index];
        self.selectYear = model.year;
        self.selecMonth = model.month;
        self.selectDay = subModel.day;
        NSLog(@"%ld-%ld-%ld",(long)self.selectYear,(long)self.selecMonth,(long)self.selectDay);
        [self.collectionView reloadData];
    }
    
}
//选择日期完成
- (IBAction)SureButtonClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(calendarSelectDateString:)]) {
        NSString * month = self.selecMonth < 10 ? [NSString stringWithFormat:@"0%ld",(long)self.selecMonth] : [NSString stringWithFormat:@"%ld",(long)self.selecMonth];
        NSString * day = self.selectDay < 10 ? [NSString stringWithFormat:@"0%ld",(long)self.selectDay] : [NSString stringWithFormat:@"%ld",(long)self.selectDay];
        [self.delegate calendarSelectDateString:[NSString stringWithFormat:@"%ld-%@-%@",(long)self.selectYear,month,day]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
