from dataclasses import dataclass
import dataclasses
import datetime
import xml.etree.ElementTree as ET
import json
import os
import sys
from typing import Dict, List, Optional
from rauth.service import OAuth1Service, OAuth1Session

@dataclass  
class User:
  name: str
  user_id: int

@dataclass
class Book:
  book_id: str
  work_id: str
  url: str
  title: str
  image_url: Optional[str]
  started_at: Optional[str]
  top_shelves: List[str]
  authors: List[str]

class Goodreads:
  base_url = 'https://www.goodreads.com'
  oauth_url = base_url + '/oauth'
  api_url = base_url + '/api'
  request_token_url = oauth_url + '/request_token'
  authorize_url = oauth_url + '/authorize'
  access_token_url = oauth_url + '/access_token'
    
  def __init__(
      self,
      consumer_key: str, 
      consumer_secret: str, 
      access_token: Optional[str] = None,
      access_token_secret: Optional[str] = None):
      
    self.consumer_key = consumer_key
    self.consumer_secret = consumer_secret
    self.access_token = access_token
    self.access_token_secret = access_token_secret

    self.client = OAuth1Service(
      consumer_key = consumer_key,
      consumer_secret = consumer_secret,
      name='goodreads',
      request_token_url = Goodreads.request_token_url,
      authorize_url = Goodreads.authorize_url,
      access_token_url = Goodreads.access_token_url,
      base_url = Goodreads.base_url)
      
    if self.access_token and self.access_token_secret:
        self.session = OAuth1Session(
        consumer_key = self.consumer_key,
        consumer_secret = self.consumer_secret,
        access_token = self.access_token,
        access_token_secret = self.access_token_secret)
    else:
      self.session = None
      
    self._current_user: Optional[User] = None
  
  def get_config(self) -> Dict[str, str]:
    return {
      'consumer_key': self.consumer_key,
      'consumer_secret': self.consumer_secret,
      'access_token': self.access_token,
      'access_token_secret': self.access_token_secret
    }
  
  def _ensure_session(self):
    if self.session:
      return
    request_token, request_token_secret = self.client.get_request_token(header_auth=True)
    authorize_url = self.client.get_authorize_url(request_token)
    input ('Visit this URL in your browser and press enter: ' + authorize_url)
    session = self.client.get_auth_session(
      request_token,
      request_token_secret)
    self.access_token = session.access_token
    self.access_token_secret = session.access_token_secret

  def _get(self, url: str) -> ET.Element:
    self._ensure_session()
    response = self.session.get(url)
    if response.status_code != 200:
      raise Exception("Error from Goodreads: " + response.text)
    return ET.fromstring(response.text)

  def get_user(self) -> User:
    if self._current_user:
      return self._current_user
    tree = self._get(Goodreads.api_url + '/auth_user')
    user_element = tree.find('user')
    user_id = user_element.attrib['id']
    user_name = user_element.find('name').text
    self._current_user = User(user_id=user_id, name=user_name)
    return self._current_user

  def get_book_details(self, book_id: int) -> ET.Element:
    url = f'{Goodreads.base_url}/book/show/{book_id}.xml?key={self.consumer_key}'
    tree = self._get(url)
    return tree.find('book')

  def get_books_on_shelf(self, shelf_name: str):
    user = self.get_user()
    url = f'{Goodreads.base_url}/review/list/{user.user_id}.xml?v=2&shelf={shelf_name}'
    tree = self._get(url)
    reviews = tree.find('reviews').findall('review')
    fmt = '%a %b %d %H:%M:%S %z %Y'
    books: List[Book] = []
    for review in reviews:
      book_element = review.find('book')
      if not book_element:
        continue
      book_id = book_element.find('id').text
      work_id = book_element.find('work').find('id').text
      book_url = book_element.find('link').text
      book_title = book_element.find('title').text
      small_image = book_element.find('small_image_url').text
      image = book_element.find('image_url').text
      large_image = book_element.find('large_image_url').text
      image = large_image or image or small_image
      book_image_url = image if image else None
      started_at = review.find('started_at')
      authors: List[str] = []
      for author in book_element.find('authors').findall('author'):
        authors.append(author.find('name').text)
      top_shelves = []
      
      book = Book(
        book_id=book_id,
        work_id=work_id,
        url=book_url,
        title=book_title,
        image_url=image if image else None,
        started_at=datetime.datetime.isoformat(datetime.datetime.strptime(started_at.text, fmt)) if started_at != None else None,
        top_shelves=top_shelves,
        authors=authors)
    books.append(book)  
    return books
      
  
  def get_currently_reading(self):
    return self.get_books_on_shelf('currently-reading')
    
CURRENT_DIR = os.path.dirname(__file__)
CONFIG_FILE_NAME = 'goodreads_config.json'
CONFIG_FILE_PATH = os.path.join(CURRENT_DIR, CONFIG_FILE_NAME)
config = {}

if not os.path.isfile(CONFIG_FILE_PATH):
  print(f'Config file not founds. Should be at "{CONFIG_FILE_PATH}"')
  sys.exit(1)
with open(CONFIG_FILE_PATH) as cf:
  config = json.load(cf)

ACCESS_TOKEN = None
if 'access_token' in config and config['access_token']:
  ACCESS_TOKEN = config['access_token']

ACCESS_TOKEN_SECRET = None
if 'access_token_secret' in config and config['access_token_secret']:
  ACCESS_TOKEN_SECRET = config['access_token_secret']
  

if 'consumer_key' not in config or not config['consumer_key'] or 'consumer_secret' not in config or not config['consumer_secret']:
  print('Please provide the keys "consumer_key" and "consumer_secret" in your config file')
  sys.exit(1)
CONSUMER_KEY = config['consumer_key']
CONSUMER_SECRET = config['consumer_secret']

gr = Goodreads(
    consumer_key=CONSUMER_KEY,
    consumer_secret=CONSUMER_SECRET,
    access_token=ACCESS_TOKEN,
    access_token_secret=ACCESS_TOKEN_SECRET)
books = gr.get_currently_reading()

with open(CONFIG_FILE_PATH, 'w') as cf:
  json.dump(gr.get_config(), cf, indent=2)

with open(os.path.join(CURRENT_DIR, 'currently_reading.json'), 'w') as cf:
  json.dump([dataclasses.asdict(b) for b in books], cf, indent=2)
        