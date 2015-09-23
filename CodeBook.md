## Code Book

### subject and activity

The subject and activity variables effectively represent individual tests where one test subject is conducting a particular activity, as follows:

 - subject: the integer subject ID representing the person or test subject.
 - activity: the string activity name, consisting of:
  - walking
  - walkingupstairs
  - walkingdownstairs
  - sitting
  - standing
  - laying

## Means of calculated variables

The summarized output is a mean value for each calculated value (based on raw output) for each individual test (see above). 
All values are floating point numbers.
All units are 'g' (g being 9.806m/s^2), excepting values of Jerk, which are 'g's per second.
All are normalized to within [-1,1].
Values are either the X, Y, or Z axis component, or the scalar magnitude is reported.
Values are either in the time or frequency domain (result of FFT).
Sampling frequency of 50Hz was used.
Note that the PSD plot cannot be reconstructed as frequency domain signals are averaged, this averaging only allows a frequency weighted comparison between tests.

 - Body acceleration mean in time domain
  - meanBodyAccelerationMeanX-time
  - meanBodyAccelerationMeanY-time
  - meanBodyAccelerationMeanZ-time
  - meanBodyAccelerationMagnitudeMean-time

 - Body acceleration mean in frequency domain
  - meanBodyAccelerationMeanX-frequency
  - meanBodyAccelerationMeanY-frequency
  - meanBodyAccelerationMeanZ-frequency 
  - meanBodyAccelerationMagnitudeMean-frequency

 - Body acceleration standard deviation in time domain
  - meanBodyAccelerationStdDevX-time
  - meanBodyAccelerationStdDevY-time
  - meanBodyAccelerationStdDevZ-time
  - meanBodyAccelerationMagnitudeStdDev-time

 - Body acceleration standard deviation in frequency domain
  - meanBodyAccelerationStdDevX-frequency
  - meanBodyAccelerationStdDevY-frequency
  - meanBodyAccelerationStdDevZ-frequency
  - meanBodyAccelerationMagnitudeStdDev-frequency

 - Body acceleration jerk mean in time domain
  - meanBodyJerkMeanX-time
  - meanBodyJerkMeanY-time
  - meanBodyJerkMeanZ-time
  - meanBodyJerkMagnitudeMean-time

 - Body acceleration jerk mean in frequency domain
  - meanBodyJerkMeanX-frequency
  - meanBodyJerkMeanY-frequency
  - meanBodyJerkMeanZ-frequency
  - meanBodyJerkMagnitudeMean-frequency 

 - Body acceleration jerk standard deviation in time domain
  - meanBodyJerkStdDevX-time
  - meanBodyJerkStdDevY-time
  - meanBodyJerkStdDevZ-time
  - meanBodyJerkMagnitudeStdDev-time

 - Body acceleration jerk standard deviation in frequency domain
  - meanBodyJerkStdDevX-frequency
  - meanBodyJerkStdDevY-frequency
  - meanBodyJerkStdDevZ-frequency
  - meanBodyJerkMagnitudeStdDev-frequency

 - Gravity mean in time domain
  - meanGravityAccelerationMeanX-time
  - meanGravityAccelerationMeanY-time
  - meanGravityAccelerationMeanZ-time
  - meanGravityAccelerationMagnitudeMean-time

 - Gravity standard deviation in time domain
  - meanGravityAccelerationStdDevX-time
  - meanGravityAccelerationStdDevY-time
  - meanGravityAccelerationStdDevZ-time
  - meanGravityAccelerationMagnitudeStdDev-time

 - Gyro acceleration mean in time domain
  - meanGyroMeanX-time
  - meanGyroMeanY-time
  - meanGyroMeanZ-time
  - meanGyroMagnitudeMean-time

 - Gyro acceleration mean in frequency domain
  - meanGyroMeanX-frequency
  - meanGyroMeanY-frequency
  - meanGyroMeanZ-frequency
  - meanGyroMagnitudeMean-frequency 

 - Gyro acceleration standard deviation in time domain
  - meanGyroStdDevX-time
  - meanGyroStdDevY-time
  - meanGyroStdDevZ-time
  - meanGyroMagnitudeStdDev-time

 - Gyro acceleration standard deviation in frequency domain
  - meanGyroStdDevX-frequency
  - meanGyroStdDevY-frequency
  - meanGyroStdDevZ-frequency
  - meanGyroMagnitudeStdDev-frequency

 - Gyro acceleration jerk mean in time domain
  - meanGyroJerkMeanX-time
  - meanGyroJerkMeanY-time
  - meanGyroJerkMeanZ-time
  - meanGyroJerkMagnitudeMean-time

 - Gyro acceleration jerk standard deviation in time domain
  - meanGyroJerkStdDevX-time
  - meanGyroJerkStdDevY-time
  - meanGyroJerkStdDevZ-time
  - meanGyroJerkMagnitudeStdDev-time  

 - Gyro acceleration jerk mean in frequency domain
  - meanGyroJerkMagnitudeMean-frequency

 - Gyro acceleration jerk standard deviation in frequency domain
  - meanGyroJerkMagnitudeStdDev-frequency

..end of document..