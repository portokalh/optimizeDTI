a = importdata('/Volumes/TrinityDrive/N51200_v2/Bedpost_matrix_files/ESR12_matrix_approximation.txt')
b=a?
dlmwrite ('/Volumes/TrinityDrive/N51200_v2/bedpost/bedpost_ESR12/bvecs', b, 'delimiter', ' ')