import logging
import logging.config
import traceback
from logging.handlers import RotatingFileHandler

# logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', datefmt='%m/%d/%Y %H:%M:%S')
# logging.debug('This is a debug message')
# logging.info('This is a info message')
# logging.warning('This is a warning message')
# logging.error('This is a error message')
# logging.critical('This is a critical message')

# import helper

# logging.config.fileConfig('logging.conf')

# logger = logging.getLogger('simpleExample')
# logger.debug('This is a debug message from logging_main.py')

# try:
#   a = [1,2,3]
#   val = a[4]
# except IndexError as e:
#   logging.error(e, exc_info=True)
# except:
#   logging.error("The error is %s", traceback.format_exc())

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# roll over 2kb, and keep backup logs app.log.1, app.log.2...
handler = RotatingFileHandler('app.log', maxBytes=2000, backupCount=5)
logger.addHandler(handler)

for i in range(10000):
  logger.info(f"Hello world! Info line {i+1}")