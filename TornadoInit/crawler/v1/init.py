# -*- coding: utf-8 -*-

import builtwith
import whois
import urllib2
import re
import itertools
import urlparse
import robotparser

# print builtwith.parse('http://example.webscraping.com/')
print builtwith.parse('https://www.bilibili.com')

print whois.whois('appspot.com')

def robot_parse():
    rp = robotparser.RobotFileParser()
    rp.set_url('http://example.webscraping.com/robots.txt')
    rp.read()
    url = 'http://example.webscraping.com'
    user_agent = 'BadCrawler'
    rp.can_fetch(user_agent, url)
    user_agent = 'GoodCrawler'
    rp.can_fetch(user_agent, url)

def download(url, user_agent='wswp', num_retries = 2):
    print 'Downloading:', url
    headers = {'User-agent' : user_agent}
    request = urllib2.Request(url, headers=headers)
    try:
#         html = urllib2.urlopen(url).read()
        html = urllib2.urlopen(request).read()
    except urllib2.URLError as e:
        print 'Download error:', e.reason
        html = None
        
        if num_retries > 0 :
            if hasattr(e, 'code') and 500 <= e.code < 600:
                return download(url, num_retries - 1)
        
    return html


def crawl_sitemap(url):
    sitemap = download(url)
    links = re.findall('<loc>(.*?)</loc>', sitemap)
    for link in links:
        html = download(link)

def crawl_id():
    max_errors = 5
    num_errors = 0
    for page in itertools.count(1):
        url = 'http://example.webscraping.com/view/-%d' % page
        html = download(url)
        if html is None:
            num_errors += 1
            if num_errors == max_errors:
                break
        else:
            num_errors = 0    

def link_crawler(seed_url, link_regex):
    crawl_queue = [seed_url]
    seen = set(crawl_queue)
    while crawl_queue:
        url = crawl_queue.pop()
#         if rp.can_fetch(user_agent, url):
#         else:
            
        html = download(url)
        for link in get_links(html):
#             print link
            if re.match(link_regex, link):
                link = urlparse.urljoin(seed_url, link)
                if link not in seen:
                    seen.add(link)
                    crawl_queue.append(link)
        
def get_links(html):
    webpage_regex = re.compile('<a[^>]+href=["\'](.*?)["\']', re.IGNORECASE)
    return webpage_regex.findall(html)    
        
        
if __name__ == '__main__':
#     crawl_sitemap('http://example.webscraping.com/sitemap.xml')
    link_crawler('http://example.webscraping.com', '/places/default/(index|view)')
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


