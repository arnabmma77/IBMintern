import json
import boto3

s3_client = boto3.client('s3')

def lambda_handler(event, context):
    try:
        # Handle both proxy and non-proxy inputs
        body = {}

        if 'body' in event and isinstance(event['body'], str):
            try:
                body = json.loads(event['body'])
            except json.JSONDecodeError:
                body = {}
        elif isinstance(event, dict):
            body = event  # non-proxy

        # Fallback if nothing found
        tenant = body.get('tenant')
        username = body.get('username')
        filename = body.get('filename')

        if not tenant or not username or not filename:
            raise Exception("Missing required field (tenant, username, filename)")

        bucket_name = f"{tenant.lower()}-{username.lower()}-storage"

        presigned_post = s3_client.generate_presigned_post(
            Bucket=bucket_name,
            Key=filename,
            Fields={"acl": "private"},
            Conditions=[
                {"acl": "private"},
                ["content-length-range", 0, 10485760]
            ],
            ExpiresIn=300
        )

        return {
            "statusCode": 200,
            "headers": {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
                "Access-Control-Allow-Methods": "*"
            },
            "body": json.dumps(presigned_post)
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "headers": {
                "Access-Control-Allow-Origin": "*"
            },
            "body": json.dumps({ "error": str(e) })
        }
