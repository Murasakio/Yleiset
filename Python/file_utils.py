import requests
import glob
import os

class file_utils:

    def download_file(self, url, path, filename):
        r = requests.get(url, allow_redirects=True)
        path = path+"\\"+filename
        open(path, 'wb').write(r.content)
    
    def list_files_date(self, path, filetype, sort):
        filelist = list(filter(os.path.isfile, glob.glob(path+"\\"+filetype)))
        filelist.sort(key=lambda x: os.path.getctime(x))
        return  filelist
    
    def latenew_file(self, path, filetype, latest):
        filelist = list(filter(os.path.isfile, glob.glob(path+"\\"+filetype)))
        if latest:
            file = min(filelist, key=os.path.getctime)
        else:
            file = max(filelist, key=os.path.getctime)
        return  file

    def __init__(self):
        pass