# Image Analysis Class


class ImagAnalysis:

    def __init__(self, fp, fn):
        self.fp = fp
        self.fn = fn

    def prnt(self):
        return '{} {}'.format(self.fp, self.fn)


img = ImagAnalysis("FP", 'FN')

print(img.prnt())
