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
            data = dict()
            data['user_id'] = g.user_info['id']
            module_list = module_service.module_list(data)

            return jsonify({'data': module_list})

        @app.route('/module/list', methods=['POST'])
        @login_decorator
        def sign_module_producer():
            data = dict()
            data['user_id'] = g.user_info['id']
            data['module_id'] = request.args.get('module_id')
            data['producer_id'] = request.args.get('producer_id')
            module_service.sign_module_producer(data)

            return jsonify({'message': 'SUCCESS'})

        @app.route('/module/list', methods=['DELETE'])
        @login_decorator
        def delete_module_producer():
            data = dict()
            data['user_id'] = g.user_info['id']
            data['module_id'] = request.args.get('module_id')
            data['producer_id'] = request.args.get('producer_id')
            module_service.delete_module_producer(data)

            return jsonify({'message': 'SUCCESS'})

        @app.route('/product/list', methods=['GET'])
        @login_decorator
        def product_list():
            data = dict()
            data['user_id'] = g.user_info['id']
            data['producer_id'] = request.args.get('producer_id')
            product_list = module_service.product_list(data)

            return jsonify({'data': product_list})

        @app.route('/product/feedinfo', methods=['GET'])
        @login_decorator
        def product_feedinfo_list():
            data = dict()
            data['user_id'] = g.user_info['id']
            data['product_id'] = request.args.get('product_id')
            product_detail_list = module_service.product_detail_list(data)

            return jsonify({'data': product_detail_list})