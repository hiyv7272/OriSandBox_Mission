from flask import abort
import mysql.connector
import traceback


class ModuleDao:
    def __init__(self, database):
        self.db_connection = database.get_connection()

    def select_module_list(self, data):
        try:
            db_cursor = self.db_connection.cursor(buffered=True, dictionary=True)

            select_module_list_query = (
                """
                SELECT T101.id, T101.name
                FROM   COSGRAM.MODULE AS T101
                       INNER JOIN COSGRAM.USER_PRODUCER_MODULE AS T102
                               ON T101.id = T102.MODULE_id
                              AND T102.is_use = 1
                              AND T102.USER_id = %(user_id)s
                GROUP BY T101.id, T101.name
                """
            )

            db_cursor.execute(select_module_list_query, data)
            module_list_info = db_cursor.fetchall()

            return module_list_info

        except KeyError as err:
            traceback.print_exc()
            abort(400, description="INVAILD_KEY")

        except mysql.connector.Error as err:
            traceback.print_exc()
            abort(400, description="INVAILD_DATA")

    def select_module_detail(self, data):
        try:
            db_cursor = self.db_connection.cursor(buffered=True, dictionary=True)

            select_module_detail_query = (
                """
                SELECT T103.id AS producer_id, T103.name AS producer_name, T102.id AS module_id, T102.name AS module_name
                FROM   COSGRAM.USER_PRODUCER_MODULE AS T101
                       INNER JOIN COSGRAM.MODULE AS T102
                               ON T101.MODULE_id = T102.id
                              AND T102.id = %(module_id)s
                              AND T102.is_use = 1
                       INNER JOIN COSGRAM.PRODUCER AS T103
                               ON T101.PRODUCER_id = T103.id
                              AND T103.is_use = 1
                WHERE T101.USER_id = %(user_id)s
                """
            )

            db_cursor.execute(select_module_detail_query, data)
            module_detail_list_info = db_cursor.fetchall()

            return module_detail_list_info

        except KeyError as err:
            traceback.print_exc()
            abort(400, description="INVAILD_KEY")

        except mysql.connector.Error as err:
            traceback.print_exc()
            abort(400, description="INVAILD_DATA")

    def select_product_module(self, data):
        try:
            db_cursor = self.db_connection.cursor(buffered=True, dictionary=True)

            select_product_module_query = (
                """
                SELECT T101.id AS product_id, T101.PRODUCER_id, T101.MODULE_id, T101.name AS product_name,
                       T102.id AS module_id, T102.name AS module_name
                FROM   COSGRAM.PRODUCT AS T101
                       INNER JOIN COSGRAM.MODULE AS T102
                               ON T101.MODULE_id = T102.id
                              AND T102.is_use
                WHERE  T101.id = %(product_id)s
                """
            )

            db_cursor.execute(select_product_module_query, data)
            product_module_info = db_cursor.fetchone()

            print('product_module_info:', product_module_info)

            return product_module_info

        except KeyError as err:
            traceback.print_exc()
            abort(400, description="INVAILD_KEY")

        except mysql.connector.Error as err:
            traceback.print_exc()
            abort(400, description="INVAILD_DATA")

    def select_product_list(self, data):
        try:
            db_cursor = self.db_connection.cursor(buffered=True, dictionary=True)

            select_product_list_query = (
                """
                SELECT id, name, PRODUCER_id, MODULE_id, regist_datetime, update_datetime, is_use
                FROM   COSGRAM.PRODUCT
                WHERE  PRODUCER_id = %(producer_id)s
                AND    is_use = 1
                """
            )

            db_cursor.execute(select_product_list_query, data)
            product_list_info = db_cursor.fetchall()

            return product_list_info

        except KeyError as err:
            traceback.print_exc()
            abort(400, description="INVAILD_KEY")

        except mysql.connector.Error as err:
            traceback.print_exc()
            abort(400, description="INVAILD_DATA")

    def select_naver_feedinfo(self, data):
        try:
            db_cursor = self.db_connection.cursor(buffered=True, dictionary=True)

            select_naver_feedinfo_query = (
                """
                SELECT T101.id, T101.PRODUCT_id, T101.writer, T101.title, T101.comment, 
                       T101.rate, T101.regist_datetime, T101.update_datetime, T101.is_use,  
                       T102.image_url
                FROM COSGRAM.NAVER_FEEDBACK AS T101
                     INNER JOIN  COSGRAM.NAVER_FEEDBACK_IMAGE AS T102
                             ON  T101.id = T102.NAVER_FEEDBACK_id
                            AND  T102.is_use = 1
                WHERE T101.PRODUCT_id = %(product_id)s
                AND   T101.is_use = 1
                """
            )

            db_cursor.execute(select_naver_feedinfo_query, data)
            naver_feedinfo = db_cursor.fetchall()

            return naver_feedinfo

        except KeyError as err:
            traceback.print_exc()
            abort(400, description="INVAILD_KEY")

        except mysql.connector.Error as err:
            traceback.print_exc()
            abort(400, description="INVAILD_DATA")

    def select_youtube_feedinfo(self, data):
        try:
            db_cursor = self.db_connection.cursor(buffered=True, dictionary=True)

            select_youtube_feedinfo_query = (
                """
                SELECT id, writer, comment, regist_datetime, update_datetime, is_use
                FROM   COSGRAM.YOUTUBE_FEEDBACK
                WHERE  PRODUCT_id = %(product_id)s
                """
            )

            db_cursor.execute(select_youtube_feedinfo_query, data)
            youtube_feedinfo = db_cursor.fetchall()

            return youtube_feedinfo

        except KeyError as err:
            traceback.print_exc()
            abort(400, description="INVAILD_KEY")

        except mysql.connector.Error as err:
            traceback.print_exc()
            abort(400, description="INVAILD_DATA")

    def select_amazon_feedinfo(self, data):
        try:
            db_cursor = self.db_connection.cursor(buffered=True, dictionary=True)

            select_amazon_feedinfo_query = (
                """
                SELECT id, PRODUCT_id, writer, title, comment, rate, regist_datetime, update_datetime, is_use 
                FROM COSGRAM.AMAZON_FEEDBACK
                WHERE PRODUCT_id = %(product_id)s
                AND   is_use = 1
                """
            )

            db_cursor.execute(select_amazon_feedinfo_query, data)
            amazon_feedinfo = db_cursor.fetchall()

            return amazon_feedinfo

        except KeyError as err:
            traceback.print_exc()
            abort(400, description="INVAILD_KEY")

        except mysql.connector.Error as err:
            traceback.print_exc()
            abort(400, description="INVAILD_DATA")