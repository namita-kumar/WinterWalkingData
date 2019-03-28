#Overview
The script "ReadData" reads and stores kinematic and joint torquedata from Winter_Appendix_data.xlsx. The data can be found in:
D. Winter, Biomechanics and motor control of human movement, 4th ed. Hoboken, N.J.: Wiley, 2009.
An excel spreadsheet containing this information can be found at: http://www.dustynrobots.com/academia/research/winters-gait-data-in-excel-form/

#Interpolation
The original data is limited to 69 data points. So the script interpolates to extend it to 100 data points.
The interpolated angular position (rad), velocity (rad/s), and joint torque (Nm) are stored as .mat files
