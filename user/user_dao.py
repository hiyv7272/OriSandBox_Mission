from flask import abort
from datetime import datetime
import mysql.connector
import traceback


class UserDao:
    def __init__(self, database):
        self.db_connection = database.get_connection()

    def insert_user(self, data):
        try:
            db_cursor = self.db_connection.cursor(buffered=True, dictionary=True)

            user_data = dict()
            user_data['email'] = data['email']
            user_data['name'] = data['name']
            user_data['password'] = data['password']
            user_data['create_datetime'] = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            user_data['update_datetime'] = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

            insert_user_query = (
                """
                INSERT INTO USER (
                email, name, password, create_datetime, update_datetime
                ) VALUES (
                %(email)s, %(name)s, %(password)s, %(create_datetime)s, %(update_datetime)s
                )
                """
            )

            db_cursor.execute(insert_user_query, user_data)

            self.db_connection.commit()
            db_cursor.close()

        except KeyError as err:
            traceback.print_exc()
            abort(400, description="INVAILD_KEY")

        except mysql.connector.Error as err:
            traceback.print_exc()
            abort(400, description="INVAILD_DATA")

    def select_user(self, data):
        try:
            db_cursor = self.db_connection.cursor(buffered=True, dictionary=True)

            select_user_query = (
                """
                SELECT id, name, email, password, create_datetime, update_datetime
                FROM   USER
                WHERE 1=1 
                """
            )

            if 'email' in data:
                email = "\'" + str(data['email']) + "\'"
                select_user_query += f' AND email = {email}'

            if 'id' in data:
                id = "\'" + str(data['id']) + "\'"
                select_user_query += f' AND id = {id}'

            db_cursor.execute(select_user_query, data)

            user_info = dict()
            for row in db_cursor:
                user_info['id'] = row['id']
                user_info['email'] = row['email']
                user_info['name'] = row['name']
                user_info['password'] = row['password']
                user_info['create_datetime'] = row['create_datetime']
                user_info['update_datetime'] = row['update_datetime']

            self.db_connection.commit()
            db_cursor.close()

            return user_info

        except KeyError as err:
            traceback.print_exc()
            abort(400, description="INVAILD_KEY")

        except mysql.connector.Error as err:
            traceback.print_exc()
            abort(400, description="INVAILD_DATA")