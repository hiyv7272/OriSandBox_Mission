from flask import current_app, abort
from datetime import datetime, timedelta
from collections import OrderedDict

import bcrypt
import jwt


class UserService:
    def __init__(self, user_dao):
        self.user_dao = user_dao

    def signup(self, data):
        try:

            user_info = self.user_dao.select_user(data)
            if not user_info:
                data['password'] = bcrypt.hashpw(data['password'].encode('UTF-8'), bcrypt.gensalt()).decode()

                insert_new_user = self.user_dao.insert_user(data)

            return insert_new_user

        except KeyError:
            abort(400, description="INVALID_KEY")

    def signin(self, data):
        try:
            password = data['password']
            user_info = self.user_dao.select_user(data)

            if not user_info:
                return abort(400, description='NOT_EXISTS_USER')

            if user_info['email'] == data['email']:
                if bcrypt.checkpw(password.encode('UTF-8'), user_info['password'].encode('UTF-8')):
                    return user_info
                else:
                    return abort(400, description="INVALID_USER")
            else:
                abort(400, description="INVALID_USER")

        except KeyError:
            abort(400, description="INVALID_KEY")

    def generate_access_token(self, data):
        payload = {'id': data['id']}
        token = jwt.encode(payload, current_app.config['JWT_SECRET_KEY'], algorithm='HS256')

        return token.decode('UTF-8')

    def user_profile(self, data):

        user_info = self.user_dao.select_user(data)
        user_profile = OrderedDict()
        user_profile['email'] = user_info['email']
        user_profile['name'] = user_info['name']

        user_profile['create_datetime'] = datetime.strftime(user_info['create_datetime'], '%Y-%m-%d %H:%m:%S')
        user_profile['update_datetime'] = datetime.strftime(user_info['update_datetime'], '%Y-%m-%d %H:%m:%S')

        return user_profile
