XDKAirMenu
==========

iOs Menu like the app FIFA

AFNetworking is a delightful networking library for iOS and Mac OS X. It's built on top of the Foundation URL Loading System, extending the powerful high-level networking abstractions built into Cocoa. It has a modular architecture with well-designed, feature-rich APIs that are a joy to use.

Perhaps the most important feature of all, however, is the amazing community of developers who use and contribute to AFNetworking every day. AFNetworking powers some of the most popular and critically-acclaimed apps on the iPhone, iPad, and Mac.

Choose AFNetworking for your next project, or migrate over your existing projects—you'll be happy you did!

<img src="img.gif" width='320'/>

## How To Get Started

Download XDKAirMenu and try out the included iPhone example app
Check out the documentation for a comprehensive look at all of the functionalities available in XDKAirMenu

### Installation with CocoaPods

CocoaPods is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like AFNetworking in your projects. See the "Getting Started" guide for more information.
Podfile

	pod "EZForm"

### Other installation

Git clone the source.

Add XDKAirMenu/XDKAirMenu folder to your project (or workspace).

## Quick start

Import the main header:

	#import <EZForm/EZForm.h> 

Create an EZForm instance and add some EZFormField subclass instances to it. For example:

	- (void)initializeForm
	{
    /*
     * Create EZForm instance to manage the form.
     */
    _myForm = [[EZForm alloc] init];
    _myForm.inputAccessoryType = EZFormInputAccessoryTypeStandard;
    _myForm.delegate = self;

    /*
     * Add an EZFormTextField instance to handle the name field.
     * Enables a validation rule of 1 character minimum.
     * Limits the input text field to 32 characters maximum (when hooked up to a control).
     */
    EZFormTextField *nameField = [[EZFormTextField alloc] initWithKey:@"name"];
    nameField.validationMinCharacters = 1;
    nameField.inputMaxCharacters = 32;
    [_myForm addFormField:nameField];

    /*
     * Add an EZFormTextField instance to handle the email address field.
     * Enables a validation rule that requires an email address format "x@y.z"
     * Limits the input text field to 128 characters maximum and filters input
     * to assist with entering a valid email address (when hooked up to a control).
     */
    EZFormTextField *emailField = [[EZFormTextField alloc] initWithKey:@"email"];
    emailField.inputMaxCharacters = 128;
    [emailField addValidator:EZFormEmailAddressValidator];
    [emailField addInputFilter:EZFormEmailAddressInputFilter];
    [_myForm addFormField:emailField];
	}

You can update the form fields directly based on user input. But, more commonly, you will wire up your input controls directly to EZForm so it will handle input, validation, field navigation, etc, automatically. For example:

- (void)viewDidLoad
{
    [super viewDidLoad];

    /* Wire up form fields to user interface elements.
     * This needs to be done after the views are loaded (e.g. in viewDidLoad).
     */
    EZFormTextField *nameField = [_myForm formFieldForKey:@"name"];
    [nameField useTextField:self.nameTextField];

    EZFormTextField *emailField = [_myForm formFieldForKey:@"email"];
    [emailField useTextField:self.emailTextField];

    /* Automatically scroll (or move) the given view if needed to
     * keep the active form field control visible.
     */
    [_myForm autoScrollViewForKeyboardInput:self.tableView];
}

If you wire up any of your views to EZForm you should unwire them in viewDidUnload, which you can do with one method call:

- (void)viewDidUnload
{
    [super viewDidUnload];
    [_myForm unwireUserViews];
}

See the demo app source for more examples of how to work with EZForm.
Demo

A demo universal iOS app is included with the source, containing some example form implementations.

Simple Login Form DemoRegistration Form DemoRegistration Form Demo

##Documentation

EZForm comes with full API documentation, which is Xcode Document Set ready. Use appledoc to generate and install the document set into Xcode - http://gentlebytes.com/appledoc/

To generate the document set using appledoc from the command-line, cd to the root of the source directory and enter:

./gen-apple-doc-set

##Requirements

XDKAirMenu is compatible with iOS 7 and upwards. XDKAirMenu uses automatic reference counting (ARC).

The demo app included with the source requires iOS 7.

##ARC

XDKAirMenu uses automatic reference counting (ARC).

##Support

XDKAirMenu is provided open source with no warranty and no guarantee of support. However, best effort is made to address issues raised on Github.

If you would like assistance with integrating XDKAirMenu or modifying it for your needs, contact the author Xavier De Koninck xavier.dekoninck@gmail.com for consulting opportunities.

##License

XDKAirMenu is Copyright (c) 2014 Xavier De Koninck and released open source under a MIT license:

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.


