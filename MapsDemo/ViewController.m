//
//  ViewController.m
//  MapsDemo
//
//  Created by Piervincenzo Parisi on 15/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "NetworkingUtils.h"
#import "PointOfInterest.h"
#import "UIViewController+AlertInterface.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableEntries;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.segmentedControl setSelectedSegmentIndex:0];
    
    //http://www.viaggi-lowcost.info/api/viaggi_low_cost/get_posts/?destination_id=212

    [NetworkingUtils loadJsonDataFromEndPoint:@"get_posts/" responseClass:[PointOfInterest class] params: @{
                                                                                               @"destination_id" : @"212"
                                                                                               }
                            completionHandler:^(Response *response)
     {
         self.tableEntries = response.points.mutableCopy;
         dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];});
     }
                               failureHandler:^(NSError *error)
     {
         [self showAlertWithError:error];
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UISegmentedControl

- (IBAction)segmentedControlValueChanged:(id)sender {
    if (sender == self.segmentedControl)
    {
        NSInteger selectedSegment = self.segmentedControl.selectedSegmentIndex;
        
        if (selectedSegment == 0)
        {
            [self.mapView setHidden:NO];
            [self.tableView setHidden:YES];
        }
        else
        {
            [self.mapView setHidden:YES];
            [self.tableView setHidden:NO];
        }
    }
    else if (sender == self.tableView)
    {
        [self.segmentedControl setSelectedSegmentIndex:0];
        [self.mapView setHidden:NO];
        [self.tableView setHidden:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    PointOfInterest *poi = [self.tableEntries objectAtIndex:indexPath.row];
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = poi.address;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.mapView removeAnnotations:self.mapView.annotations]; // per mostare una sola annotation per volta
    PointOfInterest *poi = [self.tableEntries objectAtIndex:indexPath.row];
    [self segmentedControlValueChanged:(id)tableView];
    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake([poi.latitude doubleValue] , [poi.longitude doubleValue]);
    MKPointAnnotation *pointAnnotation = [MKPointAnnotation new];
    [pointAnnotation setCoordinate:coordinates];
    pointAnnotation.title = poi.name;
    pointAnnotation.subtitle = poi.address;
    id annotationView = [self mapView:self.mapView viewForAnnotation:pointAnnotation];
    [self.mapView addAnnotation:annotationView];
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}

#pragma mark - MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // TODO usare dequeueReusableAnnotationViewWithIdentifier
    return [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@""];
}

@end
