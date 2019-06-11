# Image Analysis Class
# Load and analyse interfile data
# Ashley Morahan UCL, London 2019

import read_inter
import os
from matplotlib import pyplot as plt


class ImageAnalysis:

    num_of_files = 0

    def __init__(self, fp, fn):
        self.filePath = fp
        self.fileName = fn
        self.imgStructure = None
        self.imgData = None

        ImageAnalysis.num_of_files += 1

    # Getters

    def get_path(self):
        return self.filePath + self.fileName

    def get_hdr(self):
        return

    def get_size(self):
        # finish
        return

    def get_scale(self):
        # finish
        return

    def get_num_files(self):
        # finish
        return

    # Setters

    def set_file_path(self):
        return

    def set_file_name(self):
        return

    # Methods

    def load_data(self):
        path = os.path.join(self.filePath, self.fileName)
        try:
            os.path.exists(path)
        except FileNotFoundError:
            print('Please Specify Correct File Path and Name')
        else:
            self.imgStructure = read_inter.read_inter(self.filePath, self.fileName)
            self.imgData = self.imgStructure['dat']

    def check_load(self):
        print('Current File Data = {}'.format(self.imgStructure['fn']))

    def view_data(self):
        plt.imshow(self.imgData)
        plt.show()

    # Class Methods

    # Static Methods


img = ImageAnalysis('C:\\Users\\Ashley\\Documents\\Local_SIMIND\\MSS_SIMIND\\Python', 'mss_line_twoslit1.h00')

pth = img.get_path()

img.load_data()

#
img.view_data()

img.check_load()

pth = img.get_path()

print(pth)

print(img.num_of_files)