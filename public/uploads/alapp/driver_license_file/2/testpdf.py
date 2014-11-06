import re
from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.converter import TextConverter
from pdfminer.layout import LAParams
from pdfminer.pdfpage import PDFPage
from cStringIO import StringIO
from docx import opendocx, getdocumenttext
import os
import shutil
#
# def readexcel(csvfile):
#     peoplelist = []
#     f = open( csvfile, 'rU' ) #open the file in read universal mode
#     for line in f:
#         cells = re.match(r"(\d+),(.*)", line)
#         job_position = cells.group(1)
#         peoplename = cells.group(2)
#         people = People(peoplename, job_position)
#         peoplelist.append(people)
#
#     f.close()
#     return peoplelist
#
# class People:
#
#     def __init__(self, name, job_position):
#         namelist = re.split("\W+", name)
#         newnamelist = []
#         for name in namelist:
#             if len(name) > 1:
#                 newnamelist.append(name)
#         self.name = newnamelist
#         self.resume = []
#         self.flag = 0
        


# filename = '0F41600F-F671-412C-B850-38CFD8C66035.docx'
# path = '/Users/Jingyuan/Documents/backup1/A00DE5F2-D3CA-4DCF-8A2A-C5C07621A4F5.docx'
# document = opendocx(path)
# textlist = getdocumenttext(document)[:5]
# namelist = ["Jerry", "stone"]
# flaglist = []
# for name in namelist:
#     for text in textlist:
#         if name.lower() in text.lower():
#             flaglist.append("True")
#             break
# if len(flaglist)==len(namelist):
#     print True
# else:
#     print False
#
# back_up_2 = "/Users/Jingyuan/Documents/backup2"


# for root, directories, files in os.walk(back_up_2):
#     for filename in files:
#         filepath = os.path.join(root, filename)
#         print filepath
#         if filename.endswith('.doc'):
#             f = open(filepath,'r')
#             file = f.readlines()
#             print file
#             f.close()
#search(document, string)
#
#path = "/Users/Jingyuan/Documents/backup2/0014920-att1.doc"
# pp = '/Users/Jingyuan/Documents/found/6485_\"Campbell, David\"_0.doc'
# def find_rtf(namelist, path):
#     f = open(path,'r')
#     file = f.readlines()
#     print file
#     f.close()
#     flaglist = []
#     for line in file:
#         x = line.split('\r')
#         for l in x:
#             for name in namelist:
#                 if name.lower() in l.lower():
#                     flaglist.append("True")
#             if len(flaglist)==len(namelist):
#                 return True
#             else:
#                 flaglist = []
#     return False
#
# namelist = ['Campbell','David']
# print find_rtf(namelist, pp)


def find_pdf(path):
    rsrcmgr = PDFResourceManager()
    retstr = StringIO()
    codec = 'utf-8'
    laparams = LAParams()
    device = TextConverter(rsrcmgr, retstr, codec=codec, laparams=laparams)
    fp = file(path, 'rb')
    interpreter = PDFPageInterpreter(rsrcmgr, device)
    password = ""
    maxpages = 0
    caching = True
    pagenos=set()
    i = 1
    for page in PDFPage.get_pages(fp, pagenos, maxpages=maxpages, password=password,caching=caching, check_extractable=True):
        interpreter.process_page(page)
        if i == 1:
            break
    fp.close()
    device.close()
    str = retstr.getvalue()
    x= str.split('\n')[:5]
    print x
    retstr.close()
    # flaglist = []
    
    # for name in namelist:
    #     if name.lower() in str.lower():
    #         flaglist.append("True")
    #         continue
    # if len(flaglist)==len(namelist):
    #     return True
    # return False

back_up_1 = "/Users/Jingyuan/Documents/backup1"
unprocessed = '/Users/Jingyuan/Documents/unprocessed'
def find_people():
    #namelist = people.namelist
    #print namelist
    #filelist = []
    for root, directories, files in os.walk(back_up_1):
        for filename in files:
            filepath = os.path.join(root, filename)
            try:
                
                if filename.endswith('.pdf'):
                    print filename
                    find_pdf(filepath)                    
                # if checkname(namelist, filename):
#                     filelist.append(filepath)
#                     break
#                 else:
#                     if filename.endswith('.pdf'):
#                         if find_pdf(namelist, filepath):
#                             filelist.append(filepath)
#                             break
#                     elif (filename.endswith('.rtf') or filename.endswith('.doc')):
#                         if find_rtf(namelist, filepath):
#                             filelist.append(filepath)
#                             break
#                     elif (filename.endswith('.docx')):
#                         if find_docx(namelist, filepath):
#                             filelist.append(filepath)
#                             break                                             
            except Exception,e:
                print str(e)
                shutil.copy(filepath, unprocessed)
           # elif filename.endswith('.doc'):    
    #return filelist
find_people()

# f = open(path, 'r')
# lines = f.readlines()
# for line in lines:
#     print line.split('\t')
# f = open(path,'r')
# file = f.readlines()
# for line in file:
#     x = line.split("\\")
#     for l in x:
#
# f.close()
# print file
    
# name = "Louisiana"
# for i in range(1,4):
#     print i
#     for line in file:
#         if name.lower() in line.lower():
#             print name
#             break


# def find_pdf(namelist, path):
#     rsrcmgr = PDFResourceManager()
#     retstr = StringIO()
#     codec = 'utf-8'
#     laparams = LAParams()
#     device = TextConverter(rsrcmgr, retstr, codec=codec, laparams=laparams)
#     fp = file(path, 'rb')
#     interpreter = PDFPageInterpreter(rsrcmgr, device)
#     password = ""
#     maxpages = 0
#     caching = True
#     pagenos=set()
#     i=1
#     for page in PDFPage.get_pages(fp, pagenos, maxpages=maxpages, password=password,caching=caching, check_extractable=True):
#         print page
#         interpreter.process_page(page)
#         if i==1:
#             break
#     fp.close()
#     device.close()
#     str = retstr.getvalue()
#     print str
#     retstr.close()
#     flaglist = []
#     for name in namelist:
#         print name
#         if name.lower() in str.lower():
#             flaglist.append("True")
#             continue
#     if len(flaglist)==len(namelist):
#         return True
#     else:
#         return False
# #
# #
# path = '/Users/Jingyuan/Documents/tim_ororke.pdf'
# print find_pdf(['tim','O\'Rorke'], path)
    
       