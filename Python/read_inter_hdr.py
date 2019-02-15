import os


def read_inter_hdr(fp, fn):
    # Read interfile header file
    # Extract meta data from Image
    # Input:
    #   fp = file path
    #   fn = file name
    # Output:
    #   hdr = meta data (structure)
    # Author :
    # A.Morahan (UCL), adapted from K.Erlandsson (UCL)

    # lab : The labels of interest contained within the header file and their associated tags
    lab = {'name of data file': 'fn_dat',
           'data description': 'desc',
           'number of bytes per pixel': 'n_byt',
           'image duration': 'dt',
           'total number of images': 'n_img',
           'matrix size [1]': 'nx',
           'matrix size [2]': 'ny',
           'matrix size [3]': 'nz',
           'scaling factor (mm/pixel) [1]': 'vx',
           'scaling factor (mm/pixel) [2]': 'vy',
           'scaling factor (mm/pixel) [3]': 'vz'
           }

    tmp = {}

    print('Reading File: {}'.format(fn))

    # fid : File id given by fn and fp
    path = os.path.join(fp, fn)
    try:
        fid = open(path, 'r')
    except NameError:
        print('Error Opening File')
        return
    else:
        # read each line of open file, until the end
        with fid as f:  # read line with 'with'
            for line in f:
                for i in lab:  # find the labels in file line
                    i0 = line.find(i)
                    if i0 != -1:
                        ss = line.split(':=')  # if label found extract value
                        if len(ss) > 0:
                            tmp[lab[i]] = d_val(ss[1])
        fid.close()
    # Determine if image is volumetric
    if 'nz' not in tmp:
        tmp['nz'] = 1
    if 'vz' not in tmp:
        tmp['vz'] = 0
    # Assign values to header dictionary
    hdr = {'fp': fp,
           'fn': fn
           }
    lst = ['name of data file',
           'data description',
           'number of bytes per pixel',
           'image duration'
           ]
    # list of keys of interest

    for key in lst:
        if lab[key] in tmp:  # determine the data tag and assign to head
            hdr[lab[key]] = tmp[lab[key]]

    hdr['dim'] = [tmp['nx'], tmp['ny'], tmp['nz']]
    if 'n_img' in tmp:
        hdr['dim'] = [tmp['nx'], tmp['ny'], tmp['n_img']]

    hdr['vox'] = [tmp['vx'], tmp['vy'], tmp['vz']]

    return hdr


def d_val(s2):
    # convert line to numerical value
    try:
        val = int(float(s2))
        return val
    except ValueError:  # otherwise strip white space from string
        val = s2.strip()
        return val


hedr = read_inter_hdr('C:\\Users\\Ashley\\Documents\\Local_SIMIND\\MSS_SIMIND\\Python', 'mss_line_twoslit1.h00')

print(hedr['dim'])

# print(hedr['n_byt'])