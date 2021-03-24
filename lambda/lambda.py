import boto3
import os
import sys
import uuid
import requests as r 
import os
from datetime import date, timedelta

bucket = os.environ['bucket']
s3_client = boto3.client('s3')
today = date.today()
first = today.replace(day=1)
previous = first - timedelta(days=1)
date = '/'+previous.strftime('%Y')+ '/'+previous.strftime('%m')


def MyGames():
    user = 'MrFrodo94'
    url = 'https://api.chess.com/pub/player/'
    path= user+'.json'
    response = r.get(url+user+'/games'+date)
    with open('/tmp/'+path,'wb') as f:
        f.write(response.content)
    return path


def lambda_handler(event, context):
    tmp = MyGames()
    s3_client.upload_file('/tmp/'+tmp,bucket,'MyChessGames/'+date+'/'+tmp)
    return True
