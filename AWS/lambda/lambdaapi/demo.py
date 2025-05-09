import json
from boto3 import resource
def lambda_handler(event, context):
    try:
        db = resource('dynamodb')
        table = db.Table('test')
        table.put_item(
            Item = {
                'name': event['name'],
                'email': event['email'],
                'message': event['message']
            }
        )
        return {
            'statusCode': 200,
            'body': json.dumps('Insertion Successful')
        }
    except Exception as ex:
        return {
            'statusCode': 400,
            'body': str(ex)
        }