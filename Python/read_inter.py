import read_inter_hdr
import os
import numpy as np


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
            8: np.uint64}

    try:
        hdr = read_inter_hdr.read_inter_hdr(fp, fn)
    except NameError:
        print('Specify Path Name and File Name')
        return
    else:
        img = {'fp': hdr['fp'],
               'fn': hdr['fn_dat'],
               'hdr': hdr}

        print('Reading File: {}'.format(img['fn']))
        path = os.path.join(fp, fn)
        try:
            fid = open(path, 'rb')
        except NameError:
            print('Error Opening File')
        else:
            print(prec[hdr['n_byt']])
            img['dat'] = np.fromfile(fid, dtype=prec[hdr['n_byt']], count=np.prod(hdr['dim']))
            fid.close()

    #img['dat'].shape = (np.prod(hdr['dim']), 1)
    print(np.shape(img['dat']))

    return img


read_inter('C:\\Users\\Ashley\\Documents\\Local_SIMIND\\MSS_SIMIND\\Python', 'mss_line_twoslit1.h00')
