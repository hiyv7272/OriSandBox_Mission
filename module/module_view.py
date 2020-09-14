from flask import request, jsonify, g
from utils.utils import login_decorator


class ModuleView:
    def create_endpoint(app, services):
        module_service = services.module_service

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

        @app.route('/module/list', methods=['GET'])
        @login_decorator
        def module_list():
            """모듈_리스트 뷰

                Authors:
                    hiyv7272@gmail.com (황인용)

                Request Head:
                    Authorization: Access_Token

                Response:
                    200: Success
                    400: INVALID_KEY
                    400: INVAILD_DATA
                    500: server error

                Returns:
                    data: [
                        {
                            module_id:
                            module_name:
                            producers:[
                                {
                                    id: 1,
                                    name: '제작자_A'
                                },
                            ]
                        },
                    ]
            """
            data = dict()
            data['user_id'] = g.user_info['id']
            module_list = module_service.module_list(data)

            return jsonify({'data': module_list})

        @app.route('/module/list', methods=['POST'])
        @login_decorator
        def sign_module_producer():
            """모듈_리스트 가입 뷰

                 Authors:
                     hiyv7272@gmail.com (황인용)

                 Request Head:
                     Authorization: Access_Token

                 Request Params:
                    module_id: 1
                    producer_id: 2

                 Response:
                     200: Success
                     400: INVALID_KEY
                     400: INVAILD_DATA
                     500: server error

                 Returns:
                     message: Success
             """
            data = dict()
            data['user_id'] = g.user_info['id']
            data['module_id'] = request.args.get('module_id')
            data['producer_id'] = request.args.get('producer_id')
            module_service.sign_module_producer(data)

            return jsonify({'message': 'SUCCESS'})

        @app.route('/module/list', methods=['DELETE'])
        @login_decorator
        def delete_module_producer():
            """모듈_리스트 해제 뷰

                 Authors:
                     hiyv7272@gmail.com (황인용)

                 Request Head:
                     Authorization: Access_Token

                 Request Params:
                    module_id: 1
                    producer_id: 2

                 Response:
                     200: Success
                     400: INVALID_KEY
                     400: INVAILD_DATA
                     500: server error

                 Returns:
                     message: Success
             """
            data = dict()
            data['user_id'] = g.user_info['id']
            data['module_id'] = request.args.get('module_id')
            data['producer_id'] = request.args.get('producer_id')
            module_service.delete_module_producer(data)

            return jsonify({'message': 'SUCCESS'})

        @app.route('/product/list', methods=['GET'])
        @login_decorator
        def product_list():
            """제작자상품_리스트 뷰

                 Authors:
                     hiyv7272@gmail.com (황인용)

                 Request Head:
                     Authorization: Access_Token

                 Request Params:
                    producer_id: 1

                 Response:
                     200: Success
                     400: INVALID_KEY
                     400: INVAILD_DATA
                     500: server error

                 Returns:
                    data: [
                        {
                            id: 1,
                            name: "나이키 에어 테일윈드 79 487754-100",
                            regist_datetime: "2020-05-29 00:05:00",
                            update_datetime: "2020-09-13 00:00:00"
                        },
                        {
                            id: 2
                            name: "뉴발란스 327 블랙 화이트 MS327CPG"
                            regist_datetime: "2020-08-30 00:00:00",
                            update_datetime: "2020-09-13 00:00:00"
                        }
                    ]
             """
            data = dict()
            data['user_id'] = g.user_info['id']
            data['producer_id'] = request.args.get('producer_id')
            product_list = module_service.product_list(data)

            return jsonify({'data': product_list})

        @app.route('/product/feedinfo', methods=['GET'])
        @login_decorator
        def product_feedinfo_list():
            """상품피드백_리스트 뷰

                 Authors:
                     hiyv7272@gmail.com (황인용)

                 Request Head:
                     Authorization: Access_Token

                 Request Params:
                     product_id: 1

                 Response:
                     200: Success
                     400: INVALID_KEY
                     400: INVAILD_DATA
                     500: server error

                 Returns:
                    data: [
                        {
                            "id": 1,
                            "title": "사람들 마다 한사이즈 업이네 다운이네 하시는데... 저는 250이 딱 맞습니다^^ (딱 맞게 신는 스타일..신발 긴거 싫어해요ㅋㅋ 그래도 발끝 살짝 남아요.)  신발이 길고 볼이 ",
                            "writer": "ball****",
                            "comment": "~~ 어짜피 신발이 조금 긴 스타일이니 정사이즈로 구매 하셔도 될듯 해요. 볼은 꽉끼는 소재가 아녀서 좀 신다보면 발에 편하게 적응 되실겁니다. 그리고 중국에서 들어오는 쓰레기 제품과는 차원이 다른 고품질 정품입니다~!!! 가끔 보면 5만원 6만원 주고 구입하면서 무슨 정품을 바란답니까.. 쿠× 뭐 이런데 가면 싸긴한데 정품이 아닌 다른 제품이 간다든지.. 반품 비용이 신발값 보다 더 많이 든다던지...배송도 얼마나 걸릴지 모르는 중국발 데일윈드(짝퉁).. 암튼.. ",
                            "rate": 5,
                            "images": [
                                "https://phinf.pstatic.net/checkout.phinf/20200529_190/1590725607943w7cTj_JPEG/20200529_130243.jpg?type=f287",
                                "https://phinf.pstatic.net/checkout.phinf/20200602_143/1591077881583gQI6g_JPEG/20200530_002227.jpg?type=f287"
                            ]
                        },
                        {
                            "id": 1,
                            "title": "사람들 마다 한사이즈 업이네 다운이네 하시는데... 저는 250이 딱 맞습니다^^ (딱 맞게 신는 스타일..신발 긴거 싫어해요ㅋㅋ 그래도 발끝 살짝 남아요.)  신발이 길고 볼이 ",
                            "writer": "ball****",
                            "comment": "~~ 어짜피 신발이 조금 긴 스타일이니 정사이즈로 구매 하셔도 될듯 해요. 볼은 꽉끼는 소재가 아녀서 좀 신다보면 발에 편하게 적응 되실겁니다. 그리고 중국에서 들어오는 쓰레기 제품과는 차원이 다른 고품질 정품입니다~!!! 가끔 보면 5만원 6만원 주고 구입하면서 무슨 정품을 바란답니까.. 쿠× 뭐 이런데 가면 싸긴한데 정품이 아닌 다른 제품이 간다든지.. 반품 비용이 신발값 보다 더 많이 든다던지...배송도 얼마나 걸릴지 모르는 중국발 데일윈드(짝퉁).. 암튼.. ",
                            "rate": 5,
                            "images": [
                                "https://phinf.pstatic.net/checkout.phinf/20200529_190/1590725607943w7cTj_JPEG/20200529_130243.jpg?type=f287",
                                "https://phinf.pstatic.net/checkout.phinf/20200602_143/1591077881583gQI6g_JPEG/20200530_002227.jpg?type=f287"
                            ]
                        },
                    ]
             """
            data = dict()
            data['user_id'] = g.user_info['id']
            data['product_id'] = request.args.get('product_id')
            product_detail_list = module_service.product_detail_list(data)

            return jsonify({'data': product_detail_list})