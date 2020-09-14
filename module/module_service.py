from flask import abort
from datetime import datetime


class ModuleService:
    def __init__(self, module_dao):
        self.module_dao = module_dao

    def module_list(self, data):
        module_list_info = self.module_dao.select_module_list(data)

        module_list = list()
        for row in module_list_info:
            dict_data = dict()
            dict_data['module_id'] = row['id']
            dict_data['module_name'] = row['name']
            dict_data['producers'] = list()

            module_list.append(dict_data)

        module_detail_list_info = self.module_dao.select_module_detail(data)
        for el in module_list:
            for row in module_detail_list_info:

                if el['module_id'] == row['module_id']:
                    dict_data = dict()
                    dict_data['id'] = row['producer_id']
                    dict_data['name'] = row['producer_name']
                    el['producers'].append(dict_data)

        return module_list

    def sign_module_producer(self, data):
        try:
            return self.module_dao.insert_user_producer_module(data)

        except KeyError:
            abort(400, description="INVALID_KEY")

    def delete_module_producer(self, data):
        try:
            return self.module_dao.delete_user_producer_module(data)

        except KeyError:
            abort(400, description="INVALID_KEY")

    def product_list(self, data):
        try:
            product_list_info = self.module_dao.select_product_list(data)
            product_list = list()
            for row in product_list_info:
                dict_data = dict()
                dict_data['id'] = row['id']
                dict_data['name'] = row['name']
                dict_data['regist_datetime'] = datetime.strftime(row['regist_datetime'], '%Y-%m-%d %H:%m:%S')
                dict_data['update_datetime'] = datetime.strftime(row['update_datetime'], '%Y-%m-%d %H:%m:%S')

                product_list.append(dict_data)

            return product_list

        except KeyError:
            abort(400, description="INVALID_KEY")

    def product_detail_list(self, data):
        try:
            product_module_info = self.module_dao.select_product_module(data)
            if product_module_info:
                if product_module_info['module_name'] == 'NAVER_SHOPPING':
                    naver_product_detail_list_info = self.module_dao.select_naver_feedinfo(data)

                    naver_product_detail_list = list()
                    for row in naver_product_detail_list_info:
                        dict_data = dict()
                        dict_data['id'] = row['id']
                        dict_data['writer'] = row['writer']
                        dict_data['title'] = row['title']
                        dict_data['comment'] = row['comment']
                        dict_data['rate'] = row['rate']
                        dict_data['images'] = list()

                        for subrow in naver_product_detail_list_info:
                            if dict_data['id'] == subrow['id']:
                                dict_data['images'].append(subrow['image_url'])

                        naver_product_detail_list.append(dict_data)

                    return naver_product_detail_list

                if product_module_info['module_name'] == 'YOUTUBE':
                    yotube_product_detail_list_info = self.module_dao.select_youtube_feedinfo(data)

                    youtube_product_detail_list = list()
                    for row in yotube_product_detail_list_info:
                        dict_data = dict()
                        dict_data['id'] = row['id']
                        dict_data['writer'] = row['writer']
                        dict_data['comment'] = row['comment']

                        youtube_product_detail_list.append(dict_data)

                    return youtube_product_detail_list

                if product_module_info['module_name'] == 'AMAZON':
                    amazon_product_detail_list_info = self.module_dao.select_amazon_feedinfo(data)

                    amazon_product_detail_list = list()
                    for row in amazon_product_detail_list_info:
                        dict_data = dict()
                        dict_data['id'] = row['id']
                        dict_data['writer'] = row['writer']
                        dict_data['title'] = row['title']
                        dict_data['comment'] = row['comment']
                        dict_data['rate'] = row['rate']

                        amazon_product_detail_list.append(dict_data)

                    return amazon_product_detail_list

        except KeyError:
            abort(400, description="INVALID_KEY")