import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

def handler():

    logger.info('Hello, world.')
    logger.info('Hello, world?')
    return True