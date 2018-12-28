  (script-fu-register
    "script-fu-digiscan"                             ;func name
    "Digitalize Scan..."                             ;menu label
    "Traces scanned black & white drawings into clean vectors."  ;description
    "Mike \"zlrc\" K."                               ;author
    "MIT License"                                    ;copyright notice
    "August 22, 2017"                                ;date created
    "RGB*, GRAY*"                                    ;image type that the script works on
    SF-IMAGE      "Image"          0
    SF-DRAWABLE        "Drawable"          0
	SF-ADJUSTMENT  "Brightness Cutoff"     '(160 0 255 1 10 0 0) ; max-delta, higher numbers means darker colors are preserved
  )
  (script-fu-menu-register "script-fu-digiscan" "<Image>/Filters/Enhance")
 (define (script-fu-digiscan image drawable max-delta)
 (let* ((max-delta (max (min max-delta 255) 0))
           (old-bg (car (gimp-palette-get-background)))
		   (width (car (gimp-image-width image)))
		   (height (car (gimp-image-height image)))
           (vector-layer 0)
		   (active-selection 0)
		   (new-bg 0)
		   (active-vectors 0))
	
	(gimp-undo-push-group-start image)
	
 ; Duplicate layer and add to the image
       (set! vector-layer (car (gimp-layer-copy drawable 1)))
       (gimp-image-add-layer image vector-layer -1)
       (gimp-layer-set-name vector-layer "Vector")
	   
 ; Blurs, Desaturates, and Posterizes Layer
	   (plug-in-sel-gauss 1 image vector-layer 5 max-delta)
	   (gimp-desaturate-full vector-layer 1)
	   (gimp-posterize vector-layer 2)
	   
 ; Converts Lineart to a Selection
	   (plug-in-colortoalpha 1 image vector-layer '(255 255 255)) ; converts white to transparency
	   (gimp-image-select-item image 2 vector-layer)
	   (gimp-edit-clear vector-layer)
	   (set! active-selection (car (gimp-image-get-selection image))) ; Sets active selection variable
	   (plug-in-sel2path 1 image active-selection)
	   (set! active-vectors (car (gimp-image-get-active-vectors image))) ; Declares a variable for the path we created
	   (gimp-image-select-item image 2 active-vectors)
 
 ; Fills Selection	   
	   (gimp-edit-fill vector-layer 0) ; fills with foreground color
	   (gimp-selection-none image)
	   
 ; Adds White Background Layer	   
	   (set! new-bg (car (gimp-layer-new image width height RGBA-IMAGE "Background" 100 NORMAL-MODE)))
	   (gimp-drawable-fill new-bg 1) ; fills with background color
	   (gimp-image-insert-layer image new-bg 0 1)
 
 ; Cleanup
       (gimp-image-set-active-layer image vector-layer)
       (gimp-undo-push-group-end image)
       (gimp-displays-flush) ))	   
	   