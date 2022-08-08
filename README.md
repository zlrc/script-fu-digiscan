<p align="left" style="line-height: 18px;">
  <img style="float:left;" src="https://i.imgur.com/xr2fsN4.png" height=150px>

  **Digitalize Scan**<br>
  *A Script-Fu for GNU Image Manipulation Program (GIMP)*
  <br>
  <br>
  This script cleans up scanned pen & paper drawings by converting them into vector-like layers, much like Inkscape's "Trace Bitmap" feature.
</p>
<hr>
<p align="center"><img src="https://i.imgur.com/naYjB4B.png" width=80%></p>

## How to Use

Directions on how to install Script-Fu scripts can be found here: http://docs.gimp.org/en/install-script-fu.html

The script can be found under `Filters` >> `Enhance` >> `Digitalize Scan...`

The pop-up window will ask for the "Brightness Cutoff". The higher the number here, the darker the lines have to be in order to be traced. Think of it as how "smooth" you want the final result to be. 100-160 is typically the sweet spot for most drawings.

Finally, the background and foreground colors that are currently active on the image will determine the "vector" and "background" colors of the result.
