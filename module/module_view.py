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

        @app.route('/module/datail', methods=['GET'])
        @login_decorator
        def module_detail_list():
            data = dict()
            data['user_id'] = g.user_info['id']
            data['module_id'] = request.args.get('module_id')
            module_detail_list = module_service.module_detail(data)

            return jsonify({'data': module_detail_list})

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