from subprocess import Popen, PIPE
from requests import get
from bs4 import BeautifulSoup as bs
from time import sleep

def subprocessCmd(command):
    # Run command in terminal
    process = Popen(command, stdout=PIPE, shell=True)
    proc_stdout = process.communicate()[0].strip()
    return(proc_stdout)

def isOnline():
    ping = subprocessCmd('if ping -c 1 google.com >> /dev/null 2>&1; then echo online; else echo offline; fi;').decode('utf-8')
    if ping == 'offline':
        return False
    else:
        return True

def checkOnline(trials, wait):
    for x in range(trials):
        if isOnline():
            return True
        sleep(wait)
    return False

def getQuote():
    html= get('http://feeds.feedburner.com/brainyquote/QUOTEBR')
    soup = bs(html.text, "html.parser")
    soup_text = soup.get_text()
    findme = 'copyright and fair use.'
    soup_text = soup_text[soup_text.find(findme) + len(findme):].strip('\n')
    author = soup_text[:soup_text.find('\n')].strip('\n')
    soup_text = soup_text[len(author):].strip('\n')
    quote = soup_text[:soup_text.find('\n')].strip('\n')
    return(str(quote) + ' : ' + str(author))

def main():
    if checkOnline(10, 2):
        print(getQuote())
    else:
        print('offline')

main()
