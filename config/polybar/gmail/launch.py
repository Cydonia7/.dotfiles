#!/usr/bin/env python

import os
import pathlib
import subprocess
import time
import argparse
from apiclient import discovery, errors
from oauth2client import client, file
from httplib2 import ServerNotFoundError

DIR = '/home/thomas.royer/Documents'
CREDENTIALS_PATH = os.path.join(DIR, 'google_credentials.json')

def print_count(count, is_odd=False):
    tilde = '~' if is_odd else ''
    output = ''
    if count > 0:
        output = tilde + str(count)
    else:
        output = tilde.strip()
    print(output)

def update_count():
    gmail = discovery.build('gmail', 'v1', credentials=file.Storage(CREDENTIALS_PATH).get())
    labels = gmail.users().labels().get(userId='me', id='INBOX').execute()
    count = labels['messagesUnread']
    print_count(count)
    return count

try:
    if pathlib.Path(CREDENTIALS_PATH).is_file():
        count_was = update_count()
    else:
        print(error_prefix + 'credentials not found')
except (errors.HttpError, ServerNotFoundError, OSError) as error:
    print_count(0, is_odd=True)
except client.AccessTokenRefreshError:
    print(error_prefix + 'revoked/expired credentials')
