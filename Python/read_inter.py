import read_inter_hdr
import os
import numpy as np
import json
#from matplotlib import pyplot as plt


def read_inter(fp, fn):
    # Read interfile file data
    # Input:
    #   fp = file path
    #   fn = file name
    # Output:
    #   img = Image data (structure)
    # Author :
    # A.Morahan (UCL), adapted from K.Erlandsson (UCL)

    prec = {1: np.uint8,
            2: np.uint16,
            4: np.uint32,
            8: np.uint64
            }

    try:
        hdr = read_inter_hdr.read_inter_hdr(fp, fn)
    except NameError:
        print('Specify Path Name and File Name')
        return
    else:
        img = {'fp': hdr['fp'],
               'fn': hdr['fn_dat'],
               'hdr': hdr
               }

        print('Reading File: {}'.format(img['fn']))
        path = os.path.join(fp, fn)
        try:
            with open(path, 'r') as fid:
                img['dat'] = fid.read()
        except NameError:
            print('Error Opening File')
        else:
            fid.close()

    return img


imageD = read_inter('C:\\Users\\Ashley\\Documents\\Local_SIMIND\\MSS_SIMIND\\Python', 'mss_line_twoslit1.h00')


print(imageD['dat'])

Data = imageD['dat']

