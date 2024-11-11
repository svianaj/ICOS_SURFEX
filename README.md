# ICOS_SURFEX
jupyter notebooks to create SURFEX forcing for ICOS sites and for model validation
# How to use
* Typical python packages needed that you probably have installed already:
pandas, matplotlib, numpy, xarray, scipy, datetime

* In addition, you'll need to install ICOS's specific python package icoscp
  > pip install icoscp

* Finally, you'll need to install the meteo package to have access to some thermodinamic psicrometric formulas:
  > pip install meteo
  
  Once installed, check that you can load the package and get access to their "humidity" functions:
  
  > import meteo
  > meteo.humidity

  You might get an error when importing meteo:
  ModuleNotFoundError: No module named 'humidity'

  I could solve this by editing __init__.py in my local installation:
  /home/$USER/.local/lib/$PYTHONVERSION/site-packages/meteo/
  and adding "." before the imports:

  >from .humidity import *
  
  >from .radiation import *
  
  >from .air import *
  
  >from .physdyn import *


  
