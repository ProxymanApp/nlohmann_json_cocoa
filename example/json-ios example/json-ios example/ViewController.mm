//
//  ViewController.m
//  json-ios example
//
//  Created by Ben Manashirov on 7/5/18.
//  Copyright © 2018 no org. All rights reserved.
//

#import "ViewController.h"
#include <json.hpp>
#include <string>

@interface ViewController ()

@end

const char *test_str = R"(
[
	{
		color: "red",
		value: "#f00"
	},
	{
		color: "green",
		value: "#0f0"
	},
	{
		color: "blue",
		value: "#00f"
	},
	{
		color: "cyan",
		value: "#0ff"
	},
	{
		color: "magenta",
		value: "#f0f"
	},
	{
		color: "yellow",
		value: "#ff0"
	},
	{
		color: "black",
		value: "#000"
	}
]

)";

    // because everyone has their own timer functions we'll include it here
    // so it's easier to move this class arround from project to project.
    class Timer
    {
    public:
        Timer() : beg_(clock_::now()) {}
        void reset() { beg_ = clock_::now(); }
        double elapsed() {
            double seconds = std::chrono::duration_cast<second_>
            (clock_::now() - beg_).count();

            if(seconds < mLastReport) {
                seconds = mLastReport;
            } else {
                mLastReport = seconds;
            }

            return seconds;
        }

    private:
        typedef std::chrono::high_resolution_clock clock_;
        typedef std::chrono::duration<double, std::ratio<1> > second_;
        std::chrono::time_point<clock_> beg_;
        double mLastReport = 0;
    };


    double monotonicSeconds(){
        static Timer *timer = nullptr;

        if(timer == nullptr){
            timer = new Timer();
        }
        return timer->elapsed();
    }

    class MeasureTimer {
    public:
        MeasureTimer() {
            start();
        }
        void start() {
            mRef = monotonicSeconds();
        }
        double seconds() {
            return monotonicSeconds() - mRef;
        }
    private:
        double mRef;

    };

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    nlohmann::json yay = nlohmann::json::parse(R"(
        {
            "food": "is great"

        }
    )");

    std::string result = yay["food"];
    NSLog(@"food = %s", result.c_str());
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) serialize:(id)sender {
    MeasureTimer timer;
    for(int i = 0; i < 1000; ++i) {
        nlohmann::json yay = nlohmann::json::parse(test_str);
    }
    double seconds = timer.seconds();
    NSLog(@"1000 serializations = %lf, %lf hz", seconds, 1000/seconds);
}

- (IBAction) stringify:(id)sender {
    nlohmann::json yay = nlohmann::json::parse(test_str);

    MeasureTimer timer;
    for(int i = 0; i < 1000; ++i) {
        std::string serial = yay.dump(4);
    }
    double seconds = timer.seconds();
    NSLog(@"1000 stringify = %lf, %lf hz", seconds, 1000/seconds);

}

@end
