# -*- coding: utf-8 -*-
"""一个从链家上爬取房屋数据的程序
Created on Tue Jan 13 21:49:36 2015

@author wocanmei
"""
import sys
import random
import requests
from bs4 import BeautifulSoup
from bs4.element import Tag


#指定系统默认编码
reload(sys)
sys.setdefaultencoding('utf8')

HOUSE_DIR = './houses.txt'

def get_one_page_house(url):
    print 'Fetching data from ' + url
    r = requests.get(url)
    r.encoding = 'utf8'
    html = r.text
    soup = BeautifulSoup(html)
    hlst = soup.findAll('div', class_='info-panel')
    one_page_house = []
    for h in hlst:
        print '...',
        house = []
        area =  h.parent['data-id'][0:4]
        region = h.find('span',class_='region').string
        zone = h.find('span',class_='zone').string
        meters = h.find('span',class_='meters').string[0:-2]
        direction = h.find('span',class_='meters').next_sibling.string
        direction = (direction if direction != None else '')
        con = h.find('div',class_='con').a.string
        floor = h.find('div',class_='con').contents[2][0:3]
        year = h.find('div',class_='con').contents[4][0:4]
        school = h.find('span',class_='fang05-ex')
        school = ('1' if school != None else '0')
        subway = h.find('span',class_='fang-subway-ex')
        subway = ('1' if subway != None else '0')
        taxfree = h.find('span',class_='taxfree-ex')
        taxfree = (taxfree.string if taxfree != None else '')
        num = h.find('span',class_='num').string
        price = h.find('div',class_='price-pre').string[0:-5]
        house.append(''.join(area.split()))
        house.append(''.join(region.split()))
        house.append(''.join(zone.split()))
        house.append(''.join(meters.split()))
        house.append(''.join(direction.split()))
        house.append(''.join(con.split()))
        house.append(''.join(floor.split()))
        house.append(''.join(year.split()))
        house.append(school)
        house.append(subway)
        house.append(''.join(taxfree.split()))
        house.append(''.join(num.split()))
        house.append(''.join(price.split()))
        one_page_house.append(house)
    print 'done'
    return one_page_house


def write_to_txt(s):
    # 带加号为可读写
    print 'Write to file...',
    hl = open(HOUSE_DIR, 'a')
    hl.write(s)
    hl.close()
    print 'done',


if __name__ == '__main__':
    url_pre = 'http://bj.lianjia.com/ershoufang/pg'
    if len(sys.argv) == 3:
        page_num = int(sys.argv[1])
        total_page_num = int(sys.argv[2])
    else:
        print "Please input how many pages to get and the total number of pages"
        sys.exit(0)
    # 随机的从总页码中抽取一定数量的页
    page_basket = random.sample(xrange(1, total_page_num), page_num)
    i = 0  #对抓取的页数计数
    for p in page_basket:
        url = url_pre + str(p)
        write_to_txt('\n'.join([','.join(h) for h in get_one_page_house(url)]) + '\n')
        i = i + 1
        print '+' + str(i)
