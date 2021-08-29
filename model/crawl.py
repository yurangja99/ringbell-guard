from os import makedirs
from os.path import join, dirname, abspath
import argparse
from datetime import timedelta, timezone, datetime
from PIL import Image
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options
from urllib import request
import time
from tqdm import tqdm

# parse arguments
parser = argparse.ArgumentParser()
parser.add_argument('keyword', type=str, help='Keyword of images')
parser.add_argument('--img-num', '-n', type=int, required=False, default=100, help='Number of images (max 400)')
args = parser.parse_args()

# set basic parameters
keyword = args.keyword
img_num = args.img_num
base_url = 'http://www.google.co.kr/imghp?hl=ko'

# create output directory
now = datetime.now(timezone(timedelta(hours=9))).strftime("%m_%d_%H_%M_%S")
outputs_path = join(dirname(abspath(__file__)), "images")
output_path = join(outputs_path, now)
raw_output_path = join(output_path, "raw")
rgb_output_path = join(output_path, "rgb")
makedirs(output_path, exist_ok=False)
makedirs(raw_output_path, exist_ok=False)
makedirs(rgb_output_path, exist_ok=False)

# set driver options and create driver
options = Options()
#options.add_argument('headless')
#options.add_argument('window-size=1920x1080')
#options.add_argument('disable-gpu')
#options.add_argument('User-agent=Mozilla/5.0')
driver = webdriver.Chrome(
  executable_path=join(dirname(abspath(__file__)), 'chromedriver'),
  options=options
)

# set url request
opener = request.build_opener()
opener.addheaders = [('User-agent', 'Mozilla/5.0')]
request.install_opener(opener)

# search
driver.get(base_url)
elem = driver.find_element_by_name('q')
elem.send_keys(keyword)
elem.send_keys(Keys.RETURN)

# get images
img_components = driver.find_elements_by_css_selector('.rg_i.Q4LuWd')
old_height = driver.execute_script('return document.body.scrollHeight')

while len(img_components) < img_num:
  print(f'numbers of crawled images: {len(img_components)}')

  driver.execute_script('window.scrollTo(0, document.body.scrollHeight);')
  time.sleep(2)
  img_components = driver.find_elements_by_css_selector('.rg_i.Q4LuWd')

  new_height = driver.execute_script('return document.body.scrollHeight')
  if new_height == old_height:
    try:
      driver.find_element_by_css_selector('.mye4qd').click()
    except:
      break
  old_height = new_height

print(f'numbers of crawled images: {len(img_components)}')

# save images
cnt = 0
for img_component in tqdm(img_components):
  try:
    # click and load image
    img_component.click()
    time.sleep(1.5)
    
    # find image and save it
    img_url = driver.find_element_by_xpath('/html/body/div[2]/c-wiz/div[3]/div[2]/div[3]/div/div/div[3]/div[2]/c-wiz/div/div[1]/div[1]/div[2]/div[1]/a/img').get_attribute("src")
    img = request.urlopen(img_url, timeout=5)
    filename = f'{keyword}{cnt}.png'

    with open(join(raw_output_path, filename), 'wb') as f:
      f.write(img.read())
    
    # convert it to RGB image
    stored_img = Image.open(join(raw_output_path, filename)).convert(mode="RGB")
    stored_img.save(join(rgb_output_path, filename))
            
    # if all needed number of images found, exit
    cnt += 1
    if cnt >= img_num:
      break
  except Exception as e:
    print(e)
    pass

print(f'numbers of saved images: {cnt}')
