import json
from boto3 import client
from botocore.exceptions import ClientError
from datetime import datetime
import os
def lambda_handler(event, context):
    polly = client('polly')
    s3 = client('s3')
    try:
        event = json.loads(event['body'])
        text = event.get('text')
        params = {
            'Text': text,
            'OutputFormat': 'mp3',
            'VoiceId': 'Salli'
        }
        response = polly.synthesize_speech(**params)
        key = f"audio-{int(datetime.now().timestamp())}.mp3"
        bucket_name = os.environ.get('my_bucket')
        region = os.environ.get('region')
        s3.put_object(
            Bucket=bucket_name,
            Key=key,
            Body=response['AudioStream'].read(),
            ContentType='audio/mpeg'
        )
        url = f"https://{bucket_name}.s3.{region}.amazonaws.com/{key}"
        return {
            'statusCode': 200,
            'body': json.dumps({"url": url})
        }
    except ClientError as ex:
        return {
            'statusCode': 500,
            'body': json.dumps({"error": str(ex)})
        }