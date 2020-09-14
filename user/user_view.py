from flask import request, jsonify, g
from utils.utils import login_decorator


class UserView:
    def create_endpoint(app, services):
        user_service = services.user_service

        @app.errorhandler(400)
        def http_400_bad_request(error):
            response = jsonify({'message': error.description})
            response.status_code = 400
            return response

        @app.errorhandler(401)
        def http_401_unauthorized(error):
            response = jsonify({'message': error.description})
            response.status_code = 401
            return response

        @app.errorhandler(404)
        def http_404_not_found(error):
            response = jsonify({'message': error.description})
            response.status_code = 404
            return response

        @app.route("/user/signup", methods=['POST'])
        def sign_up():
            """회원가입 뷰

                Authors:
                    hiyv7272@gmail.com (황인용)

                Response:
                    200: Success
                    400: INVALID_KEY
                    400: INVAILD_DATA
                    500: server error
            """
            data = request.json
            user_service.signup(data)

            return jsonify({'message': 'SUCCESS'})

        @app.route("/user/signin", methods=['POST'])
        def sign_in():
            """로그인 뷰

                Authors:
                    hiyv7272@gmail.com (황인용)

                Request Body:
                    email: test@test.com
                    password: qwer1234

                Response:
                    200: Success
                    400: INVALID_KEY
                    400: NOT_EXISTS_USER
                    400: INVALID_USER
                    400: INVAILD_DATA
                    500: server error

                Returns:
                    access_token: Access_Token
            """
            data = request.json
            user_info = user_service.signin(data)
            token = user_service.generate_access_token(user_info)

            return jsonify({'access_token': token})

        @app.route('/user/profile', methods=['GET'])
        @login_decorator
        def user_profile():
            """사용자_프로필 뷰

                Authors:
                    hiyv7272@gmail.com (황인용)

                Request Head:
                    Authorization: Access_Token

                Response:
                    200: Success
                    400: INVALID_KEY
                    400: NOT_EXISTS_USER
                    400: INVAILD_DATA
                    500: server error

                Returns:
                    data: {
                        email: test@test.com
                        name: test_user
                        create_datetime: 2020-09-13 00:00:00
                        update_datetime: 2020-09-14 00:00:00
                    }
            """
            user_info = user_service.user_profile(g.user_info)

            return jsonify({'data': user_info})