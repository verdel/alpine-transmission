#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
from subprocess import call

if __name__ == '__main__':
    text = 'Torrent complete: {}.'.format(os.getenv('TR_TORRENT_NAME'))
    call(["telegram-send", "--config", "/opt/telegram-send/receiver.conf", text])
