---
date: 2021-06-17 16:25
description: It's not pretty, but it works!
tags: howto, programming, windows, python
title: Reading HEIC images with python PIL on Windows
---

Earlier today, I needed to open a HEIC image in PIL.
A quick search found the packages `pyheif` and `pyheif-pillow-opener`. Well, turns out they don't work on Windows. And while I could just switch to a supported OS I really wanted to use Windows for this for a few reasons.

Some fiddling around later I had it working, here's how:

**Install libheif using vcpkg: [https://github.com/Microsoft/vcpkg/](https://github.com/Microsoft/vcpkg/)**

In order to read HEIC images we need `libheif`. The easiest way to get it is using `vcpkg`, a Microsoft tool to manage C and C++ libraries.
Follow the installation guide on their github repo. In short:

1. Clone the repo: `git clone https://github.com/Microsoft/vcpkg`
2. Run the installation script: `.\vcpkg\bootstrap-vcpkg.bat`
3. Install libheif (skip this if you're on a 32-Bit system and only run step 4): `.\vcpkg\vcpkg install libheif:x64-windows`
4. I also installed the 32-Bit version, but I don't think it's necessary: `.\vcpkg\vcpkg install libheif`
5. Not sure either if this is necessary, but I ran their integration from an elevated command prompt: `.\vcpkg\vcpkg integrate install`


**Install Imagemagick [https://imagemagick.org/script/download.php#windows](https://imagemagick.org/script/download.php#windows)**

I used the Windows binary, 16 bits-per-pixel, 64bit installer

**Install the python wand package**

Just run `pip install wand`. Make sure you're using a python 3 version and not python 2.7!

And that's it! Here's a snippet how to use it:

<pre class="code">
<code>
from wand.image import Image
import PIL.Image
import io

with Image(filename=r'img.HEIC') as img:
    pil_image = PIL.Image.open(io.BytesIO(img.make_blob("jpg")))
</code>
</pre>



It's pretty slow, because it needs to convert the image to jpg, but it works!