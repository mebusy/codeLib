#!python3

import torch

# check whether cuda is avaiale
assert torch.cuda.is_available() == True

print("cuda supported")
