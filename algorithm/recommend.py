import sys
import pymysql
import numpy as np
import pandas as pd
from UserSimCalc import UserSimilarity

## argument를 받아야 하는 부분
#my_id = sys.argv
my_id = 'tr45tga91o8349u'


## mysql 에 접속하여 sql문을 이용하여 원하는 정보를 가져옴
conn = pymysql.connect(host='34.85.53.214',
                       user='root',
                       password='1234',
                       charset='utf8')

curs = conn.cursor(pymysql.cursors.DictCursor)

sql = "select * from chemi.user_info where chemi_type_qa is not null"
curs.execute(sql)
user_info = curs.fetchall()

## 연결 종료
conn.close()

## 추천
user_table = pd.DataFrame.from_dict(user_info).set_index(['id'],drop = True)

_dict = {}
for info in user_info:
    if info['id'] == my_id:
        my_gender = info['gender']
        my_local = info['local']
        my_chemi_type = info['chemi_type_qa']
    _list = []
    for i in range(9):
        _list.append(int(info['chemi_type_qa'][i]))
    _dict['{}'.format(info['id'])] = _list
    
recommend_table = pd.DataFrame.from_dict(_dict, orient = 'index',columns = [i for i in range(1,10)])
user_sim = UserSimilarity(recommend_table-0.5)
user_sim.cosweight(my_id).head().index

## 최종 리턴을 어떻게 할 것인지 고려해야함