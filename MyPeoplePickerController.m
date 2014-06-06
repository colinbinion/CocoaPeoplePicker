#import "MyPeoplePickerController.h"
#import <AddressBook/ABPeoplePickerView.h>
#import <AddressBook/AddressBook.h>

@interface MyPeoplePickerController ()
@property (weak) IBOutlet ABPeoplePickerView *peoplePickerView;
@end


@implementation MyPeoplePickerController

// Show all the groups selected in the people picker view in the console
- (IBAction)printGroups:(id)sender
{
    NSArray *groups = [self.peoplePickerView selectedGroups];
    NSLog(@"Groups: %lu groups selected", [groups count]);
    for (ABGroup *group in groups)
    {
        NSLog(@"Name:%@ Identifier:%@", [group valueForProperty:kABGroupNameProperty],[group uniqueId]);
    }
}


// Show all the contacts currently selected in the people picker view in the console
- (IBAction)printContacts:(id)sender
{
    NSArray *records = [self.peoplePickerView selectedRecords];
    NSLog(@"Records: %lu records selected", [records count]);
    
    for (ABPerson *record in records)
    {
        NSLog(@"Name:%@  Identifier:%@",[NSString stringWithFormat:@"%@ %@",[record valueForProperty:kABFirstNameProperty], [record valueForProperty:kABLastNameProperty]],[record uniqueId]);
    }
}


// Activate specific values for display
- (IBAction)viewProperty:(NSButton *)sender
{
    NSString *property;
    // See MainMenu.nib for the corresponding checkbox tags.
    switch ([sender tag])
    {
        case 0: // Phone
            property = kABPhoneProperty;
            break;
        case 1: // Address
            property = kABAddressProperty;
            break;
        case 2: // Email
            property = kABEmailProperty;
            break;
        case 3: // AIM
            property = kABInstantMessageProperty;
            break;
        case 4: // Homepage
            property = kABURLsProperty;
            break;
        default:
            property = kABHomePageProperty;
            break;
    }
    if ([sender state] == NSOnState)
    {
        [self.peoplePickerView addProperty:property];
    } else
    {
        [self.peoplePickerView removeProperty:property];
    }
}


//[Dis]allow entire group selection in the people picker
- (IBAction)toggleGroupSelection:(NSButton *)sender
{
    [self.peoplePickerView setAllowsGroupSelection:([sender state] == NSOnState)];
}


//[Dis]allow the selection of multiple groups,contacts, or values of multivalue properties in the people picker
- (IBAction)toggleMultipleItemsSelection:(NSButton *)sender
{
    [self.peoplePickerView setAllowsMultipleSelection:([sender state] == NSOnState)];
}


//Launch Address Book to edit the selected contact
- (IBAction)editSelectedContactInAB:(id)sender
{
    [self.peoplePickerView editInAddressBook:sender];
}


//Launch Address Book to show the selected contact
- (IBAction)showSelectedContactInAB:(id)sender
{
    [self.peoplePickerView selectInAddressBook:sender];
}


@end
