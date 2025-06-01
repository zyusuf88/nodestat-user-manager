import boto3
import pymysql
import os

def lambda_handler(event, context):
    print("Lambda triggered")
    try:
        s3_event = event['Records'][0]['s3']
        bucket = s3_event['bucket']['name']
        key = s3_event['object']['key']
        print(f"Fetching SQL file from s3://{bucket}/{key}")
    except Exception as e:
        print(f"Error parsing event: {e}")
        raise

    try:
        s3 = boto3.client('s3')
        obj = s3.get_object(Bucket=bucket, Key=key)
        sql = obj['Body'].read().decode('utf-8')
        print(f"SQL file downloaded. Length: {len(sql)} chars")
    except Exception as e:
        print(f"Failed to download SQL from S3: {e}")
        raise

    try:
        conn = pymysql.connect(
            host=os.environ['DB_HOST'],
            user=os.environ['DB_USERNAME'],
            password=os.environ['DB_PASSWORD'],
            db=os.environ['DB_NAME'],
            connect_timeout=10
        )
        print("Connected to MySQL")
    except Exception as e:
        print(f"Database connection failed: {e}")
        raise

    try:
        with conn.cursor() as cursor:
            statements = [stmt.strip() for stmt in sql.split(';') if stmt.strip()]
            print(f"Executing {len(statements)} SQL statements")
            for stmt in statements:
                print(f" Running: {stmt[:80]}...")
                cursor.execute(stmt)
            conn.commit()
            print("All statements committed")
    except Exception as e:
        print(f"Error executing SQL: {e}")
        raise
    finally:
        conn.close()
        print("DB connection closed")
