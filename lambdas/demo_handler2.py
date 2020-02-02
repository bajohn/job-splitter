import logging
from helpers import console_logger

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

def handler(event, context):

    return console_logger('handler 2!')