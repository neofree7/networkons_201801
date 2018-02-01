엑셀 로드
pip install xlrd

========================================================================================================================

컬럼명 여러개 변경하기
사전형으로 {key값 : 변경값 , key값 : 변경값} 형태로 코드입력
df.rename(columns={'old_col':'new_col', 'old_col_2':'new_col_2'}, inplace=True)

========================================================================================================================

Jupyter Notebook 화면 조절
http://pinkwink.kr/1039

========================================================================================================================

정규표현식 연습
https://regexr.com

========================================================================================================================

Report.xlsx 예제
cap = pd.read_excel('report.xls', header=1, encoding='euc-kr', parse_cols = 'B, E,F,G,H,I,J,K,L,M,N')
print(cap.shape)
cap.head()
cap.rename(columns={'자치구' : '관서명',
                           '발생' : '살인발생',
                         '검거' : '살인검거',
                         '발생.1' : '강도발생',
                         '검거.1' : '강도검거',
                         '발생.2' : '강간발생',
                         '검거.2' : '강간검거',
                         '발생.3' : '절도발생',
                         '검거.3' : '절도검거',
                         '발생.4' : '폭력발생',
                         '검거.4' : '폭력검거',}, inplace=True)
cap.drop([0], inplace=True)
cap.head()

cap['관서명'].str.replace('구$', '서').head(10)

========================================================================================================================

i-Net 로그인 및 구성원 현황 페이지 소스 확인 크롤링
driver = webdriver.Firefox()
driver.implicitly_wait(3)
# url에 접근한다.
driver.get('https://i-net.networkons.com/Login')
driver.find_element_by_name('userId').send_keys('N1101841')
driver.find_element_by_name('userPass').send_keys('1@dbgustmd')
driver.find_element_by_xpath('//*[@id="wrapper"]/div/div/div/div').click()
driver.implicitly_wait(10)
driver.find_element_by_xpath('//*[@id="popbtnArea"]').click()
driver.get('https://i-net.networkons.com/Coworkers')
print(driver.page_source)

========================================================================================================================

메타트론 크롤링 하여 csv 파일 Down 후 Pandas로 가공 하여 바탕화면에 csv 파일 하고 그래프 이미지 파일 저장 되도록 만들었습니다.
그런데 저장할때 파일명을 현재시간으로 할 수 없는지 궁금 합니다. 그리고 메타트론 실행 후 페이지 소스에 전체 data가 표현이 안되어 csv로 받앗는데..
혹시 바로 긁어 올 수있을까요??
크롬 PSS 는 OKNET에서 5.0 Ver으로 재설치 하면 접속가능 하더군요^^
chromedriver.7z
상위에 있는 코드는 Chrome로 구동 하였습니다. 드라이버 파일 윈도우 폴더에 넣어주세요^^*

import selenium
from selenium import webdriver
import requests
from bs4 import BeautifulSoup

try:
   driver = webdriver.Chrome()
   driver.implicitly_wait(3)
   driver.get('https://discovery.tango.sktelecom.com/sso/login')
   driver.find_element_by_id('id').send_keys('N101841')
   driver.find_element_by_xpath('//*[@id="password"]').send_keys('1!dbgustmd')
   driver.find_element_by_xpath('//*[@id="body"]/div[2]/div/div[2]/div[4]/a').click()
   import time
   time.sleep(3)
   driver.get('https://discovery.tango.sktelecom.com/app/workbench/02f1d59e-c0db-4e36-bc46-01b79baef43b')
   driver.find_element_by_xpath('//*[@id="mainLayout"]/div[2]/div[2]/div[2]/div[3]/div[2]/a[1]/span').click() # 맨 처음 tap 실행됨
   time.sleep(100)
   driver.find_element_by_xpath('//*[@id="csvBtn"]').click()
   time.sleep(20)
finally:
   driver.close()

import pandas as pd
rtwp = pd.read_csv('C:/Users/user/Downloads/RTWP.csv', encoding='cp949')
print(rtwp.shape)
rtwp.rename(columns={'cellname': '국소명',
                    'c_date': '날짜',
                      'CellID':'Cell ID'}, inplace=True)
del rtwp['occr_dt']
del rtwp['lncel']
rtwp_p = (rtwp['nt1']+rtwp['nt2'])
rtwp_a = (rtwp_p // 2)
rtwp['rtwp_a'] = rtwp_a
del rtwp['nt1']
del rtwp['nt2']
rtwp.set_index('국소명', inplace=True)
rtwp.sort_values('rtwp_a', ascending=False, inplace=True)
rtwp.head()

import matplotlib.pyplot as plt
from matplotlib import font_manager, rc
path = 'C:\dev\Data\malgunbd.ttf'
font_name = font_manager.FontProperties(fname=path).get_name()
font_name
rc('font', family=font_name)
rtwp['rtwp_a'].sort_values().plot(kind='barh',grid=True, figsize=(100,100), fontsize=20)

rtwp.to_csv('C:/Users/user/Desktop/rtwp.csv')
rtwp['rtwp_a'].sort_values().plot(kind='barh',grid=True, figsize=(100,100), fontsize=20)
plt.savefig('C:/Users/user/Desktop/sfftwp')

========================================================================================================================

ㅇJupyter Hub에서 Metatron DB 연결하기
from impala.dbapi import connect
from impala.util import as_pandas
import pandas as pd

# DB 연결하기
conn = connect(host='80.80.11.71', port=10000,  auth_mechanism="PLAIN", user='hadoop', password='hadoop' )
cursor = conn.cursor()

quary1= "쿼리문"

cursor.execute(query1)
df_rrc_row = as_pandas(cursor)

========================================================================================================================

일자로부터 요일 알아내기
-- 월요일이 1부터 시작 하여 ~ 일요일까지
select date_format('2016-12-01' ,'u');
-- 만약 일자형태가 다르다면 아래 처럼 년월일 형식을 맞춰서 실행
from_unixtime(unix_timestamp('20140112','yyyyMMdd'),'u');

========================================================================================================================

