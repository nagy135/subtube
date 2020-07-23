import os
import re

hashes = []
with open('{}/.local/share/qutebrowser/mpv_history'.format(os.path.expanduser('~')), 'r') as f:
    for line in f:
        url = line.strip().split('(')[-1][:-1]
        hash_id = url.replace('https://www.youtube.com/watch?v=', '')
        if len(hash_id) != 11: continue
        hashes.append(hash_id)

before = 0
for f in os.listdir('/usr/share/subtube/resources/thumbnails/'):
    hash_file = re.sub(r'\d*-', '', f)
    hash_file = re.sub(r'\.jpg$', '', hash_file)
    if hash_file in hashes:
        os.remove('/usr/share/subtube/resources/thumbnails/' + f)

