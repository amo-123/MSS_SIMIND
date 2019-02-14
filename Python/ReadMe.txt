Line 1
Line 2 
Line 3

!INTERFILE :=
!imaging modality := nucmed
!originating system := simind
!version of keys := 3.3
program author := M Ljungberg, Lund University
program version := V6.1.2
  
!GENERAL DATA :=
original institution := Medical Radiation Physics
contact person := M Ljungberg
!data offset in bytes := 0
!name of data file := mss_line_twoslit9.a00
patient name := SMC_mss_line_twoslit9.a00
!study ID := slitslat
data description :=
;# Summation of windows := none
;# Radionuclide (Therapy) := none
exam type := STATIC
!patient ID := SIMIND
  
!GENERAL IMAGE DATA :=
patient orientation := head_in
patient rotation := supine
!type of data := static
study date := 2019:02:08
study time := 09:40:47
imagedata byte order := LITTLEENDIAN
patient rotation := supine
patient orientation := head_in
;energy window lower level :=
;energy window upper level :=
!total number of images := 1
!number of energy windows := 1
;# Image Position First image := -25.0000 -50.0000 25.0000
;# Image Orientation := 1.000 0.000 0.000 0.000 0.000 -1.000
;# Units of data (ECT) := counts
!STATIC STUDY (General) :=
!number of images/energy window := 1
image duration (sec) := 1.000
!static study (each frame) :=
!image number := 1
!matrix size [1] := 200
!matrix size [2] := 400
!number format := short float
!number of bytes per pixel := 4
label := View1
scaling factor (mm/pixel) [1] := 0.250
scaling factor (mm/pixel) [2] := 0.250
;# scaling factor (mm/pixel) [3] := 0.250
maximum pixel count := 0.008
;# total counts := 0.000
;# Intrinsic FWHM for the camera := 0.100
;# Collimator := ge-legp
;# Collimator hole diameter := 0.250
;# Collimator hole septa := 0.030
;# Collimator thickness := 2.650
;# SIMIND: Photon Energy := 140.500
;# SIMIND: Time shift := -9999.000
  
!END OF INTERFILE :=
