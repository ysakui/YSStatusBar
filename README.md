YSStatusBar
===========

Slidable status bar to display a message like MailBox app.

![YSStatusBar](http://s11.postimg.org/wrhhmm6cz/i_OS_2013_10_29_17_20_46.png)

## Notice

YSStatusBar makes use of the "UIGetScreenImage()"
Please be aware that there is likely to be reject the appraisal of Apple.

## Installation

* Drag the `YSStatusBar/YSStatusBar` folder into your project.
* Add #include "YSStatusBar.h" to your .pch file


## Usage

YSStatusBar is a singleton. Make sure your view displays the default status bar
for this to be effective. I defaulted the colors to match defalut. Change if
needed.


### Showing the Status Message

* [YSStatusBar showWithStatus:@"text message..."];
* [YSStatusBar setStatus:@"change message..."];

### Hide Status Message

* [YSStatusBar hide];

## License

YSStatusBar published under the MIT license:

Copyright (C) 2013, Yoshimitsu Sakui

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

