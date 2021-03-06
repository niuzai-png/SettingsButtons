#import <Cephei/HBPreferences.h>
#import <HBLog.h>
#import "SparkColourPickerUtils.h"
#import "SparkColourPickerView.h"
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
#import <spawn.h>
#import <AVKit/AVKit.h>
#import "NSTask.h"

UIViewController *respringPopController;
UIViewController *safeModePopController;
UIViewController *ldrestartPopController;
UIViewController *lpmPopController;

@interface RespringViewController : UIViewController <UIPopoverPresentationControllerDelegate>
@end

@implementation RespringViewController
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone;
}
@end

@interface SafeModeViewController : UIViewController <UIPopoverPresentationControllerDelegate>
@end

@implementation SafeModeViewController
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone;
}
@end

@interface ldrestartViewController : UIViewController <UIPopoverPresentationControllerDelegate>
@end

@implementation ldrestartViewController
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone;
}
@end

@interface lpmViewController : UIViewController <UIPopoverPresentationControllerDelegate>
@end

@implementation lpmViewController
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone;
}
@end

@interface PSUIPrefsListController : UIViewController
- (void)respringYesGesture:(UIButton *)sender;
- (void)respringNoGesture:(UIButton *)sender;
- (void)respring:(UIButton *)sender;
- (void)safeModeYesGesture:(UIButton *)sender;
- (void)safeModeNoGesture:(UIButton *)sender;
- (void)safeMode:(UIButton *)sender;
- (void)darkMode:(UIButton *)sender;
- (void)flashLight:(UIButton *)sender;
- (void)ldrestartYesGesture:(UIButton *)sender;
- (void)ldrestartNoGesture:(UIButton *)sender;
- (void)ldrestart:(UIButton *)sender;
@end

@interface UISUserInterfaceStyleMode : NSObject
@property (nonatomic, assign) long long modeValue;
@end

@interface UIColor (Private)
+ (id)tableCellGroupedBackgroundColor;
@end

@interface _CDBatterySaver
-(id)batterySaver;
-(BOOL)setPowerMode:(long long)arg1 error:(id *)arg2;
@end

%hook PSUIPrefsListController

- (void)viewDidLoad {
    %orig;
    
    UIButton *respringButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    respringButton.frame = CGRectMake(0,0,30,30);
    respringButton.layer.cornerRadius = respringButton.frame.size.height / 2;
    respringButton.layer.masksToBounds = YES;
    
    respringButton.backgroundColor = [UIColor tableCellGroupedBackgroundColor];
    
    [respringButton setImage:[UIImage systemImageNamed:@"staroflife.fill"] forState:UIControlStateNormal];
    
    [respringButton addTarget:self action:@selector(respring:) forControlEvents:UIControlEventTouchUpInside];
    
    respringButton.tintColor = [UIColor labelColor];
    
    UIBarButtonItem *respringButtonItem = [[UIBarButtonItem alloc] initWithCustomView:respringButton];
    
    UIButton *safeModeButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    safeModeButton.frame = CGRectMake(0,0,30,30);
    safeModeButton.layer.cornerRadius = safeModeButton.frame.size.height / 2;
    safeModeButton.layer.masksToBounds = YES;

    safeModeButton.backgroundColor = [UIColor tableCellGroupedBackgroundColor];

    [safeModeButton setImage:[UIImage systemImageNamed:@"exclamationmark.shield.fill"] forState:UIControlStateNormal];
    
    [safeModeButton addTarget:self action:@selector(safeMode:) forControlEvents:UIControlEventTouchUpInside];

    safeModeButton.tintColor = [UIColor labelColor];
    
    UIBarButtonItem *safeModeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:safeModeButton];
    
    UIButton *darkModeButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    darkModeButton.frame = CGRectMake(0,0,30,30);
    darkModeButton.layer.cornerRadius = darkModeButton.frame.size.height / 2;
    darkModeButton.layer.masksToBounds = YES;

    darkModeButton.backgroundColor = [UIColor tableCellGroupedBackgroundColor];

    [darkModeButton setImage:[UIImage systemImageNamed:@"circle.righthalf.fill"] forState:UIControlStateNormal];
    [darkModeButton addTarget:self action:@selector(darkMode:) forControlEvents:UIControlEventTouchUpInside];
    
    darkModeButton.tintColor = [UIColor labelColor];
    
    UIBarButtonItem *darkModeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:darkModeButton];
    
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    space.width = 2;

    NSArray *rightButtons = @[space, respringButtonItem, space, safeModeButtonItem, space, darkModeButtonItem, space];
    
    self.navigationItem.rightBarButtonItems = rightButtons;
    
    UIButton *flashLightButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    flashLightButton.frame = CGRectMake(0,0,30,30);
    flashLightButton.layer.cornerRadius = flashLightButton.frame.size.height / 2;
    flashLightButton.layer.masksToBounds = YES;

    flashLightButton.backgroundColor = [UIColor tableCellGroupedBackgroundColor];

    [flashLightButton setImage:[UIImage systemImageNamed:@"bolt.fill"] forState:UIControlStateNormal];
    [flashLightButton addTarget:self action:@selector(flashLight:) forControlEvents:UIControlEventTouchUpInside];
    
    flashLightButton.tintColor = [UIColor labelColor];
    
    UIBarButtonItem *flashLightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:flashLightButton];
    
    UIButton *ldrestartButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    ldrestartButton.frame = CGRectMake(0,0,30,30);
    ldrestartButton.layer.cornerRadius = ldrestartButton.frame.size.height / 2;
    ldrestartButton.layer.masksToBounds = YES;

    ldrestartButton.backgroundColor = [UIColor tableCellGroupedBackgroundColor];

    [ldrestartButton setImage:[UIImage systemImageNamed:@"exclamationmark.circle.fill"] forState:UIControlStateNormal];
    [ldrestartButton addTarget:self action:@selector(ldrestart:) forControlEvents:UIControlEventTouchUpInside];
    
    ldrestartButton.tintColor = [UIColor labelColor];
    
    UIBarButtonItem *ldrestartButtonItem = [[UIBarButtonItem alloc] initWithCustomView:ldrestartButton];
    
    UIButton *lpmButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    lpmButton.frame = CGRectMake(0,0,30,30);
    lpmButton.layer.cornerRadius = lpmButton.frame.size.height / 2;
    lpmButton.layer.masksToBounds = YES;

    lpmButton.backgroundColor = [UIColor tableCellGroupedBackgroundColor];

    [lpmButton setImage:[UIImage systemImageNamed:@"battery.25"] forState:UIControlStateNormal];
    [lpmButton addTarget:self action:@selector(lpm:) forControlEvents:UIControlEventTouchUpInside];
    
    lpmButton.tintColor = [UIColor labelColor];
    
    UIBarButtonItem *lpmButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lpmButton];

    NSArray *leftButtons = @[space, lpmButtonItem, space, ldrestartButtonItem, space, flashLightButtonItem, space];
    
    self.navigationItem.leftBarButtonItems = leftButtons;
}

%new
- (void)respring:(UIButton *)sender {
    
    respringPopController = [[UIViewController alloc] init];
    respringPopController.modalPresentationStyle = UIModalPresentationPopover;
    respringPopController.preferredContentSize = CGSizeMake(200,130);

    UILabel *respringLabel = [[UILabel alloc] init];
    respringLabel.frame = CGRectMake(10, 20, 180, 60);
    respringLabel.numberOfLines = 2;
    respringLabel.textAlignment = NSTextAlignmentCenter;
    respringLabel.adjustsFontSizeToFitWidth = YES;
    respringLabel.font = [UIFont boldSystemFontOfSize:20];
    respringLabel.textColor = [UIColor labelColor];
    respringLabel.text = @"Are you sure you want to respring?";
    [respringPopController.view addSubview:respringLabel];
    
    UIButton *respringYesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [respringYesButton addTarget:self
                  action:@selector(respringYesGesture:)
     forControlEvents:UIControlEventTouchUpInside];
    [respringYesButton setTitle:@"Yes" forState:UIControlStateNormal];
    [respringYesButton setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
    respringYesButton.frame = CGRectMake(100, 100, 100, 30);
    [respringPopController.view addSubview:respringYesButton];
    
    UIButton *respringNoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [respringNoButton addTarget:self
                  action:@selector(respringNoGesture:)
     forControlEvents:UIControlEventTouchUpInside];
    [respringNoButton setTitle:@"No" forState:UIControlStateNormal];
    [respringNoButton setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
    respringNoButton.frame = CGRectMake(0, 100, 100, 30);
    [respringPopController.view addSubview:respringNoButton];
     
    UIPopoverPresentationController *respringPopover = respringPopController.popoverPresentationController;
    RespringViewController *vc = [[RespringViewController alloc] init];
    respringPopover.delegate = vc;
    respringPopover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //respringPopover.barButtonItem = respringButtonItem;
    // you can replace the barButtonItem with the below two methods to anchor the popover to a different view
    respringPopover.sourceView = sender;
    respringPopover.sourceRect = sender.frame;
    
    [self presentViewController:respringPopController animated:YES completion:nil];
    
    AudioServicesPlaySystemSound(1519);
}

%new
- (void)respringYesGesture:(UIButton *)sender {
    AudioServicesPlaySystemSound(1521);

    pid_t pid;
    const char* args[] = {"killall", "SpringBoard", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}

%new
- (void)respringNoGesture:(UIButton *)sender {
    [respringPopController dismissViewControllerAnimated:YES completion:nil];
}

%new
- (void)safeMode:(UIButton *)sender {
    
    safeModePopController = [[UIViewController alloc] init];
    safeModePopController.modalPresentationStyle = UIModalPresentationPopover;
    safeModePopController.preferredContentSize = CGSizeMake(200,130);
    
    UILabel *safeModeLabel = [[UILabel alloc] init];
    safeModeLabel.frame = CGRectMake(20, 20, 160, 60);
    safeModeLabel.numberOfLines = 2;
    safeModeLabel.textAlignment = NSTextAlignmentCenter;
    safeModeLabel.adjustsFontSizeToFitWidth = YES;
    safeModeLabel.font = [UIFont boldSystemFontOfSize:20];
    safeModeLabel.textColor = [UIColor labelColor];
    safeModeLabel.text = @"Are you sure you want to enter Safe Mode?";
    [safeModePopController.view addSubview:safeModeLabel];
    
    UIButton *safeModeYesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [safeModeYesButton addTarget:self
                  action:@selector(safeModeYesGesture:)
     forControlEvents:UIControlEventTouchUpInside];
    [safeModeYesButton setTitle:@"Yes" forState:UIControlStateNormal];
    [safeModeYesButton setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
    safeModeYesButton.frame = CGRectMake(100, 100, 100, 30);
    [safeModePopController.view addSubview:safeModeYesButton];
    
    UIButton *safeModeNoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [safeModeNoButton addTarget:self
                  action:@selector(safeModeNoGesture:)
     forControlEvents:UIControlEventTouchUpInside];
    [safeModeNoButton setTitle:@"No" forState:UIControlStateNormal];
    [safeModeNoButton setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
    safeModeNoButton.frame = CGRectMake(0, 100, 100, 30);
    [safeModePopController.view addSubview:safeModeNoButton];
     
    UIPopoverPresentationController *safeModePopover = safeModePopController.popoverPresentationController;
    SafeModeViewController *vc = [[SafeModeViewController alloc] init];
    safeModePopover.delegate = vc;
    safeModePopover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //safeModePopover.barButtonItem = safeModeButtonItem;
    // you can replace the barButtonItem with the below two methods to anchor the popover to a different view
    safeModePopover.sourceView = sender;
    safeModePopover.sourceRect = CGRectMake(0, 0, sender.frame.size.width, sender.frame.size.height);
    
    [self presentViewController:safeModePopController animated:YES completion:nil];
    
    AudioServicesPlaySystemSound(1519);
}

%new
- (void)safeModeYesGesture:(UIButton *)sender {
    AudioServicesPlaySystemSound(1521);

    pid_t pid;
    const char *args[] = {"killall", "-SEGV", "SpringBoard", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char * const *)args, NULL);
}

%new
- (void)safeModeNoGesture:(UIButton *)sender {
    [safeModePopController dismissViewControllerAnimated:YES completion:nil];
}

%new
- (void)darkMode:(UIButton *)sender {
    
    AudioServicesPlaySystemSound(1519);
        
        BOOL darkEnabled = ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark);
        
        UISUserInterfaceStyleMode *styleMode = [[%c(UISUserInterfaceStyleMode) alloc] init];
        if (darkEnabled) {
            styleMode.modeValue = 1;
        } else if (!darkEnabled)  {
            styleMode.modeValue = 2;
        }
}

%new
- (void)flashLight:(UIButton *)sender {
    AVCaptureDevice *flashLight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([flashLight isTorchAvailable] && [flashLight isTorchModeSupported:AVCaptureTorchModeOn]) {
        BOOL success = [flashLight lockForConfiguration:nil];
        if (success) {
            if ([flashLight isTorchActive]) {
                [flashLight setTorchMode:AVCaptureTorchModeOff];
            } else {
                [flashLight setTorchMode:AVCaptureTorchModeOn];
        }
        [flashLight unlockForConfiguration];
        }
    }
    AudioServicesPlaySystemSound(1519);
}

%new
- (void)ldrestart:(UIButton *)sender {
    
    ldrestartPopController = [[UIViewController alloc] init];
    ldrestartPopController.modalPresentationStyle = UIModalPresentationPopover;
    ldrestartPopController.preferredContentSize = CGSizeMake(200,130);
    
    UILabel *ldrestartLabel = [[UILabel alloc] init];
    ldrestartLabel.frame = CGRectMake(20, 20, 160, 60);
    ldrestartLabel.numberOfLines = 2;
    ldrestartLabel.textAlignment = NSTextAlignmentCenter;
    ldrestartLabel.adjustsFontSizeToFitWidth = YES;
    ldrestartLabel.font = [UIFont boldSystemFontOfSize:20];
    ldrestartLabel.textColor = [UIColor labelColor];
    ldrestartLabel.text = @"Are you sure you want to Soft Reboot?";
    [ldrestartPopController.view addSubview:ldrestartLabel];
    
    UIButton *ldrestartYesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ldrestartYesButton addTarget:self
                  action:@selector(ldrestartYesGesture:)
     forControlEvents:UIControlEventTouchUpInside];
    [ldrestartYesButton setTitle:@"Yes" forState:UIControlStateNormal];
    [ldrestartYesButton setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
    ldrestartYesButton.frame = CGRectMake(100, 100, 100, 30);
    [ldrestartPopController.view addSubview:ldrestartYesButton];
    
    UIButton *ldrestartNoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ldrestartNoButton addTarget:self
                  action:@selector(ldrestartNoGesture:)
     forControlEvents:UIControlEventTouchUpInside];
    [ldrestartNoButton setTitle:@"No" forState:UIControlStateNormal];
    [ldrestartNoButton setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
    ldrestartNoButton.frame = CGRectMake(0, 100, 100, 30);
    [ldrestartPopController.view addSubview:ldrestartNoButton];
     
    UIPopoverPresentationController *ldrestartPopover = ldrestartPopController.popoverPresentationController;
    ldrestartViewController *vc = [[ldrestartViewController alloc] init];
    ldrestartPopover.delegate = vc;
    ldrestartPopover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //ldrestartPopover.barButtonItem = ldrestartButtonItem;
    // you can replace the barButtonItem with the below two methods to anchor the popover to a different view
    ldrestartPopover.sourceView = sender;
    ldrestartPopover.sourceRect = CGRectMake(0, 0, sender.frame.size.width, sender.frame.size.height);
    
    [self presentViewController:ldrestartPopController animated:YES completion:nil];
    
    AudioServicesPlaySystemSound(1519);
}

%new
- (void)ldrestartYesGesture:(UIButton *)sender {
    AudioServicesPlaySystemSound(1521);
    
    NSTask *t = [[NSTask alloc] init];
    [t setLaunchPath:@"/usr/bin/sreboot"];
    [t setArguments:[NSArray arrayWithObjects:@"ldrestart", nil]];
    [t launch];
}

%new
- (void)ldrestartNoGesture:(UIButton *)sender {
    [ldrestartPopController dismissViewControllerAnimated:YES completion:nil];
}

%new
- (void)lpm:(UIButton *)sender {
    
    lpmPopController = [[UIViewController alloc] init];
    lpmPopController.modalPresentationStyle = UIModalPresentationPopover;
    lpmPopController.preferredContentSize = CGSizeMake(200,130);
    
    UILabel *lpmLabel = [[UILabel alloc] init];
    lpmLabel.frame = CGRectMake(20, 20, 160, 60);
    lpmLabel.numberOfLines = 2;
    lpmLabel.textAlignment = NSTextAlignmentCenter;
    lpmLabel.adjustsFontSizeToFitWidth = YES;
    lpmLabel.font = [UIFont boldSystemFontOfSize:20];
    lpmLabel.textColor = [UIColor labelColor];
    lpmLabel.text = @"Are you sure you want to toggle Low Power Mode?";
    [lpmPopController.view addSubview:lpmLabel];
    
    UIButton *lpmYesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lpmYesButton addTarget:self
                  action:@selector(lpmYesGesture:)
     forControlEvents:UIControlEventTouchUpInside];
    [lpmYesButton setTitle:@"Yes" forState:UIControlStateNormal];
    [lpmYesButton setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
    lpmYesButton.frame = CGRectMake(100, 100, 100, 30);
    [lpmPopController.view addSubview:lpmYesButton];
    
    UIButton *lpmNoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lpmNoButton addTarget:self
                  action:@selector(lpmNoGesture:)
     forControlEvents:UIControlEventTouchUpInside];
    [lpmNoButton setTitle:@"No" forState:UIControlStateNormal];
    [lpmNoButton setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
    lpmNoButton.frame = CGRectMake(0, 100, 100, 30);
    [lpmPopController.view addSubview:lpmNoButton];
     
    UIPopoverPresentationController *lpmPopover = lpmPopController.popoverPresentationController;
    lpmViewController *vc = [[lpmViewController alloc] init];
    lpmPopover.delegate = vc;
    lpmPopover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //lpmPopover.barButtonItem = lpmButtonItem;
    // you can replace the barButtonItem with the below two methods to anchor the popover to a different view
    lpmPopover.sourceView = sender;
    lpmPopover.sourceRect = CGRectMake(0, 0, sender.frame.size.width, sender.frame.size.height);
    
    [self presentViewController:lpmPopController animated:YES completion:nil];
    
    AudioServicesPlaySystemSound(1519);
}

%new
- (void)lpmYesGesture:(UIButton *)sender {
    AudioServicesPlaySystemSound(1521);
    
    if ([[%c(NSProcessInfo) processInfo] isLowPowerModeEnabled]) {
        [[%c(_CDBatterySaver) batterySaver] setPowerMode:0 error:nil];
    } else {
        [[%c(_CDBatterySaver) batterySaver] setPowerMode:1 error:nil];
    }
}

%new
- (void)lpmNoGesture:(UIButton *)sender {
    [lpmPopController dismissViewControllerAnimated:YES completion:nil];
}
%end
