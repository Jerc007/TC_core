# generator of .VHD sass files for FlexGrip, just copy the file in the TP and Prueba folder and use

# this function generates the principal.c file in order to start the automatic sass generation process:

import subprocess
import sys
import os
import io
import struct
import argparse
from datetime import datetime
from datetime import date
import time
import os.path
from os import path

import numpy as np
import os
#import matplotlib.pyplot as plt
import random
from sfpy import *			# library to import the posit format of real numbers
import contextlib


disabled = 0
input_target = 1
output_target = 2
internal_target = 3



def to_bytes(n, length, endianess='big'):
		h = '%x' % n
		s = ('O' *(len(h) % 2 ) + h ).zfill(length * 2).decode('hex')
		return s if endianess == 'big' else s[::-1] 
		
		
		
def float_to_hex(f, total_size):            # The total size must be 32 bits
    return hex(struct.unpack('<I', struct.pack('<f', f))[0])[2:].zfill(total_size)


def float_16_to_hex(f, total_size):         # The total size must be 16 bits
    return hex(struct.unpack('<H', struct.pack('<e', x))[0])[2:].zfill(total_size)

	
def hex_to_float(hex_value):

	#print("starting")

	x = 0.0
	y = 0.0
	hex_valuei = 0
	nan_val = 0
	try:
		hex_valuei = int(hex_value[0],16) & 0x7
	except:
		nan_val = 1

	if nan_val == 0:  # it means that there should not be any to calculate, there is an U or something as input.

		hex_sign = int(hex_value[0],16) & 0x8
		if hex_sign == 0x8:
		#	print("signo -")
			sign = 1
		else:
		#	print("signo +")
			sign = 0
			
		string_hex = str(hex_valuei) + hex_value[1:]
		#print( str(hex_valuei))
		#print( str(string_hex))
		
		x = struct.unpack('f',struct.pack('i',int(string_hex,16)))
		
		if sign == 1:
			y = -x[0]
		else:
			y = x[0]
			
	else:
		x = struct.unpack('f',struct.pack('i',int("0x7fffffff",16)))
		y = x[0]

	return y

# used to guarantee the filling of zeros in case of results or values that remove the extended zeros from the result.
# bin(int(my_hexdata, scale))[2:].zfill(num_of_bits)


def posit_to_hex(data_A_posit, total_size):     # total_size represents the number of hex elements (e.g., 8 for 4 bytes in 32 bits-size)
	temp = data_A_posit.bits
	temp = hex(temp)[2:].zfill(total_size)
#	print(data_A_posit, temp)
	return temp


#-----------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------

# example of launching: python3 posit_gen.py target_module total_number_stimuli

# target_module: its the target module or operation to generate the stimuli. The options are:
# 
# "posit_adder"
# "posit_mul"
# "posit_mac"
# "posit_DPU"
# total_number_stimuli: integer value representing the total number of stimuli to be generated
#


#-----------------------------------------------------------------------------------------------------------------------------

def main():

	target_module = "posit_adder"

	total = 200
		
	parser = argparse.ArgumentParser()
	
	parser.add_argument('target_module', help='target_module', type=str)
	parser.add_argument('total_number_stimuli', help='total_number_stimuli', type=int)
	
	args = parser.parse_args()

	target_module = args.target_module
	
	total = args.total_number_stimuli


	# pending to define the correct operative ranges...			
	operative_Range_low = 0.0
	operative_Range_high = 1.0

	total_format_size = 8		# when targeting the 32 bits representation. It will change when addressing another format size, 4 for 16 bits and 16 for 64 bits (posit).
	
	FP_new_list_name = "FP_values_" + str(target_module) + ".txt"
	FP_new_list_namexxx = "FP_literals_" + str(target_module) + ".txt"

	Posit_new_list_name = "Posit_values_" + str(target_module) + ".txt"
	Posit_new_list_namexxx = "Posit_literals_" + str(target_module) + ".txt"
	
	FP_OutFile = open( str(FP_new_list_name), "w" )
	FP_OutFile_literals = open( str(FP_new_list_namexxx), "w" )
	
	Posit_OutFile = open( str(Posit_new_list_name), "w" )
	Posit_OutFile_literals = open( str(Posit_new_list_namexxx), "w" )
	
	
	print("starting posit values generation...")
	
	for i in range(0, total):
		
		valueA = random.uniform(operative_Range_low, operative_Range_high)
		data_A_posit = Posit32(valueA)
		data_hex_A = float_to_hex(valueA, total_format_size)
		data_hex_posit_A = posit_to_hex(data_A_posit, total_format_size)
		
		print(data_hex_posit_A, data_hex_A)
		
		valueB = random.uniform(operative_Range_low, operative_Range_high)
		data_B_posit = Posit32(valueB)
		data_hex_B = float_to_hex(valueB, total_format_size)
		data_hex_posit_B = posit_to_hex(data_B_posit, total_format_size)
		
		
		if target_module == "posit_adder":		# Perform the addition and store the results

			valueC = valueA + valueB
			data_C_posit = Posit32(valueC)
			data_hex_C = float_to_hex(valueC, total_format_size)
			data_hex_posit_C = posit_to_hex(data_C_posit, total_format_size)
			
			# Store in file: Both format types are stored: the floating point and the posits version.
			FP_OutFile.write( str(data_hex_A) + " " + str(data_hex_B) + " " + str(data_hex_C) + "\n" )
			FP_OutFile_literals.write( str(valueA) + " " + str(valueB) + " " + str(valueC) + "\n" )
			Posit_OutFile.write( str(data_hex_posit_A) + " " + str(data_hex_posit_B) + " " + str(data_hex_posit_C) + "\n" )
			Posit_OutFile_literals.write( str(data_A_posit) + " " + str(data_B_posit) + " " + str(data_C_posit) + "\n" )
	
	
		elif target_module == "posit_mul":		# Perform the mul and store the results

			valueC = valueA * valueB
			data_C_posit = Posit32(valueC)
			data_hex_C = float_to_hex(valueC, total_format_size)
			data_hex_posit_C = posit_to_hex(data_C_posit, total_format_size)
			
			# Store in file: Both format types are stored: the floating point and the posits version.
			FP_OutFile.write( str(data_hex_A) + " " + str(data_hex_B) + " " + str(data_hex_C) + "\n" )
			FP_OutFile_literals.write( str(valueA) + " " + str(valueB) + " " + str(valueC) + "\n" )
			Posit_OutFile.write( str(data_hex_posit_A) + " " + str(data_hex_posit_B) + " " + str(data_hex_posit_C) + "\n" )
			Posit_OutFile_literals.write( str(data_A_posit) + " " + str(data_B_posit) + " " + str(data_C_posit) + "\n" )

	
		elif target_module == "posit_mac":		# Perform the multiply and add, and store the results
		
			valueC = random.uniform(operative_Range_low, operative_Range_high)
			data_C_posit = Posit32(valueC)
			data_hex_C = float_to_hex(valueC, total_format_size)
			data_hex_posit_C = posit_to_hex(data_C_posit, total_format_size)

			valueD = valueA * valueB + valueC
			data_D_posit = Posit32(valueD)
			data_hex_D = float_to_hex(valueD, total_format_size)
			data_hex_posit_D = posit_to_hex(data_D_posit, total_format_size)
			
			# Store in file: Both format types are stored: the floating point and the posits version.
			FP_OutFile.write( str(data_hex_A) + " " + str(data_hex_B) + " " + str(data_hex_C) + " " + str(data_hex_D) + "\n" )
			FP_OutFile_literals.write( str(valueA) + " " + str(valueB) + " " + str(valueC) + " " + str(valueD) + "\n" )
			Posit_OutFile.write( str(data_hex_posit_A) + " " + str(data_hex_posit_B) + " " + str(data_hex_posit_C) + " " + str(data_hex_posit_D[2:]) + "\n" )
			Posit_OutFile_literals.write( str(data_A_posit) + " " + str(data_B_posit) + " " + str(data_C_posit) +  " " + str(data_D_posit) + "\n" )


		elif target_module == "posit_DPU":		# Perform thedot product operation on 9 inputs (A0, B0, A1, B1, A2, B2, A3, B3, and C), and store the results
		
			valueA1 = random.uniform(operative_Range_low, operative_Range_high)
			data_A1_posit = Posit32(valueA1)
			data_hex_A1 = float_to_hex(valueA1, total_format_size)
			data_hex_posit_A1 = posit_to_hex(data_A1_posit, total_format_size)

			valueA2 = random.uniform(operative_Range_low, operative_Range_high)
			data_A2_posit = Posit32(valueA2)
			data_hex_A2 = float_to_hex(valueA2, total_format_size)
			data_hex_posit_A2 = posit_to_hex(data_A2_posit, total_format_size)

			valueA3 = random.uniform(operative_Range_low, operative_Range_high)
			data_A3_posit = Posit32(valueA3)
			data_hex_A3 = float_to_hex(valueA3, total_format_size)
			data_hex_posit_A3 = posit_to_hex(data_A3_posit, total_format_size)

			valueB1 = random.uniform(operative_Range_low, operative_Range_high)
			data_B1_posit = Posit32(valueB1)
			data_hex_B1 = float_to_hex(valueB1, total_format_size)
			data_hex_posit_B1 = posit_to_hex(data_B1_posit, total_format_size)

			valueB2 = random.uniform(operative_Range_low, operative_Range_high)
			data_B2_posit = Posit32(valueB2)
			data_hex_B2 = float_to_hex(valueB2, total_format_size)
			data_hex_posit_B2 = posit_to_hex(data_B2_posit, total_format_size)

			valueB3 = random.uniform(operative_Range_low, operative_Range_high)
			data_B3_posit = Posit32(valueB3)
			data_hex_B3 = float_to_hex(valueB3, total_format_size)
			data_hex_posit_B3 = posit_to_hex(data_B3_posit, total_format_size)

			valueC = random.uniform(operative_Range_low, operative_Range_high)
			data_C_posit = Posit32(valueC)
			data_hex_C = float_to_hex(valueC, total_format_size)
			data_hex_posit_C = posit_to_hex(data_C_posit, total_format_size)


			valueD = (valueA * valueB) + (valueA1 * valueB1) + (valueA2 * valueB2) + (valueA3 * valueB3) + valueC			
			data_D_posit = Posit32(valueD)
			data_hex_D = float_to_hex(valueD, total_format_size)
			data_hex_posit_D = posit_to_hex(data_D_posit, total_format_size)
			
			# Store in file: Both format types are stored: the floating point and the posits version.
			FP_OutFile.write( str(data_hex_A) + " " + str(data_hex_A1) + " " + str(data_hex_A2) + " " + str(data_hex_A3) + " " + str(data_hex_B) + " " + str(data_hex_B1) + " " + str(data_hex_B2) + " " + str(data_hex_B3) + " " + str(data_hex_C) + " " + str(data_hex_D) + "\n" )
			FP_OutFile_literals.write( str(valueA) + " " + str(valueA1) + " " + str(valueA2) + " " + str(valueA3) + " " + str(valueB) + " " + str(valueB1) + " " + str(valueB2) + " " + str(valueB3) + " " + str(valueC) + " " + str(valueD) + "\n" )
			
			Posit_OutFile.write( str(data_hex_posit_A) + " " + str(data_hex_posit_A1) + " " + str(data_hex_posit_A2) + " " + str(data_hex_posit_A3) + " " + str(data_hex_posit_B) + " " + str(data_hex_posit_B1) + " " + str(data_hex_posit_B2) + " " + str(data_hex_posit_B3) + " " + str(data_hex_posit_C) + " " + str(data_hex_posit_D) + "\n" )
			
			Posit_OutFile_literals.write( str(data_A_posit) + " " + str(data_A1_posit) + " " + str(data_A2_posit) + " " + str(data_A3_posit) + " " + str(data_B_posit) + " " + str(data_B1_posit) + " " + str(data_B2_posit) + " " + str(data_B3_posit) + " " + str(data_C_posit) +  " " + str(data_D_posit) + "\n" )
	
	FP_OutFile_literals.close()
	FP_OutFile.close()
		
	Posit_OutFile_literals.close()
	Posit_OutFile.close()
	
	print("Finishing the generation...")
	

	
	
	



	
				
	
				
				
# ----------------------------------------------------------------------------------------------------------
	
	# preliminary evaluation posit 32
	# *****************************************************************************************************
	
#	value = Posit32(0.0)
	
#	fault_model = "sa0"
	
#	name = "text_file32_" + str(fault_model) + "_"

#	for pointer in range (0, len(total_masks_32)):
##	for pointer in range (0, 1):
		
#		print("eval: " + str(total_masks_32[pointer]) )
#		j = -2.0
#		file_output = open(name + str(pointer)  + ".txt", "w")

#		for i in range(0, 4002, 1):
#			P_32bits1 = Posit32(j)
			
#			value = inject_fault_posit(P_32bits1 ,total_masks_32[pointer], fault_model, 1)
			
#			file_output.write(str(j) + " " + str(P_32bits1) + " " + str(value) + "\n")
#			j = j + 0.001
			
#		file_output.close()

	# *****************************************************************************************************
	
	
	# preliminary evaluation posit 16
	# *****************************************************************************************************
	
#	value = Posit16(0.0)
	
#	fault_model = "sa1"
	
#	name = "text_file16_" + str(fault_model) + "_"

#	for pointer in range (0, len(total_masks_16)):
##	for pointer in range (0, 1):
		
#		print("eval: " + str(total_masks_16[pointer]) )
#		j = -2.0
#		file_output = open(name + str(pointer)  + ".txt", "w")

#		for i in range(0, 4002, 1):
#			P_16bits1 = Posit16(j)
			
#			value = inject_fault_posit(P_16bits1 ,total_masks_16[pointer], fault_model, 1)
			
#			file_output.write(str(j) + " " + str(P_16bits1) + " " + str(value) + "\n")
#			j = j + 0.001
			
#		file_output.close()

	# *****************************************************************************************************
	
# -------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------

		
#	valueA = 1.0
#	data_A_posit = Posit32(valueA)
#	data_hex_A = float_to_hex(valueA)
#	data_hex_posit_A = posit_to_hex(data_A_posit)
		
#	print( str(valueA) + " : " + str(data_hex_A[2:]) + " , " + str(data_A_posit)  + " : " + str(data_hex_posit_A[2:]))














main()
